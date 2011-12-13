From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove unused extern declarations for
 sh4_hac_dai and sh7760_soc_platform
Date: Tue, 13 Dec 2011 20:23:50 +0800
Message-ID: <1323779030.5064.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FE4F245EC
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 13:24:05 +0100 (CET)
Received: by iabn5 with SMTP id n5so4291634iab.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 04:24:03 -0800 (PST)
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Both sh4_hac_dai and sh7760_soc_platform are changed to static
by multi-component patch and they are not used in sh7760-ac97.c now.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/sh/sh7760-ac97.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index c62ae68..df651e8 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -16,10 +16,6 @@
 
 #define IPSEL 0xFE400034
 
-/* platform specific structs can be declared here */
-extern struct snd_soc_dai_driver sh4_hac_dai[2];
-extern struct snd_soc_platform_driver sh7760_soc_platform;
-
 static struct snd_soc_dai_link sh7760_ac97_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-- 
1.7.5.4
