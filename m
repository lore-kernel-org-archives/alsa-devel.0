From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Fix oops caused by recent commit "Fix internal
	mic for Lenovo Ideapad U300s"
Date: Tue, 10 Apr 2012 13:05:29 +0200
Message-ID: <1334055929-7346-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 0085424590
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 13:05:35 +0200 (CEST)
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
Cc: tiwai@suse.de, David Henningsson <david.henningsson@canonical.com>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Make sure we don't dereference the "quirk" pointer when it is null.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index cbe115b..abb59f4 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4441,7 +4441,9 @@ static void apply_fixup(struct hda_codec *codec,
 	struct conexant_spec *spec = codec->spec;
 
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, quirk);
-	if (quirk && table[quirk->value]) {
+	if (!quirk)
+		return;
+	if (table[quirk->value]) {
 		snd_printdd(KERN_INFO "hda_codec: applying pincfg for %s\n",
 			    quirk->name);
 		apply_pincfg(codec, table[quirk->value]);
-- 
1.7.9.1
