From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Fix build error without
	CONFIG_PCI
Date: Tue,  5 Feb 2019 18:01:59 +0100
Message-ID: <20190205170159.17999-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D04E2666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 18:02:03 +0100 (CET)
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

A call of pci_iounmap() call without CONFIG_PCI leads to a build error
on some architectures.  We tried to address this and add a check of
IS_ENABLED(CONFIG_PCI), but this still doesn't seem enough for sh.
Ideally we should fix it globally, it's really a corner case, so let's
paper over it with a simpler ifdef.

Fixes: 1e73359a24fa ("ALSA: hda/ca0132 - make pci_iounmap() call conditional")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e5bdbc245682..29882bda7632 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8451,8 +8451,10 @@ static void ca0132_free(struct hda_codec *codec)
 	ca0132_exit_chip(codec);
 
 	snd_hda_power_down(codec);
-	if (IS_ENABLED(CONFIG_PCI) && spec->mem_base)
+#ifdef CONFIG_PCI
+	if (spec->mem_base)
 		pci_iounmap(codec->bus->pci, spec->mem_base);
+#endif
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
-- 
2.16.4
