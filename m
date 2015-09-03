From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] ALSA: sparc: amd7930: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 13:03:04 +0200
Message-ID: <20150903110304.GA17142@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 sound/sparc/amd7930.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 784ceb8..35c1f6a 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -1064,6 +1064,7 @@ static const struct of_device_id amd7930_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, amd7930_match);
 
 static struct platform_driver amd7930_sbus_driver = {
 	.driver = {
-- 
2.4.6
