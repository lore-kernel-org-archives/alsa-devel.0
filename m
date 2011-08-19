From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-plugins: Pulse: only underrun if no
 more data has been written
Date: Fri, 19 Aug 2011 11:49:25 +0200
Message-ID: <4E4E31A5.2090100@canonical.com>
References: <4E4D2A67.9050507@canonical.com> <s5hobzllubm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040503050706040000000002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 1A876245CF
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 11:49:27 +0200 (CEST)
In-Reply-To: <s5hobzllubm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040503050706040000000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/19/2011 09:43 AM, Takashi Iwai wrote:
> At Thu, 18 Aug 2011 17:06:15 +0200,
> David Henningsson wrote:
>>
>> With the new/upcoming version of PulseAudio (0.99.x) there is a protocol
>> addition that makes it possible to handle underruns better in the pulse
>> plugin.
>>
>> The attached patch implements that, but it has two flaws I wouldn't mind
>> getting some help with if possible:
>>
>> 1) Since this uses the new API function pa_stream_get_underflow_index,
>> it won't compile with current stable PulseAudio versions, only the
>> upcoming version.
>
> Any way (like ifdef some constant or a version number) to detect in
> build time, or do we need to check it in configure script?

I don't mess around with autotools that often, but I think I got it 
working (see attached patch)

>
>> 2) So now there are three possibilities for handle_underrun ( 0 = never,
>> 1 = always, 2 = the new improved one that IMO should be used). Since
>> handle_underrun is a bool in the config, it can not be set to "2", only
>> 0 or 1.
>
> Changing the value syntax doesn't sound good.
> IMO, better to add another option to enable/disable the advanced
> underrun handling.

Ok, I have now done so in the attached patch.

>
>
> thanks,
>
> Takashi
>
>
>> --
>> David Henningsson, Canonical Ltd.
>> http://launchpad.net/~diwic
>> [2 0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.patch<text/x-patch (7bit)>]
>> > From 4e31ba395b751a6ab3254256dc8a227b3be67932 Mon Sep 17 00:00:00 2001
>> From: David Henningsson<david.henningsson@canonical.com>
>> Date: Tue, 2 Aug 2011 14:49:04 +0200
>> Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more data has been written
>>
>> If more data has already been written after the underrun, the underrun
>> will automatically end and therefore we should not report it or
>> restart the stream.
>>
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>   pulse/pcm_pulse.c |   10 +++++++---
>>   1 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
>> index d6c6792..9c4a7e5 100644
>> --- a/pulse/pcm_pulse.c
>> +++ b/pulse/pcm_pulse.c
>> @@ -39,9 +39,10 @@ typedef struct snd_pcm_pulse {
>>   	size_t last_size;
>>   	size_t ptr;
>>   	int underrun;
>> -	int handle_underrun;
>> +	int handle_underrun; /* can be 0=never, 1=always or 2=only if more data has not been written */
>>
>>   	size_t offset;
>> +	int64_t written;
>>
>>   	pa_stream *stream;
>>
>> @@ -459,6 +460,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
>>   	}
>>
>>   	/* Make sure the buffer pointer is in sync */
>> +	pcm->written += writebytes;
>>   	pcm->last_size -= writebytes;
>>   	ret = update_ptr(pcm);
>>   	if (ret<  0)
>> @@ -594,7 +596,8 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
>>   	if (!pcm->p)
>>   		return;
>>
>> -	pcm->underrun = 1;
>> +	if (pcm->handle_underrun == 1 || pcm->written<= pa_stream_get_underflow_index(p))
>> +		pcm->underrun = 1;
>>   }
>>
>>   static void stream_latency_cb(pa_stream *p, void *userdata) {
>> @@ -691,6 +694,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
>>   		goto finish;
>>   	}
>>
>> +	pcm->written = 0;
>>   	pa_stream_set_state_callback(pcm->stream, stream_state_cb, pcm);
>>   	pa_stream_set_latency_update_callback(pcm->stream, stream_latency_cb, pcm);
>>
>> @@ -983,7 +987,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
>>   	const char *server = NULL;
>>   	const char *device = NULL;
>>   	const char *fallback_name = NULL;
>> -	int handle_underrun = 0;
>> +	int handle_underrun = 2;
>>   	int err;
>>   	snd_pcm_pulse_t *pcm;
>>
>> --
>> 1.7.4.1
>>
>> [3<text/plain; us-ascii (7bit)>]
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040503050706040000000002
Content-Type: text/x-patch;
 name="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-plugins-Pulse-only-underrun-if-no-more-data-has.pa";
 filename*1="tch"

