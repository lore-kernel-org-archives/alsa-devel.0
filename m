From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: No power nids on 92HD93
Date: Sat, 24 Sep 2011 08:30:44 +0200
Message-ID: <1316845844-2254-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id DD584243D1
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Sep 2011 08:30:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This patch is necessary to make internal speakers work on this chip.

Cc: stable@kernel.org
BugLink: http://bugs.launchpad.net/bugs/854468
Tested-by: Alex Wolfson <alex.wolfson@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 1b7c114..987e3cf 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5630,6 +5630,7 @@ again:
 	switch (codec->vendor_id) {
 	case 0x111d76d1:
 	case 0x111d76d9:
+	case 0x111d76df:
 	case 0x111d76e5:
 	case 0x111d7666:
 	case 0x111d7667:
-- 
1.7.5.4
