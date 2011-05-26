From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Convert 16x16 write to use
	cpu_to_be16()
Date: Thu, 26 May 2011 23:13:40 +0800
Message-ID: <1306422823-18858-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C1F3103B10
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:13:51 +0200 (CEST)
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

Make it clear what we're doing.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 06b7b81..abdf8d1 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -277,14 +277,12 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int value)
 {
-	u8 data[4];
+	u16 data[2];
 
-	data[0] = (reg >> 8) & 0xff;
-	data[1] = reg & 0xff;
-	data[2] = (value >> 8) & 0xff;
-	data[3] = value & 0xff;
+	data[0] = cpu_to_be16(reg);
+	data[1] = cpu_to_be16(value);
 
-	return do_hw_write(codec, reg, value, data, 4);
+	return do_hw_write(codec, reg, value, data, sizeof(data));
 }
 
 /* Primitive bulk write support for soc-cache.  The data pointed to by
-- 
1.7.5.1
