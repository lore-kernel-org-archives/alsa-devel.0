From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Remove analog mic pin override
	from STAC9228 dell-bios quirk
Date: Mon, 29 Jul 2013 16:30:46 +0200
Message-ID: <1375108246-26890-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 840DF261AE7
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 16:29:17 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 555DAA50DE
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 16:29:17 +0200 (CEST)
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

The current fixup for dell-bios model with STAC9228 codec contains the
override of pin 0x0c for analog mic.  But this is actually just adding
a bogus pin and confuses the parser.  Better to remove it for the
auto-mic switching.

Meanwhile, for a possible regression, keep the old configuration as
model=dell-bios-amic, so that people can test it again quickly.

Tested on Dell 1420n laptop.

Reported-and-tested-by: Eric Shattow <lucent@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |  1 +
 sound/pci/hda/patch_sigmatel.c               | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 809d72b..a46ddb8 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -244,6 +244,7 @@ STAC9227/9228/9229/927x
   5stack-no-fp	D965 5stack without front panel
   dell-3stack	Dell Dimension E520
   dell-bios	Fixes with Dell BIOS setup
+  dell-bios-amic Fixes with Dell BIOS setup including analog mic
   volknob	Fixes with volume-knob widget 0x24
   auto		BIOS setup (default)
 
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index e2f8359..8f6c357 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -158,6 +158,7 @@ enum {
 	STAC_D965_VERBS,
 	STAC_DELL_3ST,
 	STAC_DELL_BIOS,
+	STAC_DELL_BIOS_AMIC,
 	STAC_DELL_BIOS_SPDIF,
 	STAC_927X_DELL_DMIC,
 	STAC_927X_VOLKNOB,
@@ -3228,8 +3229,6 @@ static const struct hda_fixup stac927x_fixups[] = {
 	[STAC_DELL_BIOS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			/* configure the analog microphone on some laptops */
-			{ 0x0c, 0x90a79130 },
 			/* correct the front output jack as a hp out */
 			{ 0x0f, 0x0227011f },
 			/* correct the front input jack as a mic */
@@ -3239,6 +3238,16 @@ static const struct hda_fixup stac927x_fixups[] = {
 		.chained = true,
 		.chain_id = STAC_927X_DELL_DMIC,
 	},
+	[STAC_DELL_BIOS_AMIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* configure the analog microphone on some laptops */
+			{ 0x0c, 0x90a79130 },
+			{}
+		},
+		.chained = true,
+		.chain_id = STAC_DELL_BIOS,
+	},
 	[STAC_DELL_BIOS_SPDIF] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -3267,6 +3276,7 @@ static const struct hda_model_fixup stac927x_models[] = {
 	{ .id = STAC_D965_5ST_NO_FP, .name = "5stack-no-fp" },
 	{ .id = STAC_DELL_3ST, .name = "dell-3stack" },
 	{ .id = STAC_DELL_BIOS, .name = "dell-bios" },
+	{ .id = STAC_DELL_BIOS_AMIC, .name = "dell-bios-amic" },
 	{ .id = STAC_927X_VOLKNOB, .name = "volknob" },
 	{}
 };
-- 
1.8.3.1
