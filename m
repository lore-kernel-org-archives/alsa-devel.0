From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l35: Disable regulators on driver
	removal
Date: Thu, 4 Apr 2019 17:27:20 +0100
Message-ID: <20190404162720.4995-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80F1EF8075B
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 18:27:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: patches@opensource.cirrus.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The chips main power supplies VA and VP are enabled during probe but
then never disabled, this will cause warnings from the regulator
framework on driver removal. Fix this by adding a remove callback and
disabling the supplies, whilst doing so follow best practice and put the
chip back into reset as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l35.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 9f4a59871cee7..c71696146c5ec 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1635,6 +1635,16 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	return ret;
 }
 
+static int cs35l35_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs35l35_private *cs35l35 = i2c_get_clientdata(i2c_client);
+
+	regulator_bulk_disable(cs35l35->num_supplies, cs35l35->supplies);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+
+	return 0;
+}
+
 static const struct of_device_id cs35l35_of_match[] = {
 	{.compatible = "cirrus,cs35l35"},
 	{},
@@ -1655,6 +1665,7 @@ static struct i2c_driver cs35l35_i2c_driver = {
 	},
 	.id_table = cs35l35_id,
 	.probe = cs35l35_i2c_probe,
+	.remove = cs35l35_i2c_remove,
 };
 
 module_i2c_driver(cs35l35_i2c_driver);
-- 
2.11.0
