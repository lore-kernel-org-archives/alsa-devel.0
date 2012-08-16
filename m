From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Fixup ALC268 input amp on Beep node
Date: Thu, 16 Aug 2012 13:55:39 +0200
Message-ID: <1345118139-7242-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 89245265FDF
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:25:54 +0200 (CEST)
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

According to the ALC268 datasheet, there is actually an input amplifier
on node 0x1d, even though this is not exposed in the codec proc file.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Relevant alsa info: alc268-toshiba-tecra-s11-m11--nvidia--ccert-201002-5346

diff --git a/hda-spec.c b/hda-spec.c
index f1b03b4..dd43ee9 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -386,6 +386,20 @@ static void fixup_via_mixer(struct xhda_codec *codec)
 	node->node[node->num_nodes++] = 0x08;
 }
 
+static void fixup_alc268_beep(struct xhda_codec *codec)
+{
+	struct xhda_node *node = find_node(codec, 0x1d);
+	if (!node)
+		return;
+	node->wcaps |= (1 << 1);	/* AMP-in present */
+
+	node->amp_in_caps.ofs = 0x0c;
+	node->amp_in_caps.nsteps = 0x0c;
+	node->amp_in_caps.stepsize = 0x07;
+	node->amp_in_caps.mute = 0;
+	node->amp_in_caps.override = 1;
+}
+
 struct fixup_list {
 	unsigned int vendor_id;
 	void (*func)(struct xhda_codec *);
@@ -397,6 +411,7 @@ static struct fixup_list fixups[] = {
 	{ 0x11060438, fixup_via_mixer },
 	{ 0x11064438, fixup_via_mixer },
 	{ 0x11060448, fixup_via_mixer },
+	{ 0x10ec0268, fixup_alc268_beep },
 	{ }
 };
 
-- 
1.7.9.5
