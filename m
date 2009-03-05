From: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/1] ALSA: ASoC: Davinci: Fix incorrect machine type for
	SFFSDR board
Date: Thu,  5 Mar 2009 15:44:57 -0500
Message-ID: <1236285897-26180-1-git-send-email-hugo@hugovil.com>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
---
 sound/soc/davinci/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 7d3a85d..411a710 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -21,7 +21,7 @@ config SND_DAVINCI_SOC_EVM
 
 config SND_DAVINCI_SOC_SFFSDR
 	tristate "SoC Audio support for SFFSDR"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
+	depends on SND_DAVINCI_SOC && MACH_SFFSDR
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_PCM3008
 	select SFFSDR_FPGA
-- 
1.5.4.5
