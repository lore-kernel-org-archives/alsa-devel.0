From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/31] ASoC: wm8996: Replace BUG() with
	snd_BUG()
Date: Tue,  5 Nov 2013 18:40:15 +0100
Message-ID: <1383673218-18405-29-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4466B265249
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG() used in the driver is just to spit the stack trace on buggy
points, not really needed to stop the whole operation.  For that
purpose, it'd be more convenient to use snd_BUG() instead.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8996.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index b70379ebd142..7b90f188ecbf 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -610,7 +610,7 @@ static int bg_event(struct snd_soc_dapm_widget *w,
 		wm8996_bg_disable(codec);
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		ret = -EINVAL;
 	}
 
@@ -627,7 +627,7 @@ static int cp_event(struct snd_soc_dapm_widget *w,
 		msleep(5);
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		ret = -EINVAL;
 	}
 
@@ -648,7 +648,7 @@ static int rmv_short_event(struct snd_soc_dapm_widget *w,
 		wm8996->hpout_pending |= w->shift;
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		return -EINVAL;
 	}
 
@@ -769,7 +769,7 @@ static int dcs_start(struct snd_soc_dapm_widget *w,
 		wm8996->dcs_pending |= 1 << w->shift;
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		return -EINVAL;
 	}
 
@@ -1658,7 +1658,7 @@ static int wm8996_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		lrclk_rx_reg = WM8996_AIF2_RX_LRCLK_2;
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		return -EINVAL;
 	}
 
@@ -1770,7 +1770,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 		dsp_shift = WM8996_DSP2_DIV_SHIFT;
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		return -EINVAL;
 	}
 
-- 
1.8.4.2
