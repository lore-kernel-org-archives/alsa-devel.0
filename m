From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/5] ASoC: fix compile breakage of the sh/siu driver
Date: Fri, 17 Sep 2010 12:29:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009171211580.4988@axis700.grange>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The sh/siu ASoC driver doesn't compile because of a function defined static in
the source and extern in a header. Remove the unneeded declaration in the
header.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/siu.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index aa239ff..1c0e1f7 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -182,7 +182,6 @@ static inline u32 siu_read32(u32 __iomem *addr)
 #define SIU_BRRB	(0x10c / sizeof(u32))
 
 extern struct snd_soc_platform_driver siu_platform;
-extern struct snd_soc_dai_driver siu_i2s_dai;
 extern struct siu_info *siu_i2s_data;
 
 int siu_init_port(int port, struct siu_port **port_info, struct snd_card *card);
-- 
1.7.1

