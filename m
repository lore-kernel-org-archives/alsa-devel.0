From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/3] ALSA: Add soc hda bus support
Date: Thu,  2 Apr 2015 15:27:28 +0530
Message-ID: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A9D8D2604C7
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 12:02:00 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, pathes.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This series of 3 patches adds support for ASoC HDA
bus. ASoC HDA bus is essentially a wrapper for
HDA core bus and it manages ASoC hda drivers

Ramesh Babu (3):
  ALSA: hda - remove assigning dev type inside core
  ALSA: hda - add ASoC device type for hda core
  ALSA: hda - add soc hda bus wrapper

 include/sound/hdaudio.h      |    1 +
 include/sound/soc-hdac-bus.h |  103 +++++++++++++++++++
 sound/hda/hdac_device.c      |    1 -
 sound/soc/Kconfig            |    1 +
 sound/soc/Makefile           |    1 +
 sound/soc/hda/Kconfig        |    4 +
 sound/soc/hda/Makefile       |    3 +
 sound/soc/hda/soc-hdac-bus.c |  233 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-hdac-bus.h
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/soc-hdac-bus.c

-- 
1.7.9.5
