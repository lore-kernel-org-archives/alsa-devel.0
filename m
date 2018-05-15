From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: hda/ca0132: constify read-only
	members of string array
Date: Tue, 15 May 2018 22:12:58 +0900
Message-ID: <20180515131300.24315-3-o-takashi@sakamocchi.jp>
References: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id F2A59267021
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:13:34 +0200 (CEST)
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so30663plj.10
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 06:13:34 -0700 (PDT)
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

This module has some strings just for printk therefore they can be
read-only.

This commit applies this optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/patch_ca0132.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d18022d72e83..8295bd06af66 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -90,7 +90,7 @@ MODULE_FIRMWARE(SBZ_EFX_FILE);
 MODULE_FIRMWARE(R3DI_EFX_FILE);
 #endif
 
-static const char *dirstr[2] = { "Playback", "Capture" };
+static const char *const dirstr[2] = { "Playback", "Capture" };
 
 #define NUM_OF_OUTPUTS 3
 enum {
@@ -105,7 +105,7 @@ enum {
 };
 
 /* Strings for Input Source Enum Control */
-static const char *in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };
+static const char *const in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };
 #define IN_SRC_NUM_OF_INPUTS 3
 enum {
 	REAR_MIC,
@@ -4992,7 +4992,7 @@ static int ca0132_alt_output_select_put(struct snd_kcontrol *kcontrol,
  * and night, disregard the slider value and have uneditable values.
  */
 #define NUM_OF_SVM_SETTINGS 3
-static const char *out_svm_set_enum_str[3] = {"Normal", "Loud", "Night" };
+static const char *const out_svm_set_enum_str[3] = {"Normal", "Loud", "Night" };
 
 static int ca0132_alt_svm_setting_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
-- 
2.14.1
