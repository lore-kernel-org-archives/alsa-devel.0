From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoC: ics43432: Fix build errors
Date: Fri, 28 Aug 2015 12:11:48 +0200
Message-ID: <alpine.DEB.2.02.1508281200060.16666@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 79B5E260469
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 12:12:04 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


Fix build errors

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---

Not sure how the incorrect name or the misspelled license string got =

through my local build, perhaps because I've been developing this for an =

ARM system? Have now set up a tree to build for x86 as well, where the =

errors manifest themselves, to avoid this type of stuff happening in the =

future.

 sound/soc/codecs/ics43432.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
index d217fed..465d591 100644
--- a/sound/soc/codecs/ics43432.c
+++ b/sound/soc/codecs/ics43432.c
@@ -57,7 +57,7 @@ static const struct of_device_id ics43432_ids[] =3D {
 	{ .compatible =3D "invensense,ics43432", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, ics43432_dt_ids);
+MODULE_DEVICE_TABLE(of, ics43432_ids);
 #endif
 =

 static struct platform_driver ics43432_driver =3D {
@@ -73,4 +73,4 @@ module_platform_driver(ics43432_driver);
 =

 MODULE_DESCRIPTION("ASoC ICS43432 driver");
 MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- =

1.7.10.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
