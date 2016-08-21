From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: max98371: Add terminate entry for i2c_device_id tables
Date: Sun, 21 Aug 2016 15:37:16 +0000
Message-ID: <1471793836-28055-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Markus Elfring <elfring@users.sourceforge.net>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Make sure i2c_device_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/max98371.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 3053879..781be9ba 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -412,6 +412,7 @@ static int max98371_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id max98371_i2c_id[] = {
 	{ "max98371", 0 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, max98371_i2c_id);
