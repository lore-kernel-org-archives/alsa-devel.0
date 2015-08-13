From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] Add rudimentary device tree support for SSM2518
Date: Thu, 13 Aug 2015 14:12:26 +0200
Message-ID: <alpine.DEB.2.02.1508131404050.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 283362619F5
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id CA6092E506
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:33 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id AsBtMGmqrRBw for <alsa-devel@alsa-project.org>;
 Thu, 13 Aug 2015 14:12:31 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 5CC982E5C2
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:26 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 9EEE51404
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:26 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 93253F9D
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:26 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 8FF5134005
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:12:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


For some reason the SSM2518 codec driver doesn't have DT support, even =

though there are bindings described for it in =

Documentation/devicetree/sound/ssm2518.txt . This patch adds rudimentary =

DT support for the compatible property which is a step forward.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/soc/codecs/ssm2518.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 67ea55a..ecf9996 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -811,6 +810,14 @@ static int ssm2518_i2c_remove(struct i2c_client *clien=
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
@@ -821,6 +828,9 @@ static struct i2c_driver ssm2518_driver =3D {
 	.driver =3D {
 		.name =3D "ssm2518",
 		.owner =3D THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table =3D of_match_ptr(ssm2518_dt_ids),
+#endif
 	},
 	.probe =3D ssm2518_i2c_probe,
 	.remove =3D ssm2518_i2c_remove,
-- =

1.7.10.4


-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
