From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/7] ALSA: mips: Deliver indirect-PCM transfer error
Date: Sun, 21 May 2017 21:02:53 +0200
Message-ID: <20170521190258.1178-3-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170521190258.1178-1-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Subhransu S . Prusty" <subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/mips/hal2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 00fc9241d266..684dc4ddef41 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -616,10 +616,9 @@ static int hal2_playback_ack(struct snd_pcm_substream *substream)
 	struct hal2_codec *dac = &hal2->dac;
 
 	dac->pcm_indirect.hw_queue_size = H2_BUF_SIZE / 2;
-	snd_pcm_indirect_playback_transfer(substream,
-					   &dac->pcm_indirect,
-					   hal2_playback_transfer);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream,
+						  &dac->pcm_indirect,
+						  hal2_playback_transfer);
 }
 
 static int hal2_capture_open(struct snd_pcm_substream *substream)
@@ -707,10 +706,9 @@ static int hal2_capture_ack(struct snd_pcm_substream *substream)
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 	struct hal2_codec *adc = &hal2->adc;
 
-	snd_pcm_indirect_capture_transfer(substream,
-					  &adc->pcm_indirect,
-					  hal2_capture_transfer);
-	return 0;
+	return snd_pcm_indirect_capture_transfer(substream,
+						 &adc->pcm_indirect,
+						 hal2_capture_transfer);
 }
 
 static struct snd_pcm_ops hal2_playback_ops = {
-- 
2.13.0
