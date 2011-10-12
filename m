From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fixup Realtek headphone pin
	initialization
Date: Wed, 12 Oct 2011 19:26:03 +0200
Message-ID: <1318440363-4399-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B94D10382B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 19:26:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, 871582@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This typo caused headphone pins not to be initialized correctly.

BugLink: https://bugs.launchpad.net/bugs/871582
Reported-by: Effenberg
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bf53663..6a4128d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3263,7 +3263,7 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 	int i;
 	hda_nid_t pin, dac;
 
-	for (i = 0; i < spec->autocfg.speaker_outs; i++) {
+	for (i = 0; i < spec->autocfg.hp_outs; i++) {
 		pin = spec->autocfg.hp_pins[i];
 		if (!pin)
 			break;
-- 
1.7.5.4
