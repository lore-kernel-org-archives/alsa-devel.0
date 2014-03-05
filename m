From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Use analog beep for Thinkpads
	with AD1984 codecs
Date: Wed,  5 Mar 2014 12:02:16 +0100
Message-ID: <1394017336-23422-2-git-send-email-tiwai@suse.de>
References: <1394017336-23422-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D8AD265CF2
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 12:02:17 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A441FACCC
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 11:02:16 +0000 (UTC)
In-Reply-To: <1394017336-23422-1-git-send-email-tiwai@suse.de>
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

For making the driver behavior compatible with the earlier kernels,
use the analog beep in the loopback path instead of the digital beep.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 498971095869..8ed0bcc01386 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1026,6 +1026,9 @@ static void ad1884_fixup_thinkpad(struct hda_codec *codec,
 		spec->gen.keep_eapd_on = 1;
 		spec->gen.vmaster_mute.hook = ad_vmaster_eapd_hook;
 		spec->eapd_nid = 0x12;
+		/* Analog PC Beeper - allow firmware/ACPI beeps */
+		spec->beep_amp = HDA_COMPOSE_AMP_VAL(0x20, 3, 3, HDA_INPUT);
+		spec->gen.beep_nid = 0; /* no digital beep */
 	}
 }
 
-- 
1.9.0
