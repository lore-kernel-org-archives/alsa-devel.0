From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Always allow access for
	POWER_STATE verbs
Date: Thu,  9 Apr 2015 08:24:20 +0200
Message-ID: <1428560660-18109-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E82260415
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 08:24:22 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E2E66ABCA
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 06:24:21 +0000 (UTC)
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

The hdac regmap code checks whether the codec is powered on while
accessing, but there must be an exception -- the verbs to control the
power state.

Currently HD-audio driver doesn't access them via regmap, so this
patch doesn't fix any current behavior, but it's just for future.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_regmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 64876fa357c9..51f1b5c8a91c 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -239,7 +239,7 @@ static int hda_reg_read(void *context, unsigned int reg, unsigned int *val)
 	int verb = get_verb(reg);
 	int err;
 
-	if (!codec_is_running(codec))
+	if (!codec_is_running(codec) && verb != AC_VERB_GET_POWER_STATE)
 		return -EAGAIN;
 	reg |= (codec->addr << 28);
 	if (is_stereo_amp_verb(reg))
@@ -265,16 +265,16 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 	unsigned int verb;
 	int i, bytes, err;
 
-	if (!codec_is_running(codec))
-		return codec->lazy_cache ? 0 : -EAGAIN;
-
 	reg &= ~0x00080000U; /* drop GET bit */
 	reg |= (codec->addr << 28);
+	verb = get_verb(reg);
+
+	if (!codec_is_running(codec) && verb != AC_VERB_SET_POWER_STATE)
+		return codec->lazy_cache ? 0 : -EAGAIN;
 
 	if (is_stereo_amp_verb(reg))
 		return hda_reg_write_stereo_amp(codec, reg, val);
 
-	verb = get_verb(reg);
 	if (verb == AC_VERB_SET_PROC_COEF)
 		return hda_reg_write_coef(codec, reg, val);
 
-- 
2.3.5
