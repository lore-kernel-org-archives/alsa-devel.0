From: <twischer@de.adit-jv.com>
Subject: [PATCH - ALSA JACK plugin 1/1] jack: Only allow ALSA
	periods multiple of JACKd period
Date: Thu, 19 Jul 2018 09:50:09 +0200
Message-ID: <1531986609-10437-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: Laxmi Devi <ldevi@de.adit-jv.com>, alsa-devel@alsa-project.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <ldevi@de.adit-jv.com>

There is a higher Xrun probability whenever the ALSA period is not a
multiple of the JACKd period and the ALSA buffer is only twice the period.
Allowing ALSA buffers of min. 3x period is not a good solution because this
would increase the latency.

As an example in case of ALSA is using a period of 11 frames and JACK a
period of 12 frames and a buffer of 22 frames (2x ALSA period) is used:
- The buffer is filled and contains 22 frames
- JACK is reading 12 frames. Buffer is only containing 10 frames
- Now, ALSA has to be scheduled exactly after the last JACK read and
  before the next read. Otherwise we will get an Xrun
In case of ALSA is using a multiple period of JACK, JACK can always read
2 periods before an Xrun if the buffer was full.

In case of ALSA is using a period of 12 frames and JACK a period of 11
frames and a buffer of 24 frames (2x ALSA period) is used:
- The buffer is filled and contains 24 frames
- JACK is reading 11 frames. Buffer is now containing 13 frames. But ALSA
  can still not write to the buffer
- JACK reads 11 additional frames. Buffer contains 2 frames
- Now, ALSA has to be scheduled exactly after the last JACK read and
  before the next read. Otherwise we will get an Xrun
In case of ALSA is using a multiple period of JACK, ALSA can always write
to the buffer as long as the buffer is filled with less or equal of half
of buffer.

Therefore this patch enforces an ALSA period which is always a multiple
of the JACKd period.

Signed-off-by: Laxmi Devi <ldevi@de.adit-jv.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index fbc9daf..b39835e 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -29,6 +29,8 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
+#define MAX_PERIODS_MULTIPLE 64
+
 typedef enum _jack_format {
 	SND_PCM_JACK_FORMAT_RAW
 } snd_pcm_jack_format_t;
@@ -364,8 +366,20 @@ static int jack_set_hw_constraint(snd_pcm_jack_t *jack)
 	};
 	unsigned int format = SND_PCM_FORMAT_FLOAT;
 	unsigned int rate = jack_get_sample_rate(jack->client);
+	unsigned int psize_list[MAX_PERIODS_MULTIPLE];
+	unsigned int nframes = jack_get_buffer_size(jack->client);
+	unsigned int jack_buffer_bytes = (snd_pcm_format_size(format, nframes) *
+					  jack->channels);
+	unsigned int i;
 	int err;
 
+	if (!jack_buffer_bytes) {
+		SNDERR("Buffer size is zero");
+		return -EINVAL;
+	}
+	for (i = 1; i <= ARRAY_SIZE(psize_list); i++)
+		psize_list[i-1] = jack_buffer_bytes * i;
+
 	jack->sample_bits = snd_pcm_format_physical_width(format);
 	if ((err = snd_pcm_ioplug_set_param_list(&jack->io, SND_PCM_IOPLUG_HW_ACCESS,
 						 ARRAY_SIZE(access_list), access_list)) < 0 ||
@@ -375,8 +389,8 @@ static int jack_set_hw_constraint(snd_pcm_jack_t *jack)
 						   jack->channels, jack->channels)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&jack->io, SND_PCM_IOPLUG_HW_RATE,
 						   rate, rate)) < 0 ||
-	    (err = snd_pcm_ioplug_set_param_minmax(&jack->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						   128, 64*1024)) < 0 ||
+	    (err = snd_pcm_ioplug_set_param_list(&jack->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+						 ARRAY_SIZE(psize_list), psize_list)) < 0 ||
 	    (err = snd_pcm_ioplug_set_param_minmax(&jack->io, SND_PCM_IOPLUG_HW_PERIODS,
 						   2, 64)) < 0)
 		return err;
-- 
2.7.4
