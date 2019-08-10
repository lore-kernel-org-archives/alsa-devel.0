From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ALSA: hda - Fix a memory leak bug
Date: Fri,  9 Aug 2019 23:29:48 -0500
Message-ID: <1565411390-2684-1-git-send-email-wenwen@cs.uga.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In snd_hda_parse_generic_codec(), 'spec' is allocated through kzalloc().
Then, the pin widgets in 'codec' are parsed. However, if the parsing
process fails, 'spec' is not deallocated, leading to a memory leak.

To fix the above issue, free 'spec' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 485edab..8f2beb1 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -6100,7 +6100,7 @@ static int snd_hda_parse_generic_codec(struct hda_codec *codec)
 
 	err = snd_hda_parse_pin_defcfg(codec, &spec->autocfg, NULL, 0);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
 	if (err < 0)
-- 
2.7.4
