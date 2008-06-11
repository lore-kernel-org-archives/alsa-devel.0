From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/10] ASoC: Cover also Nokia N810 WiMAX
	Edition in N810 machine driver
Date: Wed, 11 Jun 2008 13:47:15 +0100
Message-ID: <1213188435-1986-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D93C2482A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:18 +0200 (CEST)
In-Reply-To: <1213188435-1986-9-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index c32487b..c168a64 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -265,7 +265,7 @@ static int __init n810_soc_init(void)
 	int err;
 	struct device *dev;
 
-	if (!machine_is_nokia_n810())
+	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 		return -ENODEV;
 
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.5.5.3
