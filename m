From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 16/18] ALSA: hda: move patch_via to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:53 +0100
Message-ID: <1444144075-28963-17-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3352E2658A0
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:56 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_via to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_via.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index da5366405eda..81bbc7d48911 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -208,7 +208,7 @@ static void vt1708_stop_hp_work(struct hda_codec *codec)
 	if (spec->codec_type != VT1708 || !spec->gen.autocfg.hp_outs)
 		return;
 	if (spec->hp_work_active) {
-		snd_hda_codec_write(codec, 0x1, 0, 0xf81, 1);
+		snd_hdac_codec_write(&codec->core, 0x1, 0, 0xf81, 1);
 		codec->jackpoll_interval = 0;
 		cancel_delayed_work_sync(&codec->jackpoll_work);
 		spec->hp_work_active = false;
@@ -223,7 +223,7 @@ static void vt1708_update_hp_work(struct hda_codec *codec)
 	if (spec->vt1708_jack_detect) {
 		if (!spec->hp_work_active) {
 			codec->jackpoll_interval = msecs_to_jiffies(100);
-			snd_hda_codec_write(codec, 0x1, 0, 0xf81, 0);
+			snd_hdac_codec_write(&codec->core, 0x1, 0, 0xf81, 0);
 			schedule_delayed_work(&codec->jackpoll_work, 0);
 			spec->hp_work_active = true;
 		}
@@ -395,7 +395,7 @@ static void __analog_low_current_mode(struct hda_codec *codec, bool force)
 		return;		/* other codecs are not supported */
 	}
 	/* send verb */
-	snd_hda_codec_write(codec, codec->core.afg, 0, verb, parm);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0, verb, parm);
 }
 
 static void analog_low_current_mode(struct hda_codec *codec)
@@ -944,8 +944,8 @@ static int vt1716s_dmic_get(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	int index = 0;
 
-	index = snd_hda_codec_read(codec, 0x26, 0,
-					       AC_VERB_GET_CONNECT_SEL, 0);
+	index = snd_hdac_codec_read(&codec->core, 0x26, 0,
+				    AC_VERB_GET_CONNECT_SEL, 0);
 	if (index != -1)
 		*ucontrol->value.integer.value = index;
 
@@ -959,8 +959,8 @@ static int vt1716s_dmic_put(struct snd_kcontrol *kcontrol,
 	struct via_spec *spec = codec->spec;
 	int index = *ucontrol->value.integer.value;
 
-	snd_hda_codec_write(codec, 0x26, 0,
-					       AC_VERB_SET_CONNECT_SEL, index);
+	snd_hdac_codec_write(&codec->core, 0x26, 0, AC_VERB_SET_CONNECT_SEL,
+			     index);
 	spec->dmic_enabled = index;
 	return 1;
 }
-- 
2.4.3
