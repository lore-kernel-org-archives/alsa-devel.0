From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/9] ALSA: hda - Move vmaster TLV parsing to
	snd_hda_gen_parse_auto_config()
Date: Thu, 17 Jan 2013 17:54:51 +0100
Message-ID: <1358441694-32004-7-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B6A265368
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D3112A50E4
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

Add vmaster_tlv[] to hda_gen_spec and store the suggested TLV data
in snd_hda_gen_parse_auto_config().  This allows the codec driver to
correct the TLV data (e.g. mute capability) before actually creating
vmaster instance.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 8 ++++----
 sound/pci/hda/hda_generic.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 878556b..9c06749 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1601,6 +1601,9 @@ static int parse_output_paths(struct hda_codec *codec)
 		path = snd_hda_get_path_from_idx(codec, spec->out_paths[0]);
 		if (path)
 			spec->vmaster_nid = look_for_out_vol_nid(codec, path);
+		if (spec->vmaster_nid)
+			snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
+						HDA_OUTPUT, spec->vmaster_tlv);
 	}
 
 	kfree(best_cfg);
@@ -3752,11 +3755,8 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 	/* if we have no master control, let's create it */
 	if (!spec->no_analog &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
-		unsigned int vmaster_tlv[4];
-		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
-					HDA_OUTPUT, vmaster_tlv);
 		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
-					  vmaster_tlv, slave_pfxs,
+					  spec->vmaster_tlv, slave_pfxs,
 					  "Playback Volume");
 		if (err < 0)
 			return err;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 142a571..43a8482 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -214,6 +214,7 @@ struct hda_gen_spec {
 
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
+	unsigned int vmaster_tlv[4];
 	struct hda_vmaster_mute_hook vmaster_mute;
 #ifdef CONFIG_PM
 	struct hda_loopback_check loopback;
-- 
1.8.1
