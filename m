From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 2/5] Add timestamp type to sw_params
	(internal only)
Date: Thu, 10 Jul 2014 15:09:14 +0200
Message-ID: <1404997757-15500-3-git-send-email-tiwai@suse.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C231D2607C8
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:09:19 +0200 (CEST)
In-Reply-To: <1404997757-15500-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This patch is just the udpate of sound/asound.h taken from the kernel
commit.  The API changes and PCM structure changes will follow after
this.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 9061cdd5b69f..552f41bd1ca9 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -136,7 +136,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 11)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 12)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -386,7 +386,9 @@ struct snd_pcm_sw_params {
 	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
 	snd_pcm_uframes_t silence_size;		/* silence block size */
 	snd_pcm_uframes_t boundary;		/* pointers wrap point */
-	unsigned char reserved[64];		/* reserved for future */
+	unsigned int tstamp_type;		/* timestamp type */
+	int pads;				/* alignment, reserved */
+	unsigned char reserved[56];		/* reserved for future */
 };
 
 struct snd_pcm_channel_info {
-- 
2.0.1
