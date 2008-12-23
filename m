From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: Mark non-connected TWL4030 pins for
	pandora
Date: Tue, 23 Dec 2008 12:04:48 +0200
Message-ID: <1230026688-7342-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 83C47103817
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 11:04:52 +0100 (CET)
Received: by bwz13 with SMTP id 13so6904172bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 02:04:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Pandora has all TWL4030 output pins floating, it uses
external DAC for playback. Mark those outputs as not
connected using DAPM calls.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index bd91594..0ffb3de 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -180,6 +180,19 @@ static int omap3pandora_in_init(struct snd_soc_codec *codec)
 {
 	int ret;
 
+	/* All TWL4030 output pins are floating */
+	snd_soc_dapm_nc_pin(codec, "OUTL"),
+	snd_soc_dapm_nc_pin(codec, "OUTR"),
+	snd_soc_dapm_nc_pin(codec, "EARPIECE"),
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL"),
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER"),
+	snd_soc_dapm_nc_pin(codec, "HSOL"),
+	snd_soc_dapm_nc_pin(codec, "HSOR"),
+	snd_soc_dapm_nc_pin(codec, "CARKITL"),
+	snd_soc_dapm_nc_pin(codec, "CARKITR"),
+	snd_soc_dapm_nc_pin(codec, "HFL"),
+	snd_soc_dapm_nc_pin(codec, "HFR"),
+
 	ret = snd_soc_dapm_new_controls(codec, omap3pandora_in_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_in_dapm_widgets));
 	if (ret < 0)
-- 
1.5.4.3
