From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 2/2] sound/soc/soc-core.c: cleanup kernel-doc
Date: Tue, 25 Nov 2008 23:24:54 +0800
Message-ID: <492c18cb.0c636e0a.1c1a.ffffb2b3@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754092AbYKYPZk@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is no argument named @clk_id in snd_soc_dai_set_fmt,
remove its' comment.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16c7453..81ee4ba 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1805,7 +1805,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
 /**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
- * @clk_id: DAI specific clock ID
  * @fmt: SND_SOC_DAIFMT_ format value.
  *
  * Configures the DAI hardware format and clocking.
