From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/14] ASoC: ad1980: Use table based control
	setup
Date: Thu, 30 Oct 2014 21:01:00 +0100
Message-ID: <1414699271-22797-4-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id D41D026070D
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:16 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1980.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 5f076c2..9ed4e12 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -259,9 +259,6 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
 	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
-	snd_soc_add_codec_controls(codec, ad1980_snd_ac97_controls,
-				ARRAY_SIZE(ad1980_snd_ac97_controls));
-
 	return 0;
 
 reset_err:
@@ -285,6 +282,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
 	.write = ac97_write,
 	.read = ac97_read,
 
+	.controls = ad1980_snd_ac97_controls,
+	.num_controls = ARRAY_SIZE(ad1980_snd_ac97_controls),
 	.dapm_widgets = ad1980_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ad1980_dapm_widgets),
 	.dapm_routes = ad1980_dapm_routes,
-- 
1.8.0
