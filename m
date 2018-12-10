From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: hda/ca0132 - make pci_iounmap() call
	conditional
Date: Mon, 10 Dec 2018 21:54:25 +0100
Message-ID: <20181210205445.2913413-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C699C267AFE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 21:54:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Connor McAdams <conmanx360@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

When building without CONFIG_PCI, we can (depending on the architecture)
get a link failure:

ERROR: "pci_iounmap" [sound/pci/hda/snd-hda-codec-ca0132.ko] undefined!

Adding a compile-time check for PCI gets it to work correctly on
32-bit ARM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c40cb6336017..e5bdbc245682 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8451,7 +8451,7 @@ static void ca0132_free(struct hda_codec *codec)
 	ca0132_exit_chip(codec);
 
 	snd_hda_power_down(codec);
-	if (spec->mem_base)
+	if (IS_ENABLED(CONFIG_PCI) && spec->mem_base)
 		pci_iounmap(codec->bus->pci, spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
-- 
2.20.0
