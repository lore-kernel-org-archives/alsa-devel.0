From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: cs42l51: Fix off-by-one for
	reg_cache_size
Date: Wed, 23 Nov 2011 12:46:11 +0800
Message-ID: <1322023571.6782.4.camel@phoenix>
References: <1322023485.6782.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 90950103A70
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 05:46:18 +0100 (CET)
Received: by ywp27 with SMTP id 27so1021440ywp.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 20:46:18 -0800 (PST)
In-Reply-To: <1322023485.6782.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Just checking the code in cs42l51_fill_cache():
The cache pointer points to codec->reg_cache + 1.
I think it is because CS42L51_FIRSTREG is 0x01,
so codec->reg_cache[0] is not used here.

Then we read CS42L51_NUMREGS bytes to cache.
So we need reg_cache_size to be CS42L51_NUMREGS + 1.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 35c5ac3..c0b0a39 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -553,7 +553,7 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.probe =	cs42l51_probe,
-	.reg_cache_size = CS42L51_NUMREGS,
+	.reg_cache_size = CS42L51_NUMREGS + 1,
 	.reg_word_size = sizeof(u8),
 };
 
-- 
1.7.5.4
