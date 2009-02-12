From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC ac97: kobject warnings
Date: Thu, 12 Feb 2009 19:37:56 +0000
Message-ID: <20090212193756.GB9772@rakim.wolfsonmicro.main>
References: <20090212170504.GA7118@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 032D124395
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 20:37:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090212170504.GA7118@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 12, 2009 at 06:05:05PM +0100, Manuel Lauss wrote:

> the asoc generic ac97 codec support throws a warning on 2.6.29:

Please try this patch, it fixes the problem for me here:

>From 809e4472590e2312d3bea70b4327c3b65676b1a6 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 12 Feb 2009 19:33:19 +0000
Subject: [PATCH] ASoC: Only register AC97 bus if it's not done already

ASoC supports both explicit codec drivers for AC97 devices and a simple
driver which uses the standard ALSA AC97 framework for codec support.
When used with the generic AC97 codec support that will provide the
ad hoc AC97 device for drivers like touchscreens to attach to so the
core shouldn't do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 580a1a5..ae1d7a9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1382,7 +1382,9 @@ int snd_soc_init_card(struct snd_soc_device *socdev)
 
 	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	if (ac97) {
+	/* Only instantiate AC97 if not already done (normally only by
+	 * the adaptor for the generic AC97 subsystem). */
+	if (ac97 && !codec->ac97) {
 		ret = soc_ac97_dev_register(codec);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: AC97 device register failed\n");
-- 
1.5.6.5
