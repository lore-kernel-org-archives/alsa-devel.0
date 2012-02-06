From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Enabling VMID should take a
	runtime PM reference
Date: Mon,  6 Feb 2012 12:07:35 +0000
Message-ID: <1328530055-24060-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 074CE103A85
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 13:07:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We can enable VMID independently of the bias in some use cases so we need
to ensure that the core device is powered up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 365c16f..48fe205 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -770,6 +770,8 @@ static void vmid_reference(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
+	pm_runtime_get_sync(codec->dev);
+
 	wm8994->vmid_refcount++;
 
 	dev_dbg(codec->dev, "Referencing VMID, refcount is now %d\n",
@@ -837,6 +839,8 @@ static void vmid_dereference(struct snd_soc_codec *codec)
 				    WM8994_VMID_BUF_ENA |
 				    WM8994_VMID_RAMP_MASK, 0);
 	}
+
+	pm_runtime_put(codec->dev);
 }
 
 static int vmid_event(struct snd_soc_dapm_widget *w,
-- 
1.7.9.rc1
