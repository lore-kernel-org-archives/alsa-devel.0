From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2] ASoC: ssm2518: Add explicit device tree
	support
Date: Thu, 13 Aug 2015 15:10:19 +0200
Message-ID: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B8200261A3B
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 15:10:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


Add OF match table to SSM2518 to allow direct matching without going
through I2C subsystem.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>

---
 sound/soc/codecs/ssm2518.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 67ea55a..2d199b1 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -811,6 +811,14 @@ static int ssm2518_i2c_remove(struct i2c_client *clien=
t)
 	return 0;
 }
 =

+#ifdef CONFIG_OF
+static const struct of_device_id ssm2518_dt_ids[] =3D {
+	{ .compatible =3D "adi,ssm2518", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm2518_dt_ids);
+#endif
+
 static const struct i2c_device_id ssm2518_i2c_ids[] =3D {
 	{ "ssm2518", 0 },
 	{ }
@@ -821,6 +829,7 @@ static struct i2c_driver ssm2518_driver =3D {
 	.driver =3D {
 		.name =3D "ssm2518",
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(ssm2518_dt_ids),
 	},
 	.probe =3D ssm2518_i2c_probe,
 	.remove =3D ssm2518_i2c_remove,
-- =

1.7.10.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
