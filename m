From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 080/112] ALSA: hda - Add inv_eapd flag to
	struct hda_codec
Date: Tue,  8 Jan 2013 12:39:13 +0100
Message-ID: <1357645185-7645-81-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9985C26520F
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8C93AA5356
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Add the new flag, codec->inv_eapd, indicating that the EAPD
implementation is inverted.

There are always broken hardware in the world.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h   | 1 +
 sound/pci/hda/hda_generic.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 2d9a51c..369ffaf 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -866,6 +866,7 @@ struct hda_codec {
 	unsigned int pins_shutup:1;	/* pins are shut up */
 	unsigned int no_trigger_sense:1; /* don't trigger at pin-sensing */
 	unsigned int no_jack_detect:1;	/* Machine has no jack-detection */
+	unsigned int inv_eapd:1; /* broken h/w: inverted EAPD control */
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
 	unsigned int epss:1;		/* supporting EPSS? */
 	unsigned int cached_write:1;	/* write only to caches */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index cc47460..18daa8f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -545,6 +545,8 @@ static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
 	if (spec->own_eapd_ctl ||
 	    !(snd_hda_query_pin_caps(codec, pin) & AC_PINCAP_EAPD))
 		return;
+	if (codec->inv_eapd)
+		enable = !enable;
 	snd_hda_codec_update_cache(codec, pin, 0,
 				   AC_VERB_SET_EAPD_BTLENABLE,
 				   enable ? 0x02 : 0x00);
-- 
1.8.0.1
