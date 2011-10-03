From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/6] ASoC: samsung: wm8994 depends on mfd_wm8994
Date: Mon, 03 Oct 2011 15:43:10 +0200
Message-ID: <11174515.ANsqIhx0NX@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1869072.QQLATNzYYx@wuerfel> <20111003120741.GD23811@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111003120741.GD23811@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 'Liam Girdwood' <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Any driver that selects SND_SOC_WM8994 should also make sure that
MFD_WM8994 is set, since the codec relies on the mfd code:

  sound/built-in.o: In function `wm8994_read':
  last.c:(.text+0x20160): undefined reference to `wm8994_reg_read'
  sound/built-in.o: In function `wm8994_write':
  last.c:(.text+0x20e68): undefined reference to `wm8994_reg_write'

This adds the missing 'depends' statements to Kconfig, as found
during ARM randconfig tests.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

On Monday 03 October 2011 13:07:41 Mark Brown wrote:
> On Mon, Oct 03, 2011 at 01:50:08PM +0200, Arnd Bergmann wrote:
> 
> > the patch. The other problem in this patch is still there, with
> > CONFIG_SND_SOC_SMDK_WM8994_PCM=y and CONFIG_MFD_WM8994=n:
> 
> You've not sent a seprate patch for that one yet...

I wasn't sure any more which version you wanted. Is this this right one?

--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -65,6 +65,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -152,6 +153,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
 	depends on SND_SOC_SAMSUNG && (MACH_GONI || MACH_AQUILA)
 	select SND_SAMSUNG_I2S
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni or aquila
@@ -175,6 +177,7 @@ config SND_SOC_SMDK_WM8580_PCM
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310)
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_PCM
 	help
