From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ASoC codec: fix compiling error in ad1980
	driver after ASoC API changed
Date: Thu,  4 Sep 2008 16:25:54 +0800
Message-ID: <1220516754-20865-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F1F5245D4
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 10:25:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/codecs/ad1980.c |    2 +-
 sound/soc/codecs/ad1980.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index bfbab3d..4e09c1f 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -141,7 +141,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
-struct snd_soc_codec_dai ad1980_dai = {
+struct snd_soc_dai ad1980_dai = {
 	.name = "AC97",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/ad1980.h b/sound/soc/codecs/ad1980.h
index 5d4710d..db6c850 100644
--- a/sound/soc/codecs/ad1980.h
+++ b/sound/soc/codecs/ad1980.h
@@ -17,7 +17,7 @@
 #define PR5		0x2000
 #define PR6		0x4000
 
-extern struct snd_soc_codec_dai ad1980_dai;
+extern struct snd_soc_dai ad1980_dai;
 extern struct snd_soc_codec_device soc_codec_dev_ad1980;
 
 #endif
-- 
1.5.6
