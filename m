From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] ASoC: Drop ac97_control initialization
	from CODEC driver DAIs
Date: Mon, 10 Nov 2014 22:41:51 +0100
Message-ID: <1415655713-29842-10-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 57FD8261A76
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:49:06 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is no longer necessary as there is no code anymore that uses this for
CODEC DAIs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ac97.c     | 1 -
 sound/soc/codecs/ad1980.c   | 1 -
 sound/soc/codecs/stac9766.c | 2 --
 sound/soc/codecs/wm9705.c   | 1 -
 sound/soc/codecs/wm9712.c   | 1 -
 sound/soc/codecs/wm9713.c   | 1 -
 6 files changed, 7 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index bd9b183..5d90924 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -53,7 +53,6 @@ static const struct snd_soc_dai_ops ac97_dai_ops = {
 
 static struct snd_soc_dai_driver ac97_dai = {
 	.name = "ac97-hifi",
-	.ac97_control = 1,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index f71cc21..c6cb101 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -170,7 +170,6 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 
 static struct snd_soc_dai_driver ad1980_dai = {
 	.name = "ad1980-hifi",
-	.ac97_control = 1,
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 6d5bff6..4fb9f1d 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -287,7 +287,6 @@ static const struct snd_soc_dai_ops stac9766_dai_ops_digital = {
 static struct snd_soc_dai_driver stac9766_dai[] = {
 {
 	.name = "stac9766-hifi-analog",
-	.ac97_control = 1,
 
 	/* stream cababilities */
 	.playback = {
@@ -309,7 +308,6 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 },
 {
 	.name = "stac9766-hifi-IEC958",
-	.ac97_control = 1,
 
 	/* stream cababilities */
 	.playback = {
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 2cb8a31..5b5118b 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -263,7 +263,6 @@ static const struct snd_soc_dai_ops wm9705_dai_ops = {
 static struct snd_soc_dai_driver wm9705_dai[] = {
 	{
 		.name = "wm9705-hifi",
-		.ac97_control = 1,
 		.playback = {
 			.stream_name = "HiFi Playback",
 			.channels_min = 1,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 6b36223..9fa794b 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -565,7 +565,6 @@ static const struct snd_soc_dai_ops wm9712_dai_ops_aux = {
 static struct snd_soc_dai_driver wm9712_dai[] = {
 {
 	.name = "wm9712-hifi",
-	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 2071df7..cd1b266 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1076,7 +1076,6 @@ static const struct snd_soc_dai_ops wm9713_dai_ops_voice = {
 static struct snd_soc_dai_driver wm9713_dai[] = {
 {
 	.name = "wm9713-hifi",
-	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
-- 
1.8.0
