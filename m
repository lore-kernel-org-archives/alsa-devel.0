From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 3/4] ASoC: simple style fix
Date: Wed, 20 Apr 2011 16:00:46 +0800
Message-ID: <20110420080046.11377.43604.stgit@localhost>
References: <20110420075859.11377.67437.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 882541038E1
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 09:59:52 +0200 (CEST)
In-Reply-To: <20110420075859.11377.67437.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

replace the tab with spaces,
make it align with other paragraphs

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 include/sound/soc-dapm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f72c103..d5f1b9a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -24,7 +24,7 @@
  * SoC dynamic audio power management
  *
  * We can have up to 4 power domains
- * 	1. Codec domain - VREF, VMID
+ *  1. Codec domain - VREF, VMID
  *     Usually controlled at codec probe/remove, although can be set
  *     at stream time if power is not needed for sidetone, etc.
  *  2. Platform/Machine domain - physically connected inputs and outputs
