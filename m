From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] sound: soc: add alias for tlv320aic3x
Date: Wed,  1 Feb 2012 03:06:19 +0200
Message-ID: <1328058380-29360-2-git-send-email-felipe.contreras@gmail.com>
References: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BC2A103B17
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 02:07:03 +0100 (CET)
Received: by lags15 with SMTP id s15so378662lag.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 17:07:02 -0800 (PST)
In-Reply-To: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Felipe Contreras <felipe.contreras@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

According to the documentation, should help hotplugging.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 492f22f..00eb29d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1565,3 +1565,4 @@ module_exit(aic3x_exit);
 MODULE_DESCRIPTION("ASoC TLV320AIC3X codec driver");
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("i2c:tlv320aic3x");
-- 
1.7.9
