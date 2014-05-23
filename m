From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: snd-usb: mixer: remove error
	messages on failed kmalloc()
Date: Fri, 23 May 2014 19:06:02 +0200
Message-ID: <1400864762-19458-2-git-send-email-zonque@gmail.com>
References: <1400864762-19458-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E3B3264FFF
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 19:06:17 +0200 (CEST)
Received: by mail-we0-f169.google.com with SMTP id u56so5225369wes.14
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 10:06:16 -0700 (PDT)
In-Reply-To: <1400864762-19458-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

If kmalloc() fails, warnings will be loud enough. We can safely just
return -ENOMEM in such cases.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/mixer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index e13e0c1..ccdd4cb 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1229,10 +1229,8 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		return;
 
 	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
-	if (!cval) {
-		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+	if (!cval)
 		return;
-	}
 	cval->mixer = state->mixer;
 	cval->id = unitid;
 	cval->control = control;
@@ -1815,10 +1813,8 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 		if (check_ignored_ctl(map))
 			continue;
 		cval = kzalloc(sizeof(*cval), GFP_KERNEL);
-		if (!cval) {
-			usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		if (!cval)
 			return -ENOMEM;
-		}
 		cval->mixer = state->mixer;
 		cval->id = unitid;
 		cval->control = valinfo->control;
@@ -1849,7 +1845,6 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
 		if (!kctl) {
-			usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 			kfree(cval);
 			return -ENOMEM;
 		}
@@ -2028,10 +2023,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		return 0;
 
 	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
-	if (!cval) {
-		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+	if (!cval)
 		return -ENOMEM;
-	}
 	cval->mixer = state->mixer;
 	cval->id = unitid;
 	cval->val_type = USB_MIXER_U8;
@@ -2048,7 +2041,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 
 	namelist = kmalloc(sizeof(char *) * desc->bNrInPins, GFP_KERNEL);
 	if (!namelist) {
-		usb_audio_err(state->chip, "cannot malloc\n");
 		kfree(cval);
 		return -ENOMEM;
 	}
@@ -2058,7 +2050,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		len = 0;
 		namelist[i] = kmalloc(MAX_ITEM_NAME_LEN, GFP_KERNEL);
 		if (!namelist[i]) {
-			usb_audio_err(state->chip, "cannot malloc\n");
 			while (i--)
 				kfree(namelist[i]);
 			kfree(namelist);
@@ -2075,7 +2066,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (!kctl) {
-		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		kfree(namelist);
 		kfree(cval);
 		return -ENOMEM;
-- 
1.9.0
