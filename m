From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: Fix build dependency for
	SND_SOC_JZ4740_CODEC
Date: Tue, 06 Dec 2011 15:38:51 +0800
Message-ID: <1323157131.22557.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 26FE6103919
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 08:39:00 +0100 (CET)
Received: by yenl7 with SMTP id l7so2689619yen.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 23:38:57 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently SND_SOC_JZ4740_CODEC depends on SOC_JZ4740 but SOC_JZ4740 is not
defined in any Kconfig. Thus the codec driver will not be built when select
"Build all ASoC CODEC drivers". 
(Unless it is selected by SND_JZ4740_SOC_QI_LB60).
Remove the dependency with SOC_JZ4740, then this code driver can be built when
select "Build all ASoC CODEC drivers".

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I'm a little bit doubt if I should just remove the dependency as this patch does.
Or alternatively make it depends on MACH_JZ4740.
Comments?

Axel
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bc2364ac..7c205e7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -35,7 +35,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CX20442
 	select SND_SOC_DA7210 if I2C
 	select SND_SOC_DFBMCS320
-	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
+	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98095 if I2C
-- 
1.7.5.4
