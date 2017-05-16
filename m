From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: rt5665: make local symbol
	rt5665_i2c_driver static
Date: Tue, 16 May 2017 16:24:56 +0000
Message-ID: <20170516162456.18284-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id AE93D266C59
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 18:25:09 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id i63so21980109pgd.2
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:25:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

sound/soc/codecs/rt5665.c:4928:19: warning:
symbol 'rt5665_i2c_driver' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 26bf157..bb440bd 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4925,7 +4925,7 @@ static struct acpi_device_id rt5665_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5665_acpi_match);
 #endif
 
-struct i2c_driver rt5665_i2c_driver = {
+static struct i2c_driver rt5665_i2c_driver = {
 	.driver = {
 		.name = "rt5665",
 		.of_match_table = of_match_ptr(rt5665_of_match),
