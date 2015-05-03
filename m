From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: uda1380: Avoid accessing i2c bus when
	codec is disabled
Date: Sun,  3 May 2015 21:11:47 +0300
Message-ID: <1430676707-30423-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 261FB26049D
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2015 20:12:03 +0200 (CEST)
Received: by layy10 with SMTP id y10so91533645lay.0
 for <alsa-devel@alsa-project.org>; Sun, 03 May 2015 11:12:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

set_dai_fmt_both() callback is called from snd_soc_runtime_set_dai_fmt()
which is called from snd_soc_register_card(), but at this time codec
is not powered on yet. Replace direct i2c write with regcache write.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/uda1380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index dc7778b..c3c33bd 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -437,7 +437,7 @@ static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
 		return -EINVAL;
 
-	uda1380_write(codec, UDA1380_IFACE, iface);
+	uda1380_write_reg_cache(codec, UDA1380_IFACE, iface);
 
 	return 0;
 }
-- 
2.3.5
