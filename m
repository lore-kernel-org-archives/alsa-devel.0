From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v7 0/3] HDA: add extended HDA
Date: Wed, 10 Jun 2015 17:03:33 +0530
Message-ID: <1433936016-446-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C81DF2614C4
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 13:32:12 +0200 (CEST)
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

Changes in v7:
- Feedback from Takashi
- removed the macros for register read/writes
- add new macros for reg update
- fix bus pointer macro
- header cleanup on c/h files
- new device name ehdaudioiDn
- removed flags for ext caps, use pointer only
- moved module info to patch 1
- sparse check on series
- remove codec name in link

Jeeja KP (3):
  ALSA: hdac_ext: add extended HDA bus
  ALSA: hdac_ext: add hdac extended controller
  ALSA: hdac_ext: add extended stream capabilities

 include/sound/hdaudio_ext.h         | 129 ++++++++++++
 sound/hda/Kconfig                   |   4 +
 sound/hda/Makefile                  |   3 +
 sound/hda/ext/Makefile              |   3 +
 sound/hda/ext/hdac_ext_bus.c        | 116 +++++++++++
 sound/hda/ext/hdac_ext_controller.c | 297 ++++++++++++++++++++++++++
 sound/hda/ext/hdac_ext_stream.c     | 402 ++++++++++++++++++++++++++++++++++++
 7 files changed, 954 insertions(+)
 create mode 100644 include/sound/hdaudio_ext.h
 create mode 100644 sound/hda/ext/Makefile
 create mode 100644 sound/hda/ext/hdac_ext_bus.c
 create mode 100644 sound/hda/ext/hdac_ext_controller.c
 create mode 100644 sound/hda/ext/hdac_ext_stream.c

-- 
1.9.1
