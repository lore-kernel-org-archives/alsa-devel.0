From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] ASoC: tlv320aic23: add dependencies on
	I2C/SPI_MASTER
Date: Mon,  3 Nov 2014 13:10:53 +0300
Message-ID: <1415009453-1018-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CA675260434
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 11:11:23 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id z12so567176lbi.1
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 02:11:23 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This fixes build errors in configurations with I2C/SPI master disabled.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 sound/soc/codecs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7dad805..b0bcd0d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -553,10 +553,12 @@ config SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC23_I2C
 	tristate "Texas Instruments TLV320AIC23 audio CODEC - I2C"
+	depends on I2C
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC23_SPI
 	tristate "Texas Instruments TLV320AIC23 audio CODEC - SPI"
+	depends on SPI_MASTER
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-- 
1.8.1.4
