From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: davinci: fix DM365_EVM codec selection
Date: Wed, 28 Jan 2015 22:30:01 +0100
Message-ID: <12284641.mhX5PHEsR2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B882264F50
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 22:30:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

An earlier bug fix of mine made the SND_DM365_VOICE_CODEC symbol
tristate to avoid creating an undefined reference from the
davinci-vcif.c driver to the davinci_soc_platform_register
function that may be in a module.

However, this may now lead to a different error on randconfig
kernels:

"warning: SND_DM365_VOICE_CODEC creates inconsistent choice state"

This happens because we now have a choice statement with
one bool and one tristate option, and the latter might not
support being set to 'y' because of dependencies.

This new change turns the other option into 'tristate' as well,
which avoids the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 19926c6de0c3 ("ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC is")

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 8e948c63f3d9..2b81ca418d2a 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -58,13 +58,12 @@ choice
 	depends on MACH_DAVINCI_DM365_EVM
 
 config SND_DM365_AIC3X_CODEC
-	bool "Audio Codec - AIC3101"
+	tristate "Audio Codec - AIC3101"
 	help
 	  Say Y if you want to add support for AIC3101 audio codec
 
 config SND_DM365_VOICE_CODEC
 	tristate "Voice Codec - CQ93VC"
-	depends on SND_DAVINCI_SOC
 	select MFD_DAVINCI_VOICECODEC
 	select SND_DAVINCI_SOC_VCIF
 	select SND_SOC_CQ0093VC
