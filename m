From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: Fix SND_SOC_ALL_CODECS typos for
	alc5623 and jz4740
Date: Fri, 29 Oct 2010 16:47:44 +0300
Message-ID: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C8E6D10384C
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 15:46:34 +0200 (CEST)
Received: by eyg24 with SMTP id 24so1842608eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 06:46:34 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Include alc5623.c and jz4740.c to SND_SOC_ALL_CODECS when their other
dependencies are met.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 658cbe0..86d24d4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -22,12 +22,12 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
-	select SND_SOC_ALC562 if I2C
+	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
 	select SND_SOC_CS42L51 if I2C
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_DA7210 if I2C
-	select SND_SOC_JZ4740 if SOC_JZ4740
+	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
-- 
1.7.2.3
