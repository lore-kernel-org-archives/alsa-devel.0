From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/4] ASoC: rt298: Add DMI match for Geminilake
	reference platform
Date: Thu,  9 Feb 2017 16:44:02 +0530
Message-ID: <1486638844-17975-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9339726684C
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 12:24:52 +0100 (CET)
In-Reply-To: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Geminilake reference platform also uses combo jack for audio connector
so we need to set codec pdata to use this based on DMI match for this
board.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/codecs/rt298.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7150a407ffd9..d9e96e65e1c4 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1163,6 +1163,13 @@ static int rt298_resume(struct snd_soc_codec *codec)
 			DMI_MATCH(DMI_PRODUCT_NAME, "Broxton P")
 		}
 	},
+	{
+		.ident = "Intel Gemini Lake",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Geminilake")
+		}
+	},
 	{ }
 };
 
-- 
1.9.1
