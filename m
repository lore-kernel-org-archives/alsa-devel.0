From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ALSA: hda: remove module_pci_driver
Date: Thu, 30 Apr 2015 20:22:35 +0530
Message-ID: <1430405556-19166-2-git-send-email-vinod.koul@intel.com>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EC775261A0D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:52:03 +0200 (CEST)
In-Reply-To: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Since we want to selectively register for Intel aDSP systems based on the
module flag we need to bring back explicit code for driver registration and
remove module_pci_driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_intel.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f7cdf4d2e24e..488dab208ddc 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2217,4 +2217,19 @@ static struct pci_driver azx_driver = {
 	},
 };
 
-module_pci_driver(azx_driver);
+static int __init azx_module_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&azx_driver);
+
+	return ret;
+}
+module_init(azx_module_init);
+
+static void __exit azx_module_exit(void)
+{
+	pci_unregister_driver(&azx_driver);
+
+}
+module_exit(azx_module_exit);
-- 
1.9.1
