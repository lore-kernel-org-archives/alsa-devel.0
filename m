From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Writing register default value for the
	reset register
Date: Tue, 11 Oct 2011 17:55:00 +0800
Message-ID: <1318326900.3526.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ADC05243A4
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 11:55:14 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so6357500ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 02:55:12 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The WM8983 can be reset by performing a write of any value to
the software reset register.
To avoid writing to the software reset register while resume,
we should write the same value in wm8983_reg_defs to software
reset register in wm8983_probe().
The write to the reset register is suppressed by the cache
restore code when it skips writes of default registers.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8983.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 17f04ec..93ee284 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1007,7 +1007,7 @@ static int wm8983_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0x8983);
+	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
-- 
1.7.4.1
