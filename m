From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Subject: [PATCH v2 0/3]ASoC: Intel: Skylake: Enable hdmi for GLK
Date: Thu, 20 Jul 2017 11:40:54 +0530
Message-ID: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BD102266AE1
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 08:13:01 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Pradeep Tewani <pradeep.d.tewani@intel.com>
List-Id: alsa-devel@alsa-project.org

GLK vendor nid is different from rest of the skylake platforms. Add vendor
nid as part of driver data and use it. Also enable support for GLK
platform.

Add the patch to remove the .owner initialization in bxt driver as well

Changes in v2:
	Removed the .owner field in driver
	Replaced the strcmp with strncmp for bxt_rt298 probe

Pradeep Tewani (3):
  ASoC: Intel: board: Remove .owner initialization in bxt_rt298 driver
  ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI
  ASoC: Intel: board: Add Geminilake platform support

 sound/soc/codecs/hdac_hdmi.c       | 39 ++++++++++++++---
 sound/soc/intel/boards/bxt_rt298.c | 85 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 9 deletions(-)

-- 
2.7.4
