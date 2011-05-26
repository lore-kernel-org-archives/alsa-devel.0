From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Use cpu_to_be16() in 8x16 write
Date: Thu, 26 May 2011 23:13:42 +0800
Message-ID: <1306422823-18858-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1306422823-18858-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37FFF103B16
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:13:51 +0200 (CEST)
In-Reply-To: <1306422823-18858-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a4b1f6c..47d0a0c 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -136,10 +136,10 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
 	u8 data[3];
+	u16 val = cpu_to_be16(value);
 
 	data[0] = reg;
-	data[1] = (value >> 8) & 0xff;
-	data[2] = value & 0xff;
+	memcpy(&data[1], &val, sizeof(val));
 
 	return do_hw_write(codec, reg, value, data, 3);
 }
-- 
1.7.5.1
