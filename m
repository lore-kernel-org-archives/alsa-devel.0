From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [RFC] sgtl5000: check VDDD-supply instead of revision
Date: Tue, 31 May 2016 18:58:03 +0200
Message-ID: <20160531165803.GA20467@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pqgruber.com (mail.pqgruber.com [178.189.19.235])
 by alsa0.perex.cz (Postfix) with ESMTP id CA11226646E
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 18:58:05 +0200 (CEST)
Content-Disposition: inline
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using a SGTL5000 rev 0x11 with external VDDD, as recommended by NXP
documentation and errata sheet:
http://cache.nxp.com/files/analog/doc/errata/SGTL5000ER.pdf
The linux sgtl5000 codec driver contains a comment, warning that
external VDDD can't be used on revisions >= 0x11, which is probably a
leftover from the first implementation. This is very confusing because
it contradicts the NXP documentation.
Also, on every boot, the user gets a warning that the SGTL5000 is using
the internal LDO (even though external VDDD is present).

Maybe instead of checking the revision, we should only check if the
VDDD-supply regulator exists and only if it does not exist, call
sgtl5000_replace_vddd_with_ldo?

I'd like to hear your comments if this approach is valid or if I missed
something in my assumptions.

In my DT, the VDDD-supply regulator is just a dummy / regulator-fixed
with regulator-always-on; set, because the 1.8V external VDDD supply on
my board is always powered on.
I could not test if it works with regulator-fixed with gpio nodes, which
actually switch the supply line on or off.

If everything is OK, I'd send a formal patch to the mailing list. See
below for the current state of my patch.

Tested on an i.MX6Q board with SGTL5000 rev 0x11 and external VDDD.

Thanks,
Clemens

---
 sound/soc/codecs/sgtl5000.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 08b4046..fbad4fb 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1286,17 +1286,14 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
 		sgtl5000->supplies[i].supply = supply_names[i];
 
-	/* External VDDD only works before revision 0x11 */
-	if (sgtl5000->revision < 0x11) {
-		vddd = regulator_get_optional(codec->dev, "VDDD");
-		if (IS_ERR(vddd)) {
-			/* See if it's just not registered yet */
-			if (PTR_ERR(vddd) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-		} else {
-			external_vddd = 1;
-			regulator_put(vddd);
-		}
+	vddd = regulator_get_optional(codec->dev, "VDDD");
+	if (IS_ERR(vddd)) {
+		/* See if it's just not registered yet */
+		if (PTR_ERR(vddd) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		external_vddd = 1;
+		regulator_put(vddd);
 	}
 
 	if (!external_vddd) {
-- 
2.8.3
