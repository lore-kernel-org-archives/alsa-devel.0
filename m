From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/12] ALSA: hda - Add aamix NID to IDT 92HD
	codecs
Date: Mon, 21 Jan 2013 17:06:15 +0100
Message-ID: <1358784377-26102-11-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9902D26260B
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 2BF14A51F6
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

IDT codecs have analog-loopback mixer widgets, but we haven't cared
about it, so far.  Let's set them.  This will avoid also possible
wrong routes for the input paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index fd29f49..c53b6f9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3743,6 +3743,7 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
+	spec->gen.mixer_nid = 0x1d;
 
 	num_dacs = snd_hda_get_num_conns(codec, 0x0a) - 1;
 	if (num_dacs < 3 || num_dacs > 5) {
@@ -3840,6 +3841,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
+	spec->gen.mixer_nid = 0x1b;
 
 	spec->digbeep_nid = 0x21;
 	spec->pwr_nids = stac92hd83xxx_pwr_nids;
@@ -3882,6 +3884,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
+	spec->gen.mixer_nid = 0x17;
 
 	codec->patch_ops = stac_patch_ops;
 
-- 
1.8.1.1
