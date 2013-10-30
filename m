From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable AA-loopback on ALC283
	Chromebook
Date: Wed, 30 Oct 2013 07:53:59 +0100
Message-ID: <1383116039-29895-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7378A2625F3
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 07:51:11 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 482A8A57B7
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 07:51:11 +0100 (CET)
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

ALC283-based Chromebook suffers from occasional white noise, and it
turned out that this comes from AA-loopback.  Disable this output path
by just clearing mixer_nid, then the generic parser will skip the
creation of AA-loopback path.

Reported-and-tested-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 894703532ab7..c516fa93ee63 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3445,6 +3445,8 @@ static void alc283_fixup_chromebook(struct hda_codec *codec,
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		alc283_chromebook_caps(codec);
+		/* Disable AA-loopback as it causes white noise */
+		spec->gen.mixer_nid = 0;
 		spec->gen.hp_automute_hook = alc283_hp_automute_hook;
 		/* MIC2-VREF control */
 		/* Set to manual mode */
-- 
1.8.4.1
