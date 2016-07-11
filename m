From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: rt286: set combo jack for Kabylake
Date: Mon, 11 Jul 2016 22:02:10 +0530
Message-ID: <1468254731-15394-4-git-send-email-vinod.koul@intel.com>
References: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A7A1F265CEB
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 18:25:12 +0200 (CEST)
In-Reply-To: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
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

Like in Skylake, Kabylake also uses combo jack so add Kabylake to
DMI match for combo jack configuration.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/rt286.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 1bd31644a782..74c0e4eb3788 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1100,6 +1100,13 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Skylake Client platform")
 		}
 	},
+	{
+		.ident = "Intel Kabylake RVP",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kabylake Client platform")
+		}
+	},
+
 	{ }
 };
 
-- 
1.9.1