>From 8098c77a447a80d2860588387d18b3aa6d23b6bb Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 19 Aug 2011 11:47:07 +0200
Subject: [PATCH] alsa-plugins: Pulse: only underrun if no more data has been
 written

If more data has already been written after the underrun, the underrun
will automatically end and therefore we should not report it or
restart the stream.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 configure.in      |    7 +++++++
 pulse/pcm_pulse.c |   28 ++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index ccf59ba..f6886b1 100644
--- a/configure.in
+++ b/configure.in
@@ -31,8 +31,14 @@ AC_ARG_ENABLE([pulseaudio],
 
 if test "x$enable_pulseaudio" != "xno"; then
   PKG_CHECK_MODULES(pulseaudio, [libpulse >= 0.9.11], [HAVE_PULSE=yes], [HAVE_PULSE=no])
+  PKG_CHECK_MODULES(pulseaudio_099, [libpulse >= 0.99.1], 
+    [HAVE_PULSE_UNDERRUN_INDEX=yes], [HAVE_PULSE_UNDERRUN_INDEX=no])
+  
 fi
 AM_CONDITIONAL(HAVE_PULSE, test x$HAVE_PULSE = xyes)
+if test "$HAVE_PULSE_UNDERRUN_INDEX" = "yes"; then
+  AC_DEFINE([HAVE_PULSE_UNDERRUN_INDEX], 1, Pulseaudio underrun index available)
+fi 
 
 AC_ARG_ENABLE([samplerate],
       AS_HELP_STRING([--disable-samplerate], [Disable building of samplerate plugin]))
@@ -185,6 +191,7 @@ echo "Pulseaudio plugin:  $HAVE_PULSE"
 if test "$HAVE_PULSE" = "yes"; then
   echo "  pulseaudio_CFLAGS: $pulseaudio_CFLAGS"
   echo "  pulseaudio_LIBS: $pulseaudio_LIBS"
+  echo "  pulseaudio underrun index: $HAVE_PULSE_UNDERRUN_INDEX" 
 fi
 echo "Samplerate plugin:  $HAVE_SAMPLERATE"
 if test "$HAVE_SAMPLERATE" = "yes"; then
diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index d6c6792..61f1c0c 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -26,6 +26,10 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include "pulse.h"
 
 typedef struct snd_pcm_pulse {
@@ -39,9 +43,10 @@ typedef struct snd_pcm_pulse {
 	size_t last_size;
 	size_t ptr;
 	int underrun;
-	int handle_underrun;
+	int handle_underrun; /* can be 0=never, 1=always or 2,3=only if more data has not been written */
 
 	size_t offset;
+	int64_t written;
 
 	pa_stream *stream;
 
@@ -459,6 +464,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t * io,
 	}
 
 	/* Make sure the buffer pointer is in sync */
+	pcm->written += writebytes;
 	pcm->last_size -= writebytes;
 	ret = update_ptr(pcm);
 	if (ret < 0)
@@ -594,7 +600,12 @@ static void stream_underrun_cb(pa_stream * p, void *userdata)
 	if (!pcm->p)
 		return;
 
-	pcm->underrun = 1;
+	if (pcm->handle_underrun == 1
+#ifdef HAVE_PULSE_UNDERRUN_INDEX
+		|| pcm->written <= pa_stream_get_underflow_index(p)
+#endif
+	)
+		pcm->underrun = 1;
 }
 
 static void stream_latency_cb(pa_stream *p, void *userdata) {
@@ -691,6 +702,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
+	pcm->written = 0;
 	pa_stream_set_state_callback(pcm->stream, stream_state_cb, pcm);
 	pa_stream_set_latency_update_callback(pcm->stream, stream_latency_cb, pcm);
 
@@ -983,7 +995,11 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	const char *server = NULL;
 	const char *device = NULL;
 	const char *fallback_name = NULL;
+#ifdef HAVE_PULSE_UNDERRUN_INDEX
+	int handle_underrun = 2;
+#else
 	int handle_underrun = 0;
+#endif
 	int err;
 	snd_pcm_pulse_t *pcm;
 
@@ -1017,6 +1033,14 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 			handle_underrun = err;
 			continue;
 		}
+		if (strcmp(id, "handle_underrun_detect") == 0) {
+			if ((err = snd_config_get_bool(n)) < 0) {
+				SNDERR("Invalid value for %s", id);
+				return -EINVAL;
+			}
+			handle_underrun = err ? handle_underrun | 2 : handle_underrun & ~2;
+			continue;
+		}
 		if (strcmp(id, "fallback") == 0) {
 			if (snd_config_get_string(n, &fallback_name) < 0) {
 				SNDERR("Invalid value for %s", id);
-- 
1.7.5.4


--------------040503050706040000000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040503050706040000000002--
