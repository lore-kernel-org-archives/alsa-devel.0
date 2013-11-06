From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/9] ASoC: wm8962: Replace BUG() with WARN()
Date: Wed,  6 Nov 2013 11:07:16 +0100
Message-ID: <1383732439-31441-7-git-send-email-tiwai@suse.de>
References: <1383732439-31441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 154DC26168B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:07:23 +0100 (CET)
In-Reply-To: <1383732439-31441-1-git-send-email-tiwai@suse.de>
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
purpose, it'd be more convenient to use WARN() instead with more
error information.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8962.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3a2f96c5442c..ac1ff9947a90 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1853,7 +1853,7 @@ static int cp_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		WARN(1, "Invalid event %d\n", event);
 		return -EINVAL;
 	}
 
@@ -1945,7 +1945,7 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		WARN(1, "Invalid event %d\n", event);
 		return -EINVAL;
 	
 	}
@@ -1974,7 +1974,7 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 		reg = WM8962_SPKOUTL_VOLUME;
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid shift %d\n", w->shift);
 		return -EINVAL;
 	}
 
@@ -1982,7 +1982,7 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		return snd_soc_write(codec, reg, snd_soc_read(codec, reg));
 	default:
-		BUG();
+		WARN(1, "Invalid event %d\n", event);
 		return -EINVAL;
 	}
 }
@@ -2005,7 +2005,7 @@ static int dsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		WARN(1, "Invalid event %d\n", event);
 		return -EINVAL;
 	}
 
-- 
1.8.4.2
