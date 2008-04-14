From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] wm9713: Don't control touch screen power
	on suspend
Date: Mon, 14 Apr 2008 12:01:43 +0100
Message-ID: <1208170903-27159-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208170903-27159-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C11F244E3
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 13:01:45 +0200 (CEST)
In-Reply-To: <1208170903-27159-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Leave the power bit for the touch screen alone when suspending the WM9713
so that the touch screen driver can handle it. This allows the touch
screen to be used as a wakeup source when the system is suspended.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index e3174c4..1f24116 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1132,8 +1132,17 @@ static int wm9713_soc_suspend(struct platform_device *pdev,
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
+	u16 reg;
+
+	/* Disable everything except touchpanel - that will be handled
+	 * by the touch driver and left disabled if touch is not in
+	 * use. */
+	reg = ac97_read(codec, AC97_EXTENDED_MID);
+	ac97_write(codec, AC97_EXTENDED_MID, reg | 0x7fff);
+	ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+	ac97_write(codec, AC97_POWERDOWN, 0x6f00);
+	ac97_write(codec, AC97_POWERDOWN, 0xffff);
 
-	wm9713_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
 	return 0;
 }
 
-- 
1.5.5
