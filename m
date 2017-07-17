From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Skylake: Enable hdmi for GLK
Date: Mon, 17 Jul 2017 20:45:27 +0530
Message-ID: <1500304529-25804-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9908F2669F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 17:17:43 +0200 (CEST)
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

Pradeep Tewani (2):
  ASoC: Intel: board: Add Geminilake platform support
  ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI

 sound/soc/codecs/hdac_hdmi.c       | 39 +++++++++++++++---
 sound/soc/intel/boards/bxt_rt298.c | 82 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 8 deletions(-)

-- 
2.7.4
