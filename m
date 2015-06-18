From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/2] ALSA: hda: add module flag
	snd_adsp_enable
Date: Thu, 18 Jun 2015 12:08:23 +0530
Message-ID: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 85C8C260563
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 08:36:54 +0200 (CEST)
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

This is second attempt for creating a module option for hda core to
select either legacy HDA driver or upcoming ASoC driver.  This series
still relies on module flag (with feedback from previous series baked
in). The eventual plan is to rely on HW advertised capabilities and
BIOS configuration to load either driver, but since ASoC driver has
still some time to get fully merged and matured on various system, we
will rely on module flag till the who ASoC HDA systems is completed
and available is all distros

Vinod Koul (2):
  ALSA: hda: add snd_adsp_enable module flag
  ALSA: hda: use snd_adsp_enable in HDA driver

 include/sound/hdaudio.h        | 11 +++++++++++
 sound/hda/hda_bus_type.c       |  6 ++++++
 sound/pci/hda/hda_controller.h |  1 +
 sound/pci/hda/hda_intel.c      | 10 +++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

-- 
1.9.1
