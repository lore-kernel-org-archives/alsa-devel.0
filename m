From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Fix "Line" and "Mic" names for
	CA0132
Date: Mon, 20 Aug 2012 11:16:59 +0200
Message-ID: <1345454220-4233-2-git-send-email-david.henningsson@canonical.com>
References: <1345454220-4233-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D5AB265D97
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 10:47:21 +0200 (CEST)
In-Reply-To: <1345454220-4233-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, ian_minett@creativelabs.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The names "Line-In" and "Mic-In" are nonstandard. Standard names
make them controllable by e g PulseAudio.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_ca0132.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d0d3540..2685590 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -988,12 +988,12 @@ static void ca0132_config(struct hda_codec *codec)
 
 	/* Mic-in */
 	spec->input_pins[0] = 0x12;
-	spec->input_labels[0] = "Mic-In";
+	spec->input_labels[0] = "Mic";
 	spec->adcs[0] = 0x07;
 
 	/* Line-In */
 	spec->input_pins[1] = 0x11;
-	spec->input_labels[1] = "Line-In";
+	spec->input_labels[1] = "Line";
 	spec->adcs[1] = 0x08;
 	spec->num_inputs = 2;
 }
-- 
1.7.9.5
