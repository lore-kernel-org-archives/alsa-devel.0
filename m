From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: Tegra and i.MX are mutually exclusive
Date: Mon, 24 Jun 2013 17:04:20 +0200
Message-ID: <5967649.DUvDfofhX4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F4542650C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 17:03:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Both Tegra and i.MX provide ac97 operations, which can only
exist once in the kernel. They can both be built as loadable
modules (only one of them needs to be loaded anyway), but we
have to disallow enabling them both as built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3843a18..5958948 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -99,6 +99,7 @@ endif # SND_POWERPC_SOC
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
+	depends on SND_SOC_TEGRA=n || (SND_SOC_TEGRA=m && m)
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX CPUs.
