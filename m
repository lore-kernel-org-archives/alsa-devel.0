From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: wm8580: Fix non static symbol warnings
Date: Sat, 29 Oct 2016 16:27:23 +0000
Message-ID: <1477758443-5682-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matt Flax <flatmax@flatmax.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

sound/soc/codecs/wm8580.c:988:33: warning:
 symbol 'wm8580_data' was not declared. Should it be static?
sound/soc/codecs/wm8580.c:992:33: warning:
 symbol 'wm8581_data' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/wm8580.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index aecd3c9..da93b70 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -985,11 +985,11 @@ static const struct regmap_config wm8580_regmap = {
 	.volatile_reg = wm8580_volatile,
 };
 
-const struct wm8580_driver_data wm8580_data = {
+static const struct wm8580_driver_data wm8580_data = {
 	.num_dacs = 3,
 };
 
-const struct wm8580_driver_data wm8581_data = {
+static const struct wm8580_driver_data wm8581_data = {
 	.num_dacs = 4,
 };
