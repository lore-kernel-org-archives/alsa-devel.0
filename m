From: <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 3/6] ASoC: davinci: ASoC support for Omapl138-Hawkboard
Date: Fri,  8 Oct 2010 20:12:07 -0500
Message-ID: <1286586727-1296-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

This patch adds ASoC support for the Hawkboard-L138 system
It is under the machine name "omapl138_hawkboard".
This system is based on the da850 davinci CPU architecture.

Signed-off-by: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
---
 sound/soc/davinci/Kconfig       |    5 +++--
 sound/soc/davinci/davinci-evm.c |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6bbf001..d6cb394 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -76,8 +76,9 @@ config  SND_DA830_SOC_EVM
 	  DA830/OMAP-L137 EVM
 
 config  SND_DA850_SOC_EVM
-	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
+	tristate "SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard"
+	depends on SND_DAVINCI_SOC&& (MACH_DAVINCI_DA850_EVM \
+					|| MACH_OMAPL138_HAWKBOARD)
 	select SND_DAVINCI_SOC_MCASP
 	select SND_SOC_TLV320AIC3X
 	help
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 97f74d6..73093eb 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -59,7 +59,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 		sysclk = 12288000;
 
 	else if (machine_is_davinci_da830_evm() ||
-				machine_is_davinci_da850_evm())
+				machine_is_davinci_da850_evm() ||
+				machine_is_omapl138_hawkboard())
 		sysclk = 24576000;
 
 	else
@@ -311,7 +312,8 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_da830_evm()) {
 		evm_snd_dev_data = &da830_evm_snd_devdata;
 		index = 1;
-	} else if (machine_is_davinci_da850_evm()) {
+	} else if (machine_is_davinci_da850_evm() ||
+			machine_is_omapl138_hawkboard()) {
 		evm_snd_dev_data = &da850_evm_snd_devdata;
 		index = 0;
 	} else
-- 
1.6.0.5
