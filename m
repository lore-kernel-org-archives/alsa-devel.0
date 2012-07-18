From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - make sure alc268 does not OOPS on
	codec parse
Date: Wed, 18 Jul 2012 18:02:53 +0200
Message-ID: <1342627373-5042-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ED5AC26030A
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 18:02:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A recent commit made patch_alc268 call snd_hda_pick_fixup with
NULL quirk pointer. Make sure we do not reference that NULL pointer.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index f7520b9..647218d 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -727,7 +727,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			models++;
 		}
 	}
-	if (id < 0) {
+	if (id < 0 && quirk) {
 		q = snd_pci_quirk_lookup(codec->bus->pci, quirk);
 		if (q) {
 			id = q->value;
@@ -736,7 +736,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 #endif
 		}
 	}
-	if (id < 0) {
+	if (id < 0 && quirk) {
 		for (q = quirk; q->subvendor; q++) {
 			unsigned int vendorid =
 				q->subdevice | (q->subvendor << 16);
-- 
1.7.9.5
