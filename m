From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 4/6] ASoC: Intel: Skylake: Do not check
	dev_type for dmic link type
Date: Wed,  6 Dec 2017 16:34:04 +0530
Message-ID: <20171206110406.11400-5-guneshwor.o.singh@intel.com>
References: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F242678E4
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 12:04:55 +0100 (CET)
In-Reply-To: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Some BIOS have inconsistent dev_type value for DMIC link type.
Since there is only one device type for DMIC link type, remove device
type check if link type is NHLT_LINK_DMIC.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index afa557a1c031..e2121ddc8ef0 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -120,11 +120,16 @@ static bool skl_check_ep_match(struct device *dev, struct nhlt_endpoint *epnt,
 
 	if ((epnt->virtual_bus_id == instance_id) &&
 			(epnt->linktype == link_type) &&
-			(epnt->direction == dirn) &&
-			(epnt->device_type == dev_type))
-		return true;
-	else
-		return false;
+			(epnt->direction == dirn)) {
+		/* do not check dev_type for DMIC link type */
+		if (epnt->linktype == NHLT_LINK_DMIC)
+			return true;
+
+		if (epnt->device_type == dev_type)
+			return true;
+	}
+
+	return false;
 }
 
 struct nhlt_specific_cfg
-- 
2.15.1
