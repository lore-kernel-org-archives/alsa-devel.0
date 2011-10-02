From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/6] ASoC: codecs/wm8682: use __devexit_p
Date: Sun,  2 Oct 2011 22:27:59 +0200
Message-ID: <1317587284-2776-2-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBCD24150
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 22:29:09 +0200 (CEST)
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Ian Lartey <ian@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This fixes a build error when CONFIG_HOTPLUG is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8782.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index a2a09f8..f2ced71 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -60,7 +60,7 @@ static struct platform_driver wm8782_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8782_probe,
-	.remove = wm8782_remove,
+	.remove = __devexit_p(wm8782_remove),
 };
 
 static int __init wm8782_init(void)
-- 
1.7.5.4
