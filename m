From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ASoC: adau1701: signedness bug in
	adau1701_write()
Date: Mon, 20 Jun 2011 10:11:25 +0300
Message-ID: <20110620071125.GG14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E351110381A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:12:05 +0200 (CEST)
Received: by pzk26 with SMTP id 26so3528621pzk.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 00:12:04 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: "open list:SOUND - SOC LAYER..." <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

"ret" is supposed to be signed here.  The current code will only
return -EIO on error, instead of a more appropriate error code such
as -EAGAIN etc.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 6c01bb6..2758d5f 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -140,9 +140,10 @@ static unsigned int adau1701_register_size(struct snd_soc_codec *codec,
 static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
 		unsigned int value)
 {
-	unsigned int i, ret;
+	unsigned int i;
 	unsigned int size;
 	uint8_t buf[4];
+	int ret;
 
 	size = adau1701_register_size(codec, reg);
 	if (size == 0)
