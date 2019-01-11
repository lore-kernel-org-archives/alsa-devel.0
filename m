From: <laxmi.devi@in.bosch.com>
Subject: [PATCH - ALSA JACK plugin 1/2] jack: Replacing
	jack->channels with jack->num_ports
Date: Fri, 11 Jan 2019 10:19:47 +0530
Message-ID: <1547182188-14480-1-git-send-email-laxmi.devi@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Laxmi Devi <Laxmi.Devi@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <Laxmi.Devi@in.bosch.com>

As jack->num_ports and jack->channels hold the same values,
jack->channels is redundant and hence removed.

Sanity check is added in prepare, to check if io->Channels is
same as jack->num_ports.

Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index af2136e..d723b17 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -48,7 +48,6 @@ typedef struct {
 	unsigned int sample_bits;
 	snd_pcm_uframes_t min_avail;
 
-	unsigned int channels;
 	snd_pcm_channel_area_t *areas;
 
 	jack_port_t **ports;
@@ -263,6 +262,12 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	snd_pcm_sw_params_t *swparams;
 	int err;
 
+	if (io->channels != jack->num_ports) {
+		SNDERR("Channel count %d not equal to no. of ports %d in JACK",
+		       io->channels, jack->num_ports);
+		return -EINVAL;
+	}
+
 	jack->hw_ptr = 0;
 	jack->xrun_detected = false;
 
@@ -381,7 +386,7 @@ static int jack_set_hw_constraint(snd_pcm_jack_t *jack)
 	unsigned int psize_list[MAX_PERIODS_MULTIPLE];
 	unsigned int nframes = jack_get_buffer_size(jack->client);
 	unsigned int jack_buffer_bytes = (snd_pcm_format_size(format, nframes) *
-					  jack->channels);
+					  jack->num_ports);
 	unsigned int i;
 	int err;
 
@@ -398,7 +403,7 @@ static int jack_set_hw_constraint(snd_pcm_jack_t *jack)
 	    (err = snd_pcm_ioplug_set_param_list(&jack->io, SND_PCM_IOPLUG_HW_FORMAT,
 						 1, &format)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&jack->io, SND_PCM_IOPLUG_HW_CHANNELS,
-						   jack->channels, jack->channels)) < 0 ||
+						   jack->num_ports, jack->num_ports)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&jack->io, SND_PCM_IOPLUG_HW_RATE,
 						   rate, rate)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_list(&jack->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
@@ -485,8 +490,7 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 		return err;
 	}
 
-	jack->channels = jack->num_ports;
-	if (jack->channels == 0) {
+	if (jack->num_ports == 0) {
 		SNDERR("define the %s_ports section",
 		       stream == SND_PCM_STREAM_PLAYBACK ? "playback" : "capture");
 		snd_pcm_jack_free(jack);
@@ -514,7 +518,7 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 		return -ENOENT;
 	}
 
-	jack->areas = calloc(jack->channels, sizeof(snd_pcm_channel_area_t));
+	jack->areas = calloc(jack->num_ports, sizeof(snd_pcm_channel_area_t));
 	if (! jack->areas) {
 		snd_pcm_jack_free(jack);
 		return -ENOMEM;
-- 
2.7.4
