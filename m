From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: cirrus: Remove excess dependencies on
	SND_SOC
Date: Tue, 25 Feb 2014 22:01:54 +0400
Message-ID: <1393351314-23006-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [94.100.177.95])
 by alsa0.perex.cz (Postfix) with ESMTP id F264526563A
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 19:02:01 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Configuration for Cirrus Logic audio support is included only
if SND_SOC symbol selected, so no reason to check it once more.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/cirrus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 06f938d..c872dac 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -1,6 +1,6 @@
 config SND_EP93XX_SOC
 	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
-	depends on (ARCH_EP93XX || COMPILE_TEST) && SND_SOC
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.8.3.2
