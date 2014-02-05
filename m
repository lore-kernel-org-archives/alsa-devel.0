From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add missing mixer widget for AD1983
Date: Wed,  5 Feb 2014 07:33:31 +0100
Message-ID: <1391582011-3919-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A92261B07
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 07:33:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 247EDAAD1
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 06:33:31 +0000 (UTC)
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

The mixer widget on AD1983 at NID 0x0e was missing in the commit
[f2f8be43c5c9: ALSA: hda - Add aamix NID to AD codecs].

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=70011
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 50b2427f19ca..195cd62cdce5 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -498,6 +498,7 @@ static int patch_ad1983(struct hda_codec *codec)
 		return err;
 	spec = codec->spec;
 
+	spec->gen.mixer_nid = 0x0e;
 	spec->gen.beep_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 	err = ad198x_parse_auto_config(codec, false);
-- 
1.8.5.2
