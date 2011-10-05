From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix DAC assignment for secondary
 headphone on Sigmatel/IDT
Date: Wed, 05 Oct 2011 10:00:18 +0200
Message-ID: <4E8C0E92.3000502@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040409070004050505030701"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 80DAD103A07
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 10:00:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040409070004050505030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch should be safe enough for 3.2, but do you think it is safe 
enough for stable as well?

If we run out of DACs when trying to assign a DAC to a secondary
headphone, prefer the DAC of the first headphone to the primary
(usually line out) DAC.

BugLink: http://bugs.launchpad.net/bugs/845275 (there are codec info at 
this link as well)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040409070004050505030701
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-DAC-assignment-for-secondary-headphone-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-DAC-assignment-for-secondary-headphone-.pa";
 filename*1="tch"

>From 465121dd0bbb8e5da99b0fd709bfdcd42a4961e9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 5 Oct 2011 09:49:05 +0200
Subject: [PATCH] ALSA: HDA: Fix DAC assignment for secondary headphone on
 Sigmatel/IDT

If we run out of DACs when trying to assign a DAC to a secondary
headphone, prefer the DAC of the first headphone to the primary
(usually line out) DAC.

BugLink: http://bugs.launchpad.net/bugs/845275
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index dd977b6..1e0b338 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2972,8 +2972,9 @@ static int check_all_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
 static hda_nid_t get_unassigned_dac(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int j, conn_len;
-	hda_nid_t conn[HDA_MAX_CONNECTIONS];
+	hda_nid_t conn[HDA_MAX_CONNECTIONS], fallback_dac;
 	unsigned int wcaps, wtype;
 
 	conn_len = snd_hda_get_connections(codec, nid, conn,
@@ -3001,10 +3002,21 @@ static hda_nid_t get_unassigned_dac(struct hda_codec *codec, hda_nid_t nid)
 			return conn[j];
 		}
 	}
-	/* if all DACs are already assigned, connect to the primary DAC */
+
+	/* if all DACs are already assigned, connect to the primary DAC,
+	   unless we're assigning a secondary headphone */
+	fallback_dac = spec->multiout.dac_nids[0];
+	if (spec->multiout.hp_nid) {
+		for (j = 0; j < cfg->hp_outs; j++)
+			if (cfg->hp_pins[j] == nid) {
+				fallback_dac = spec->multiout.hp_nid;
+				break;
+			}
+	}
+
 	if (conn_len > 1) {
 		for (j = 0; j < conn_len; j++) {
-			if (conn[j] == spec->multiout.dac_nids[0]) {
+			if (conn[j] == fallback_dac) {
 				snd_hda_codec_write_cache(codec, nid, 0,
 						  AC_VERB_SET_CONNECT_SEL, j);
 				break;
-- 
1.7.5.4


--------------040409070004050505030701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040409070004050505030701--
