From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 0/3] ALSA: HDA: add extended HDA
Date: Thu,  4 Jun 2015 15:23:19 +0530
Message-ID: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA95260538
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 11:52:06 +0200 (CEST)
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

New HDA controllers from Intel have extended HDA capabilities like multilink,
pipe processing, SPIB, GTS etc In order to use them we create an extended
HDA bus, controller and stream which uses the extended configuration

Vinod Koul (3):
  ALSA: hdac_ext: add extended HDA bus
  ALSA: hdac_ext: add hdac extended controller
  ALSA: hdac_ext: add extended stream capabilities

 include/sound/hdaudio_ext.h         | 385 +++++++++++++++++++++++++++++++++
 sound/hda/Kconfig                   |   4 +
 sound/hda/Makefile                  |   3 +
 sound/hda/ext/Makefile              |   3 +
 sound/hda/ext/hdac_ext_bus.c        | 115 ++++++++++
 sound/hda/ext/hdac_ext_controller.c | 295 +++++++++++++++++++++++++
 sound/hda/ext/hdac_ext_stream.c     | 414 ++++++++++++++++++++++++++++++++++++
 7 files changed, 1219 insertions(+)
 create mode 100644 include/sound/hdaudio_ext.h
 create mode 100644 sound/hda/ext/Makefile
 create mode 100644 sound/hda/ext/hdac_ext_bus.c
 create mode 100644 sound/hda/ext/hdac_ext_controller.c
 create mode 100644 sound/hda/ext/hdac_ext_stream.c

-- 
1.9.1
