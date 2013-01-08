From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - print power state for AFG node in
	proc file
Date: Tue,  8 Jan 2013 15:01:18 +0100
Message-ID: <1357653679-5997-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 921302615D7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 15:01:19 +0100 (CET)
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

It seems useful, and power states are required for AFG nodes,
so I see no reason not to print it. As a bonus, also print the
AFG nid.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_proc.c |    2 ++
 1 file changed, 2 insertions(+)

(Feel free to rephrase "State of AFG node 0x%02x:\n" if you like.)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 045e5d3..d6c8416 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -603,6 +603,8 @@ static void print_codec_info(struct snd_info_entry *entry,
 	print_amp_caps(buffer, codec, codec->afg, HDA_INPUT);
 	snd_iprintf(buffer, "Default Amp-Out caps: ");
 	print_amp_caps(buffer, codec, codec->afg, HDA_OUTPUT);
+	snd_iprintf(buffer, "State of AFG node 0x%02x:\n", codec->afg);
+	print_power_state(buffer, codec, codec->afg);
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
 	if (! nid || nodes < 0) {
-- 
1.7.9.5
