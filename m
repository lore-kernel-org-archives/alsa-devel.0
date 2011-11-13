From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] [Trivial] sound, realtek: remove redundant semicolon
Date: Sun, 13 Nov 2011 23:11:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111132308530.3681@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jiri Kosina <trivial@kernel.org>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, Kailang Yang <kailang@realtek.com.tw>, PeiSen Hou <pshou@realtek.com.tw>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Having just one semicolon after a break statement is enough.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 308bb57..336d14e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1452,7 +1452,7 @@ static void alc_apply_fixup(struct hda_codec *codec, int action)
 		switch (fix->type) {
 		case ALC_FIXUP_SKU:
 			if (action != ALC_FIXUP_ACT_PRE_PROBE || !fix->v.sku)
-				break;;
+				break;
 			snd_printdd(KERN_INFO "hda_codec: %s: "
 				    "Apply sku override for %s\n",
 				    codec->chip_name, modelname);
-- 
1.7.7.3


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
