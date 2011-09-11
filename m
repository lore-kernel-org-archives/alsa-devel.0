From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 1/7] ASoC: ep93xx-pcm: add MODULE_ALIAS
Date: Sun, 11 Sep 2011 12:28:49 +0300
Message-ID: <d678a0075d114443bd0821f5eef84669ad879048.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: rmallon@gmail.com, Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

To get the PCM module loaded automatically by udev et al. we need to add a
proper MODULE_ALIAS.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/ep93xx-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 8dfd3ad..d00230a 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -355,3 +355,4 @@ module_exit(ep93xx_soc_platform_exit);
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ep93xx-pcm-audio");
-- 
1.7.5.4
