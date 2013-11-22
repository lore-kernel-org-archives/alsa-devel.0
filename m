From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: wm8991: Verify device ID during
	probe()
Date: Fri, 22 Nov 2013 13:39:16 +0000
Message-ID: <1385127556-1661-4-git-send-email-broonie@kernel.org>
References: <1385127556-1661-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D8F6261AC1
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:39:28 +0100 (CET)
In-Reply-To: <1385127556-1661-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Just in case.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8991.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 5fdcf788e990..dba0306c42a5 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1335,6 +1335,7 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8991_priv *wm8991;
+	unsigned int val;
 	int ret;
 
 	wm8991 = devm_kzalloc(&i2c->dev, sizeof(*wm8991), GFP_KERNEL);
@@ -1347,6 +1348,16 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8991);
 
+	ret = regmap_read(wm8991->regmap, WM8991_RESET, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read device ID: %d\n", ret);
+		return ret;
+	}
+	if (val != 0x8991) {
+		dev_err(&i2c->dev, "Device with ID %x is not a WM8991\n", val);
+		return -EINVAL;
+	}
+
 	ret = regmap_write(wm8991->regmap, WM8991_RESET, 0);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
-- 
1.8.4.4
