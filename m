From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH v2] snd/hda: fix use-after-free after module
	unload
Date: Mon, 11 Jul 2016 19:51:06 +0200
Message-ID: <20160711175106.5349-1-peter@lekensteyn.nl>
References: <s5h37ngv4ks.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lekensteyn.nl (lekensteyn.nl [178.21.112.251])
 by alsa0.perex.cz (Postfix) with ESMTP id A7ACE265338
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 19:51:13 +0200 (CEST)
In-Reply-To: <s5h37ngv4ks.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

register_vga_switcheroo() sets the PM ops from the hda structure which
is freed later in azx_free. Make sure that these ops are cleared.

Caught by KASAN, initially noticed due to a general protection fault.

Fixes: 246efa4a072f ("snd/hda: add runtime suspend/resume on optimus support (v4)")
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
Maybe Cc stable?
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 94089fc..4aeed98 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1217,8 +1217,10 @@ static int azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+			vga_switcheroo_fini_domain_pm_ops(chip->card->dev);
+		}
 	}
 
 	if (bus->chip_init) {
-- 
2.9.0
