From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/2] ASoC: WM8903: Fix double-applied patch
Date: Tue, 22 Feb 2011 17:23:57 -0700
Message-ID: <1298420637-9230-2-git-send-email-swarren@nvidia.com>
References: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 21779103833
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 01:24:06 +0100 (CET)
In-Reply-To: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

A patch named "ASoC: Actively manage WM8903 DC servo configuration" was
applied twice, with commit IDs:

1605b831ae71a4008671e43113e1151a669ed0bf
c5b6a9feaeb0fa0e39e3fc10f9bf8cc8de498739

Remove the duplicate code caused by this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/wm8903.c |   97 ---------------------------------------------
 1 files changed, 0 insertions(+), 97 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 7ca2593..ae1cadf 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -373,103 +373,6 @@ static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
 	}
 }
 
-static int wm8903_dcs_event(struct snd_soc_dapm_widget *w,
-			    struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		wm8903->dcs_pending |= 1 << w->shift;
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, WM8903_DC_SERVO_0,
-				    1 << w->shift, 0);
-		break;
-	}
-
-	return 0;
-}
-
-#define WM8903_DCS_MODE_WRITE_STOP 0
-#define WM8903_DCS_MODE_START_STOP 2
-
-static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
-				enum snd_soc_dapm_type event, int subseq)
-{
-	struct snd_soc_codec *codec = container_of(dapm,
-						   struct snd_soc_codec, dapm);
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	int dcs_mode = WM8903_DCS_MODE_WRITE_STOP;
-	int i, val;
-
-	/* Complete any pending DC servo starts */
-	if (wm8903->dcs_pending) {
-		dev_dbg(codec->dev, "Starting DC servo for %x\n",
-			wm8903->dcs_pending);
-
-		/* If we've no cached values then we need to do startup */
-		for (i = 0; i < ARRAY_SIZE(wm8903->dcs_cache); i++) {
-			if (!(wm8903->dcs_pending & (1 << i)))
-				continue;
-
-			if (wm8903->dcs_cache[i]) {
-				dev_dbg(codec->dev,
-					"Restore DC servo %d value %x\n",
-					3 - i, wm8903->dcs_cache[i]);
-
-				snd_soc_write(codec, WM8903_DC_SERVO_4 + i,
-					      wm8903->dcs_cache[i] & 0xff);
-			} else {
-				dev_dbg(codec->dev,
-					"Calibrate DC servo %d\n", 3 - i);
-				dcs_mode = WM8903_DCS_MODE_START_STOP;
-			}
-		}
-
-		/* Don't trust the cache for analogue */
-		if (wm8903->class_w_users)
-			dcs_mode = WM8903_DCS_MODE_START_STOP;
-
-		snd_soc_update_bits(codec, WM8903_DC_SERVO_2,
-				    WM8903_DCS_MODE_MASK, dcs_mode);
-
-		snd_soc_update_bits(codec, WM8903_DC_SERVO_0,
-				    WM8903_DCS_ENA_MASK, wm8903->dcs_pending);
-
-		switch (dcs_mode) {
-		case WM8903_DCS_MODE_WRITE_STOP:
-			break;
-
-		case WM8903_DCS_MODE_START_STOP:
-			msleep(270);
-
-			/* Cache the measured offsets for digital */
-			if (wm8903->class_w_users)
-				break;
-
-			for (i = 0; i < ARRAY_SIZE(wm8903->dcs_cache); i++) {
-				if (!(wm8903->dcs_pending & (1 << i)))
-					continue;
-
-				val = snd_soc_read(codec,
-						   WM8903_DC_SERVO_READBACK_1 + i);
-				dev_dbg(codec->dev, "DC servo %d: %x\n",
-					3 - i, val);
-				wm8903->dcs_cache[i] = val;
-			}
-			break;
-
-		default:
-			pr_warn("DCS mode %d delay not set\n", dcs_mode);
-			break;
-		}
-
-		wm8903->dcs_pending = 0;
-	}
-}
-
 /*
  * When used with DAC outputs only the WM8903 charge pump supports
  * operation in class W mode, providing very low power consumption
-- 
1.7.1
