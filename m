From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Detect codecs on Intel
	DZ77SL-50K
Date: Wed, 22 Jan 2014 12:32:28 +0100
Message-ID: <1390390348-11745-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CCB6126501B
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 12:32:29 +0100 (CET)
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
Cc: kulkarniniraj@rediffmail.com, 1155202@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Niraj <kulkarniniraj@rediffmail.com>

Apparently this board seems to need some extra initialization before a proper
codec probe value can be read.

BugLink: https://bugs.launchpad.net/bugs/1155202
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    6 ++++++
 1 file changed, 6 insertions(+)

Hi Takashi,

Here's a patch from Niraj, which has found this code below to make audio work
on the Intel DZ77SL-50K board. Without it, no codecs will be detected.

I'm not sure if you like it this way or if you want me or Niraj to change
anything, or debug further. Or maybe add a new quirk for this particular device?

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fa2879a..2bf46e9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1306,6 +1306,12 @@ static void azx_init_chip(struct azx *chip, int full_reset)
 
 	/* reset controller */
 	azx_reset(chip, full_reset);
+	if (!chip->codec_mask) {
+		azx_writel(chip, GCTL, 0x100);
+		while(azx_readl(chip, GCTL) != 0x0);
+		azx_writel(chip, GCTL, 0x1);
+		azx_reset(chip, full_reset);
+	}
 
 	/* initialize interrupts */
 	azx_int_clear(chip);
-- 
1.7.9.5
