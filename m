From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Use a helper function for
	renaming kctl names
Date: Sun, 23 Apr 2017 21:00:25 +0200
Message-ID: <20170423190025.28911-5-tiwai@suse.de>
References: <20170423190025.28911-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A5418266A9D
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 21:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A48F8AB5F
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 19:00:32 +0000 (UTC)
In-Reply-To: <20170423190025.28911-1-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e81cf83d2afd..57eeefd36f19 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4724,7 +4724,6 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 		{ 0x1b, 0x21114000 }, /* dock speaker pin */
 		{}
 	};
-	struct snd_kcontrol *kctl;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
@@ -4739,12 +4738,10 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 		/* this is a bit tricky; give more sane names for the main
 		 * (tablet) speaker and the dock speaker, respectively
 		 */
-		kctl = snd_hda_find_mixer_ctl(codec, "Speaker Playback Switch");
-		if (kctl)
-			strcpy(kctl->id.name, "Dock Speaker Playback Switch");
-		kctl = snd_hda_find_mixer_ctl(codec, "Bass Speaker Playback Switch");
-		if (kctl)
-			strcpy(kctl->id.name, "Speaker Playback Switch");
+		rename_ctl(codec, "Speaker Playback Switch",
+			   "Dock Speaker Playback Switch");
+		rename_ctl(codec, "Bass Speaker Playback Switch",
+			   "Speaker Playback Switch");
 		break;
 	}
 }
-- 
2.11.1
