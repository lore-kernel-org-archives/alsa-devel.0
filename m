From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix error accessing non-existent
	node for Realtek codecs
Date: Mon, 15 Jul 2013 10:20:52 +0200
Message-ID: <1373876452-11336-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EDC7260815
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 10:20:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, kailang@realtek.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A recent commit caused my hda-emu based test tool to complain about
accessing nodes that don't exist. This simple test works around this.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

I don't have ALC5505 hardware here, no alsa-info to look at, and I don't know
what it is. Therefore it would be good with some confirmation that this patch
does not break such hardware, which could be the case if the Realtek codec
breaks the HDA spec by having "hidden" nodes.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8bd2261..ca73f10 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3844,7 +3844,8 @@ static int patch_alc269(struct hda_codec *codec)
 		break;
 	}
 
-	if (snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
+	if (codec->num_nodes > 0x51 &&
+	    snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
 		spec->has_alc5505_dsp = true;
 		spec->init_hook = alc5505_dsp_init;
 	}
-- 
1.7.9.5
