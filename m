From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Minor code optimization for
	patch_realtek.c
Date: Tue,  7 Jan 2014 18:23:52 +0100
Message-ID: <1389115432-20702-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3906D2650C1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:23:52 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32EAEAC3C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:23:52 +0000 (UTC)
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

No functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6a705a81de35..74b496b0d179 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -469,9 +469,7 @@ static bool found_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
  *	7  ~ 0	:	Assembly ID
  *	port-A --> pin 39/41, port-E --> pin 14/15, port-D --> pin 35/36
  */
-static int alc_subsystem_id(struct hda_codec *codec,
-			    hda_nid_t porta, hda_nid_t porte,
-			    hda_nid_t portd, hda_nid_t porti)
+static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 {
 	unsigned int ass, tmp, i;
 	unsigned nid;
@@ -561,14 +559,7 @@ do_sku:
 	      spec->gen.autocfg.line_out_type == AUTO_PIN_HP_OUT)) {
 		hda_nid_t nid;
 		tmp = (ass >> 11) & 0x3;	/* HP to chassis */
-		if (tmp == 0)
-			nid = porta;
-		else if (tmp == 1)
-			nid = porte;
-		else if (tmp == 2)
-			nid = portd;
-		else if (tmp == 3)
-			nid = porti;
+		nid = ports[tmp];
 		if (found_in_nid_list(nid, spec->gen.autocfg.line_out_pins,
 				      spec->gen.autocfg.line_outs))
 			return 1;
@@ -581,7 +572,7 @@ do_sku:
  * ports contains an array of 4 pin NIDs for port-A, E, D and I */
 static void alc_ssid_check(struct hda_codec *codec, const hda_nid_t *ports)
 {
-	if (!alc_subsystem_id(codec, ports[0], ports[1], ports[2], ports[3])) {
+	if (!alc_subsystem_id(codec, ports)) {
 		struct alc_spec *spec = codec->spec;
 		snd_printd("realtek: "
 			   "Enable default setup for auto mode as fallback\n");
-- 
1.8.5.2
