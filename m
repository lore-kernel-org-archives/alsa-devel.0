From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: tlv320aic23: depends on SPI
Date: Mon,  3 Nov 2014 23:37:59 +0530
Message-ID: <1415038079-6490-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E291260489
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:08:12 +0100 (CET)
Received: by mail-pd0-f178.google.com with SMTP id fp1so11913765pdb.37
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 10:08:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Jim Davis <jim.epost@gmail.com>, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix build errors when CONFIG_SPI is not enabled by making the
driver depend on SPI.

ERROR: "spi_setup" [sound/soc/codecs/snd-soc-tlv320aic23-spi.ko] undefined!
ERROR: "devm_regmap_init_spi" [sound/soc/codecs/snd-soc-tlv320aic23-spi.ko] undefined!
ERROR: "spi_register_driver" [sound/soc/codecs/snd-soc-tlv320aic23-spi.ko] undefined!

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

reference of mail by Jim Davis at https://lkml.org/lkml/2014/11/3/551

 sound/soc/codecs/Kconfig | 1 +

1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6801b38..9a8ea56 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -603,6 +603,7 @@ config SND_SOC_TLV320AIC23_I2C
 
 config SND_SOC_TLV320AIC23_SPI
 	tristate "Texas Instruments TLV320AIC23 audio CODEC - SPI"
+	depends on SPI
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-- 
1.8.1.2
