From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: rt286: set combo jack for Skylake
Date: Tue, 17 Nov 2015 11:17:33 +0530
Message-ID: <1447739253-22166-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AFFC260526
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 06:43:57 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Skylake platform also uses combo jack configuration, so add
Skylake to existing DMI match for combo jack

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/rt286.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index af2ed774b552..bc08f0c5a5f6 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1114,6 +1114,12 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Wilson Beach SDS")
 		}
 	},
+	{
+		.ident = "Intel Skylake RVP",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Skylake Client platform")
+		}
+	},
 	{ }
 };
 
-- 
1.9.1
