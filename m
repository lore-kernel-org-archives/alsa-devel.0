From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Immediate underrun with PulseAudio ALSA plugin
 when PA and ALSA buffer sizes differ
Date: Tue, 17 Jul 2012 10:59:23 +0530
Message-ID: <1342502963.14027.24.camel@localhost>
References: <20120716213855.GE7462@flim.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SIC4KA6ZzIfVp0E2B1JR"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id BA409264F1D
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 07:29:15 +0200 (CEST)
In-Reply-To: <20120716213855.GE7462@flim.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthew Gregan <kinetik@flim.org>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--=-SIC4KA6ZzIfVp0E2B1JR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[x-posting back to pulseaudio-discuss since it's relevant to both lists]

On Tue, 2012-07-17 at 09:38 +1200, Matthew Gregan wrote:
> I'm investigating an issue in Firefox's audio code when the PulseAudio ALSA
> plugin is in use.  I posted about this on pulseaudio-discuss last week
> (http://lists.freedesktop.org/archives/pulseaudio-discuss/2012-July/014091.html),
> but I hoped I might have more success here.
> 
> Firefox requests a particular latency (100ms, 4410 frames at 44.1kHz) via
> snd_pcm_set_params.  Inside the plugin (pcm_pulse.c:pulse_hw_params), that
> value is used to set up buffer_attr.  When the PA stream is connected in
> pcm_pulse.c:pulse_prepare, PA may configure the stream with larger
> buffer_attr values (e.g. because the minimum sink latency has increased over
> time due to underruns on the server, or because the sink hardware doesn't
> support lower latency), but this isn't reflected in pcm->buffer_attr or
> higher layers in ALSA (i.e. pcm->buffer_size is not updated).
> 
> The problem I'm faced with is that there doesn't appear to be a way to
> detect and handle this issue at the ALSA API level, and requesting a too low
> latency results in broken audio playback rather than a PCM setup failure or
> a larger buffer than requested being used.
> 
> In the case of the PA server's minimum latency increasing over time, this
> also means that a stream that was configured and running correctly may break
> while running if PA increases the minimum latency above what the PCM was
> originally configured with.
> 
> I've attached a simple testcase that uses snd_pcm_wait,
> snd_pcm_avail_update, and snd_pcm_writei.  Run it with a latency argument
> specified in milliseconds on the command line.  For my local machine, 55ms
> works and 54ms fails immediately like so:
> 
> snd_pcm_wait wakes
> snd_pcm_avail_update returns 4410
> snd_pcm_writei writes 4410
> snd_pcm_wait wakes immediately
> snd_pcm_avail_update returns -EPIPE
> 
> (Note that when I reported this on pulseaudio-discuss, my server's minimum
> latency was 45ms, and now pacmd list-sinks | grep configured\ latency
> reports a minimum latency of 56ms)
> 
> I'd expect to see one of the following behaviours instead:
> 1. PCM setup fails due to requesting a too small buffer.
> 2. Buffer is silently raised during setup and snd_pcm_avail_update requests
>    the correct number of frames.
> 
> Presumably this could be achieved by having the PA plugin report valid
> values from pcm_pulse.c:pulse_hw_constraint, but I'm not sure how to query
> the necessary values from the server.  This also wouldn't address the
> problem where the buffer_attr changes over time, and I'm not sure what to do
> about that case.

The necessary values are available via pa_stream_get_buffer_attr().
Potentially we could use this in the pulse_pointer() function to update
the corresponding snd_pcm_t's period/buffer sizes, but I don't know if
this is kosher with regards to what alsa-lib expects plugins to be
doing.

If this is not sufficient for the initial update, from what I can see,
snd_pcm_set_params() first sets period/buffer sizes, queries them for
later calculations, and then commits them with snd_pcm_hw_params(). If
we could move the querying to after the params are committed (and in
this case, the stream is connected and buffer attributes are
negotiated), that would solve your problem. Again, I'm not sure what
side-effects this might have, but I've attached a draft untested patch
for it.

Cheers,
Arun

--=-SIC4KA6ZzIfVp0E2B1JR
Content-Disposition: attachment; filename="alsa-lib-late-bufsize-query.patch"
Content-Type: text/x-patch; name="alsa-lib-late-bufsize-query.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 18b43b3..2f35ab2 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7453,18 +7453,8 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
                 	SNDERR("Unable to set buffer size %lu %s: %s", buffer_size, s, snd_strerror(err));
                 	return err;
         	}
-        	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params, &buffer_size);
-        	if (err < 0) {
-        		SNDERR("Unable to get buffer size for %s: %s", s, snd_strerror(err));
-        		return err;
-        	}
 	} else {
 	        /* standard configuration buffer_time -> periods */
-        	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params, &buffer_size);
-        	if (err < 0) {
-        		SNDERR("Unable to get buffer size for %s: %s", s, snd_strerror(err));
-        		return err;
-        	}
         	err = INTERNAL(snd_pcm_hw_params_get_buffer_time)(params, &latency, NULL);
         	if (err < 0) {
         		SNDERR("Unable to get buffer time (latency) for %s: %s", s, snd_strerror(err));
@@ -7477,11 +7467,6 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
         		SNDERR("Unable to set period time %i for %s: %s", period_time, s, snd_strerror(err));
         		return err;
         	}
-                err = INTERNAL(snd_pcm_hw_params_get_period_size)(params, &period_size, NULL);
-                if (err < 0) {
-                	SNDERR("Unable to get period size for %s: %s", s, snd_strerror(err));
-                	return err;
-        	}
         }
 	/* write the parameters to device */
 	err = snd_pcm_hw_params(pcm, params);
@@ -7490,6 +7475,19 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		return err;
 	}
 
+	/* Get final buffer and period sizes after hw params have been set */
+	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params, &buffer_size);
+	if (err < 0) {
+		SNDERR("Unable to get buffer size for %s: %s", s, snd_strerror(err));
+		return err;
+	}
+
+	err = INTERNAL(snd_pcm_hw_params_get_period_size)(params, &period_size, NULL);
+	if (err < 0) {
+		SNDERR("Unable to get period size for %s: %s", s, snd_strerror(err));
+		return err;
+	}
+
 	/* get the current swparams */
 	err = snd_pcm_sw_params_current(pcm, swparams);
 	if (err < 0) {

--=-SIC4KA6ZzIfVp0E2B1JR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-SIC4KA6ZzIfVp0E2B1JR--
