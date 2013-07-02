From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: db1200: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 17:19:25 +0800
Message-ID: <CAPgLHd9kdRD1fJZZWLN+=0ddsb3ZxjovA3OU4Ctrbvj_b3Jw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, wfp5p@virginia.edu
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/au1x/db1200.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index a497a0c..2d2407d 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -73,12 +73,14 @@ static struct snd_soc_dai_link db1300_ac97_dai = {
 
 static struct snd_soc_card db1300_ac97_machine = {
 	.name		= "DB1300_AC97",
+	.owner		= THIS_MODULE,
 	.dai_link	= &db1300_ac97_dai,
 	.num_links	= 1,
 };
 
 static struct snd_soc_card db1550_ac97_machine = {
 	.name		= "DB1550_AC97",
+	.owner		= THIS_MODULE,
 	.dai_link	= &db1200_ac97_dai,
 	.num_links	= 1,
 };
@@ -145,6 +147,7 @@ static struct snd_soc_dai_link db1300_i2s_dai = {
 
 static struct snd_soc_card db1300_i2s_machine = {
 	.name		= "DB1300_I2S",
+	.owner		= THIS_MODULE,
 	.dai_link	= &db1300_i2s_dai,
 	.num_links	= 1,
 };
@@ -161,6 +164,7 @@ static struct snd_soc_dai_link db1550_i2s_dai = {
 
 static struct snd_soc_card db1550_i2s_machine = {
 	.name		= "DB1550_I2S",
+	.owner		= THIS_MODULE,
 	.dai_link	= &db1550_i2s_dai,
 	.num_links	= 1,
 };
