From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Convert 7x9 write to use
	cpu_to_be16()
Date: Thu, 26 May 2011 23:13:41 +0800
Message-ID: <1306422823-18858-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1306422823-18858-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88115103B16
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:13:52 +0200 (CEST)
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

Run the data through cpu_to_be16() so it's at least clear what we're up to.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index abdf8d1..a4b1f6c 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -107,12 +107,11 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u8 data[2];
+	u16 data;
 
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
+	data = cpu_to_be16((reg << 9) | (value & 0x1ff));
 
-	return do_hw_write(codec, reg, value, data, 2);
+	return do_hw_write(codec, reg, value, &data, 2);
 }
 
 static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
-- 
1.7.5.1
