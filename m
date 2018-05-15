From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: hda/ca0132: merge strings just for
	printk
Date: Tue, 15 May 2018 22:12:59 +0900
Message-ID: <20180515131300.24315-4-o-takashi@sakamocchi.jp>
References: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A14C2671C0
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:13:36 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id w129-v6so37143pfd.3
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 06:13:36 -0700 (PDT)
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

This module has some function-local strings just for printk therefore
it can be merged into format string.

This commit applies this optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/patch_ca0132.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8295bd06af66..08a08dd16eab 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5506,13 +5506,12 @@ static int ca0132_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 static int ca0132_alt_add_effect_slider(struct hda_codec *codec, hda_nid_t nid,
 					const char *pfx, int dir)
 {
-	char *fx = "FX:";
 	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_VOLUME_MONO(namestr, nid, 1, 0, type);
 
-	sprintf(namestr, "%s %s %s Volume", fx, pfx, dirstr[dir]);
+	sprintf(namestr, "FX: %s %s Volume", pfx, dirstr[dir]);
 
 	knew.tlv.c = 0;
 	knew.tlv.p = 0;
@@ -5544,7 +5543,6 @@ static int add_fx_switch(struct hda_codec *codec, hda_nid_t nid,
 			 const char *pfx, int dir)
 {
 	struct ca0132_spec *spec = codec->spec;
-	char *fx = "FX:";
 	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
@@ -5553,7 +5551,7 @@ static int add_fx_switch(struct hda_codec *codec, hda_nid_t nid,
 	 * prefix to OutFX or InFX enable controls.
 	 */
 	if ((spec->use_alt_controls) && (nid <= IN_EFFECT_END_NID))
-		sprintf(namestr, "%s %s %s Switch", fx, pfx, dirstr[dir]);
+		sprintf(namestr, "FX: %s %s Switch", pfx, dirstr[dir]);
 	else
 		sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
 
-- 
2.14.1
