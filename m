From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hda - fix whitespaces
Date: Thu,  9 Jun 2016 11:52:44 +0530
Message-ID: <1465453364-24323-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC932667A4
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 08:16:08 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Some trailing whitespaces seems to have crept in the hda_intel.c,
so fix them up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 94089fc71884..5520082ad770 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -383,8 +383,8 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
 	[AZX_DRIVER_NVIDIA] = "HDA NVidia",
-	[AZX_DRIVER_TERA] = "HDA Teradici", 
-	[AZX_DRIVER_CTX] = "HDA Creative", 
+	[AZX_DRIVER_TERA] = "HDA Teradici",
+	[AZX_DRIVER_CTX] = "HDA Creative",
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
-- 
1.9.1
