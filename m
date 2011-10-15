From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: max98095: Convert codec->hw_write to
	snd_soc_write
Date: Sat, 15 Oct 2011 11:46:02 +0800
Message-ID: <1318650362.6399.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f171.google.com (mail-yx0-f171.google.com
	[209.85.213.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B4E110B7F5
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 05:46:13 +0200 (CEST)
Received: by yxl11 with SMTP id 11so1578894yxl.30
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 20:46:13 -0700 (PDT)
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
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

codec->hw_write is broken now, convert codec->hw_write to snd_soc_write.

The hardware has 2 banks of registers sharing a section in I2C register space.
The 1st bank is the primary one and is cached.
The 2nd bank is for loading coefficients only and they do not need cache.
These coefficients registers are therefore direct writes.
Thus we set cache_bypass flag to deal with this before calling snd_soc_write.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi,
  I don't have this hardware, I'd appreciate if someone can test this patch.

Thanks,
Axel

 sound/soc/codecs/max98095.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6982f74..26d7b08 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -617,14 +617,13 @@ static int max98095_volatile(struct snd_soc_codec *codec, unsigned int reg)
 static int max98095_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u8 data[2];
+	int ret;
 
-	data[0] = reg;
-	data[1] = value;
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
+	codec->cache_bypass = 1;
+	ret = snd_soc_write(codec, reg, value);
+	codec->cache_bypass = 0;
+
+	return ret ? -EIO : 0;
 }
 
 /*
-- 
1.7.4.1
