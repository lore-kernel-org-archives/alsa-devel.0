From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: Include cx20442 to SND_SOC_ALL_CODECS
Date: Fri, 29 Oct 2010 16:47:45 +0300
Message-ID: <1288360065-9793-2-git-send-email-jhnikula@gmail.com>
References: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E546103854
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 15:46:37 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 24so1842608eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 06:46:37 -0700 (PDT)
In-Reply-To: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
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

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 86d24d4..e61fbab 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -26,6 +26,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
 	select SND_SOC_CS42L51 if I2C
 	select SND_SOC_CS4270 if I2C
+	select SND_SOC_CX20442
 	select SND_SOC_DA7210 if I2C
 	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
 	select SND_SOC_MAX98088 if I2C
-- 
1.7.2.3
