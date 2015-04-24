From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/21] ALSA: hda - Replace open codes with
	snd_hdac_stream_set_params()
Date: Fri, 24 Apr 2015 14:38:53 +0200
Message-ID: <1429879133-32293-22-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D98C2605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DFD78ADC0
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 14ffb6bd986c..e0bb6231ff0c 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -157,7 +157,7 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct hda_pcm_stream *hinfo = to_hda_pcm_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int bufsize, period_bytes, format_val, stream_tag;
+	unsigned int format_val, stream_tag;
 	int err;
 	struct hda_spdif_out *spdif =
 		snd_hda_spdif_out_of_nid(apcm->codec, hinfo->nid);
@@ -183,24 +183,9 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
-	bufsize = snd_pcm_lib_buffer_bytes(substream);
-	period_bytes = snd_pcm_lib_period_bytes(substream);
-
-	dev_dbg(chip->card->dev, "azx_pcm_prepare: bufsize=0x%x, format=0x%x\n",
-		bufsize, format_val);
-
-	if (bufsize != azx_dev->core.bufsize ||
-	    period_bytes != azx_dev->core.period_bytes ||
-	    format_val != azx_dev->core.format_val ||
-	    runtime->no_period_wakeup != azx_dev->core.no_period_wakeup) {
-		azx_dev->core.bufsize = bufsize;
-		azx_dev->core.period_bytes = period_bytes;
-		azx_dev->core.format_val = format_val;
-		azx_dev->core.no_period_wakeup = runtime->no_period_wakeup;
-		err = snd_hdac_stream_setup_periods(azx_stream(azx_dev));
-		if (err < 0)
-			goto unlock;
-	}
+	err = snd_hdac_stream_set_params(azx_stream(azx_dev), format_val);
+	if (err < 0)
+		goto unlock;
 
 	snd_hdac_stream_setup(azx_stream(azx_dev));
 
-- 
2.3.5
