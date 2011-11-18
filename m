From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: cs42l73: Make inv and format to be
	unsigned int
Date: Fri, 18 Nov 2011 17:16:22 +0800
Message-ID: <1321607782.8417.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DC19103845
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 10:16:37 +0100 (CET)
Received: by ywp27 with SMTP id 27so2332382ywp.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 01:16:34 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, Liam Girdwood <lrg@ti.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Fix below smatch warning:

sound/soc/codecs/cs42l73.c +1030 cs42l73_set_dai_fmt(53) error: inv is never equal to 1024 (wrong type 0 - 255).
sound/soc/codecs/cs42l73.c +1032 cs42l73_set_dai_fmt(55) error: inv is never equal to 768 (wrong type 0 - 255).
sound/soc/codecs/cs42l73.c +1036 cs42l73_set_dai_fmt(59) error: inv is never equal to 1024 (wrong type 0 - 255).

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l73.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a2af595..aadfd6b 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -979,7 +979,7 @@ static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
 	u8 id = codec_dai->id;
-	u8 inv, format;
+	unsigned int inv, format;
 	u8 spc, mmcc;
 
 	spc = snd_soc_read(codec, CS42L73_SPC(id));
-- 
1.7.5.4
