From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/14] ALSA: x86: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:48 +0100
Message-ID: <20190115162155.6308-8-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CE26267459
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 00c92eb854ce..16ca91f57e7f 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1651,18 +1651,6 @@ static int had_create_jack(struct snd_intelhad *ctx,
 static int __maybe_unused hdmi_lpe_audio_suspend(struct device *dev)
 {
 	struct snd_intelhad_card *card_ctx = dev_get_drvdata(dev);
-	int port;
-
-	for_each_port(card_ctx, port) {
-		struct snd_intelhad *ctx = &card_ctx->pcm_ctx[port];
-		struct snd_pcm_substream *substream;
-
-		substream = had_substream_get(ctx);
-		if (substream) {
-			snd_pcm_suspend(substream);
-			had_substream_put(ctx);
-		}
-	}
 
 	snd_power_change_state(card_ctx->card, SNDRV_CTL_POWER_D3hot);
 
-- 
2.20.1
