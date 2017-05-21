From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: cs46xx: Deliver indirect-PCM
	transfer error
Date: Sun, 21 May 2017 21:02:54 +0200
Message-ID: <20170521190258.1178-4-tiwai@suse.de>
References: <20170521190258.1178-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 89CA6266C78
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 21:03:05 +0200 (CEST)
In-Reply-To: <20170521190258.1178-1-tiwai@suse.de>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Now that the indirect-PCM transfer helper gives back an error, we
should return the error from ack callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 00fa52e9a2f2..ae2aad52ea6f 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -887,8 +887,8 @@ static int snd_cs46xx_playback_transfer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_cs46xx_pcm * cpcm = runtime->private_data;
-	snd_pcm_indirect_playback_transfer(substream, &cpcm->pcm_rec, snd_cs46xx_pb_trans_copy);
-	return 0;
+	return snd_pcm_indirect_playback_transfer(substream, &cpcm->pcm_rec,
+						  snd_cs46xx_pb_trans_copy);
 }
 
 static void snd_cs46xx_cp_trans_copy(struct snd_pcm_substream *substream,
@@ -903,8 +903,8 @@ static void snd_cs46xx_cp_trans_copy(struct snd_pcm_substream *substream,
 static int snd_cs46xx_capture_transfer(struct snd_pcm_substream *substream)
 {
 	struct snd_cs46xx *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_indirect_capture_transfer(substream, &chip->capt.pcm_rec, snd_cs46xx_cp_trans_copy);
-	return 0;
+	return snd_pcm_indirect_capture_transfer(substream, &chip->capt.pcm_rec,
+						 snd_cs46xx_cp_trans_copy);
 }
 
 static snd_pcm_uframes_t snd_cs46xx_playback_direct_pointer(struct snd_pcm_substream *substream)
-- 
2.13.0
