From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Enable autoloading of pxa2xx CPU I2S
	driver with module alias
Date: Fri, 20 Aug 2010 17:18:45 +0100
Message-ID: <1282321125-15761-3-git-send-email-ian@opensource.wolfsonmicro.com>
References: <1282321125-15761-1-git-send-email-ian@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F32582455B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:19:56 +0200 (CEST)
In-Reply-To: <1282321125-15761-1-git-send-email-ian@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index d1b2ca6..11be595 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -398,3 +398,4 @@ module_exit(pxa2xx_i2s_exit);
 MODULE_AUTHOR("Liam Girdwood, lrg@slimlogic.co.uk");
 MODULE_DESCRIPTION("pxa2xx I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa2xx-i2s");
-- 
1.7.0.4
