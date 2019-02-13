From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: cros_ec_codec: Make symbol
	'cros_ec_dai' static
Date: Wed, 13 Feb 2019 06:29:56 +0000
Message-ID: <20190213062956.146536-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by alsa0.perex.cz (Postfix) with ESMTP id D9EF826789B
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 07:16:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Benson Leung <bleung@chromium.org>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warning:

sound/soc/codecs/cros_ec_codec.c:209:27: warning:
 symbol 'cros_ec_dai' was not declared. Should it be static?

Fixes: b291f42a3718 ("ASoC: cros_ec_codec: Add codec driver for Cros EC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index b14100b6a939..99a3af8a15ff 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -206,7 +206,7 @@ static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
 	.set_fmt = cros_ec_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver cros_ec_dai[] = {
+static struct snd_soc_dai_driver cros_ec_dai[] = {
 	{
 		.name = "cros_ec_codec I2S",
 		.id = 0,
