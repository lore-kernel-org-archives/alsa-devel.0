From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: x86: Make CONFIG_SND_X86 bool
Date: Tue, 21 Mar 2017 13:30:08 +0100
Message-ID: <20170321123008.19027-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D20742671BA
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 13:30:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

CONFIG_SND_X86 is a menu config to filter only for x86-specific
drivers in its sub-menu, and this doesn't have to be tristate but
rather it should be a bool.  Also, like other sub-menu configs, it's
more user-friendly to be default=y; it's merely a menu config and the
actual drivers are configured in the sub-menu, after all.

Fixes: 287599cf2d77 ("ALSA: add Intel HDMI LPE audio driver for BYT/CHT-T")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 84c8f8fc597c..8adf4d1bd46e 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_X86
-	tristate "X86 sound devices"
+	bool "X86 sound devices"
 	depends on X86
+	default y
 	---help---
 	  X86 sound devices that don't fall under SoC or PCI categories
 
-- 
2.11.1
