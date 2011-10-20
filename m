From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix reg_word_size for ak4104
Date: Thu, 20 Oct 2011 10:50:03 +0800
Message-ID: <1319079003.5380.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AC1A103836
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 04:50:16 +0200 (CEST)
Received: by yxi13 with SMTP id 13so2348587yxi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 19:50:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the register map in datasheet, the registers are 8 bit.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4104.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index cbf0b6d..d3b29dc 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -247,7 +247,7 @@ static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
 	.probe =	ak4104_probe,
 	.remove =	ak4104_remove,
 	.reg_cache_size = AK4104_NUM_REGS,
-	.reg_word_size = sizeof(u16),
+	.reg_word_size = sizeof(u8),
 };
 
 static int ak4104_spi_probe(struct spi_device *spi)
-- 
1.7.5.4
