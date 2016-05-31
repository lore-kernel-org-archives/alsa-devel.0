From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [RFC] sgtl5000: check VDDD-supply instead of
	revision
Date: Tue, 31 May 2016 17:58:05 +0000
Message-ID: <VI1PR0401MB204745C966DF72A027440647E3460@VI1PR0401MB2047.eurprd04.prod.outlook.com>
References: <20160531165803.GA20467@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0080.outbound.protection.outlook.com [157.55.234.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 9468B266B27
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:58:06 +0200 (CEST)
In-Reply-To: <20160531165803.GA20467@archie.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

[Sorry for the top-post]

I think this makes sense. Please submit a formal patch, thanks.

________________________________________
From: Clemens Gruber <clemens.gruber@pqgruber.com>
Sent: Tuesday, May 31, 2016 1:58:03 PM
To: alsa-devel@alsa-project.org
Cc: Mark Brown; Fabio Estevam
Subject: [RFC] sgtl5000: check VDDD-supply instead of revision

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

-       /* External VDDD only works before revision 0x11 */
-       if (sgtl5000->revision < 0x11) {
-               vddd = regulator_get_optional(codec->dev, "VDDD");
-               if (IS_ERR(vddd)) {
-                       /* See if it's just not registered yet */
-                       if (PTR_ERR(vddd) == -EPROBE_DEFER)
-                               return -EPROBE_DEFER;
-               } else {
-                       external_vddd = 1;
-                       regulator_put(vddd);
-               }
+       vddd = regulator_get_optional(codec->dev, "VDDD");
+       if (IS_ERR(vddd)) {
+               /* See if it's just not registered yet */
+               if (PTR_ERR(vddd) == -EPROBE_DEFER)
+                       return -EPROBE_DEFER;
+       } else {
+               external_vddd = 1;
+               regulator_put(vddd);
        }

        if (!external_vddd) {
--
2.8.3
