From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] ASoC: wm8731: init mutex in i2c init path
Date: Mon, 19 Jan 2015 08:23:43 +0100
Message-ID: <1421652223-721475-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

The I2C init path forgot to init the mutex, leading to an oops when
controls are accessed.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Fixes an oops on bootup when alsactl tries to restore codec parameters
on my MIPS DB1300 board.

 sound/soc/codecs/wm8731.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index b9211b4..b115ed8 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -717,6 +717,8 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	mutex_init(&wm8731->lock);
+
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
-- 
2.2.1

