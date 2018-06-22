From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/16] ALSA: hda/realtek - Use common GPIO mask
	for ALC660VD ASUS fixup
Date: Fri, 22 Jun 2018 11:53:45 +0200
Message-ID: <20180622095352.19451-10-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D404267700
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B06A1AFA8
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The ALC660VD_FIX_ASUS_GPIO1 quirk requires to set up GPIO bit0 ON
while bit 1 OFF.  Implement the fixup function and convert from the
static init verbs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2cda4a614435..1ee086bcefcf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7354,16 +7354,21 @@ static void alc861vd_fixup_dallas(struct hda_codec *codec,
 	}
 }
 
+/* reset GPIO1 */
+static void alc660vd_fixup_asus_gpio1(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->gpio_mask |= 0x02;
+	alc_fixup_gpio(codec, action, 0x01);
+}
+
 static const struct hda_fixup alc861vd_fixups[] = {
 	[ALC660VD_FIX_ASUS_GPIO1] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			/* reset GPIO1 */
-			{0x01, AC_VERB_SET_GPIO_MASK, 0x03},
-			{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x01},
-			{0x01, AC_VERB_SET_GPIO_DATA, 0x01},
-			{ }
-		}
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc660vd_fixup_asus_gpio1,
 	},
 	[ALC861VD_FIX_DALLAS] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.17.1
