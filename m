From: miguel.aguilar@ridgerun.com
Subject: [PATCH] Davinci: Enable ASoC support for DM365 EVM in
	defconfig
Date: Fri, 28 Aug 2009 14:27:54 -0600
Message-ID: <1251491274-32622-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id C90A924482
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 22:27:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, nsnehaprabha@ti.com
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>


Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/configs/davinci_all_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index ec63c15..cbe18b4 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -1099,6 +1099,7 @@ CONFIG_SND_DAVINCI_SOC_I2S=m
 CONFIG_SND_DAVINCI_SOC_MCASP=m
 CONFIG_SND_DAVINCI_SOC_EVM=m
 CONFIG_SND_DM6467_SOC_EVM=m
+CONFIG_SND_DM365_SOC_EVM=m
 # CONFIG_SND_DAVINCI_SOC_SFFSDR is not set
 CONFIG_SND_SOC_I2C_AND_SPI=m
 # CONFIG_SND_SOC_ALL_CODECS is not set
-- 
1.6.0.4
