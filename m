From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: hda/ca0132: constify parameter table
	for effects
Date: Tue, 15 May 2018 22:13:00 +0900
Message-ID: <20180515131300.24315-5-o-takashi@sakamocchi.jp>
References: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id AF027267388
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:13:38 +0200 (CEST)
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so36926plo.7
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 06:13:38 -0700 (PDT)
In-Reply-To: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

This module has a table for parameters of each effects. This table is
read-only and can have 'const' qualifier.

This commit adds this optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/patch_ca0132.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 08a08dd16eab..292e2c592c17 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -189,7 +189,7 @@ struct ct_effect {
 #define EFX_DIR_OUT 0
 #define EFX_DIR_IN  1
 
-static struct ct_effect ca0132_effects[EFFECTS_COUNT] = {
+static const struct ct_effect ca0132_effects[EFFECTS_COUNT] = {
 	{ .name = "Surround",
 	  .nid = SURROUND,
 	  .mid = 0x96,
@@ -316,7 +316,7 @@ struct ct_tuning_ctl {
 	unsigned int def_val;/*effect default values*/
 };
 
-static struct ct_tuning_ctl ca0132_tuning_ctls[] = {
+static const struct ct_tuning_ctl ca0132_tuning_ctls[] = {
 	{ .name = "Wedge Angle",
 	  .parent_nid = VOICE_FOCUS,
 	  .nid = WEDGE_ANGLE,
@@ -431,14 +431,14 @@ struct ct_voicefx_preset {
 	unsigned int vals[VOICEFX_MAX_PARAM_COUNT];
 };
 
-static struct ct_voicefx ca0132_voicefx = {
+static const struct ct_voicefx ca0132_voicefx = {
 	.name = "VoiceFX Capture Switch",
 	.nid = VOICEFX,
 	.mid = 0x95,
 	.reqs = {10, 11, 12, 13, 14, 15, 16, 17, 18}
 };
 
-static struct ct_voicefx_preset ca0132_voicefx_presets[] = {
+static const struct ct_voicefx_preset ca0132_voicefx_presets[] = {
 	{ .name = "Neutral",
 	  .vals = { 0x00000000, 0x43C80000, 0x44AF0000,
 		    0x44FA0000, 0x3F800000, 0x3F800000,
@@ -527,7 +527,7 @@ struct ct_eq_preset {
 	unsigned int vals[EQ_PRESET_MAX_PARAM_COUNT];
 };
 
-static struct ct_eq ca0132_alt_eq_enum = {
+static const struct ct_eq ca0132_alt_eq_enum = {
 	.name = "FX: Equalizer Preset Switch",
 	.nid = EQ_PRESET_ENUM,
 	.mid = 0x96,
@@ -535,7 +535,7 @@ static struct ct_eq ca0132_alt_eq_enum = {
 };
 
 
-static struct ct_eq_preset ca0132_alt_eq_presets[] = {
+static const struct ct_eq_preset ca0132_alt_eq_presets[] = {
 	{ .name = "Flat",
 	 .vals = { 0x00000000, 0x00000000, 0x00000000,
 		   0x00000000, 0x00000000, 0x00000000,
@@ -655,7 +655,7 @@ struct ct_dsp_volume_ctl {
 	unsigned int reqs[3]; /* scp req ID */
 };
 
-static struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
+static const struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
 	{ .vnid = VNID_SPK,
 	  .mid = 0x32,
 	  .reqs = {3, 4, 2}
-- 
2.14.1
