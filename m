From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ALSA: hda: fix possible null dereference
Date: Thu,  2 Apr 2015 16:51:43 +0530
Message-ID: <1427973703-2365-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

we are dereferencing pcm first then checking pcm. instead now lets put
them in same if condition so that pcm is checked first.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/hda/hda_codec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 145cae7..7df18e2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3717,9 +3717,8 @@ static int add_std_chmaps(struct hda_codec *codec)
 			struct snd_pcm_chmap *chmap;
 			const struct snd_pcm_chmap_elem *elem;
 
-			if (pcm->own_chmap)
-				continue;
-			if (!pcm || !hinfo->substreams)
+			if (!pcm || pcm->own_chmap ||
+			    !hinfo->substreams)
 				continue;
 			elem = hinfo->chmap ? hinfo->chmap : snd_pcm_std_chmaps;
 			err = snd_pcm_add_chmap_ctls(pcm->pcm, str, elem,
-- 
1.8.1.2
