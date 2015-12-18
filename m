From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 00/13] ASoC: Intel: Skylake: Update to SKL
	driver
Date: Fri, 18 Dec 2015 15:11:56 +0530
Message-ID: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC4526559B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:38:58 +0100 (CET)
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

This update bring in new APIs in core and usage of those in SKL driver.

The series is broadly of three parts
 - first two are fixes on the driver
 - then we add DMA resume capability in HDA core and use it to save restore
   DMA link values and add DMA resume capability in driver
 - lastly, we add support for MISCBDCGE configuration in core and use it
   while resetting and also for phrase detection per HW recommendation

This should be merged thru ASoC tree due to obvious dependencies. Takashi
would need your ack on core patches

change in v4:
 - fix the circular depends on two ko's

change is v3:
 - fix the missing export symbol, reported by lkp

changes in v2:
 - move msicbdge api to driver and as a consequence sqash into into first
   use
 - fix lkp warning

Dharageswari.R (1):
  ASoC: Intel: Skylake: Use CGCTL.MISCBDCGE for Phrase detection
    notification

Jayachandran B (2):
  ALSA: hdac: Increase timeout value for link power check
  ASoC: Intel: Skylake: fix reset controller sequencing

Jeeja KP (8):
  ASoC: Intel: Skylake: Clear stream registers before stream setup
  ASoC: Intel: Skylake: Fix to set pipe state to invalid when deleting
  ALSA: hdac: Add support for hda DMA Resume capability
  ALSA: hdac: couple the hda DMA stream in cleanup
  ASoC: Intel: Skylake: enable interrupt as wake source in active
    suspend
  ASoC: Intel: Skylake: Add DMA resume position in Trigger
    resume/suspend
  ASoC: Intel: Skylake: Reconfigure Link stream on suspend/resume
  ASoC: Intel: Skylake: Add Resume capability in PCM info.

Vinod Koul (2):
  ALSA: hdac: add snd_hdac_ext_bus_link_power_up_all
  ASoC: Intel: Skylake: manage link power in active suspend

 include/sound/hda_register.h            |  9 +++++
 include/sound/hdaudio_ext.h             | 15 +++++++
 sound/hda/ext/hdac_ext_controller.c     | 29 ++++++++++++-
 sound/hda/ext/hdac_ext_stream.c         | 72 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c  |  2 +
 sound/soc/intel/skylake/skl-pcm.c       | 56 ++++++++++++++++++++-----
 sound/soc/intel/skylake/skl-sst-cldma.c | 38 ++++++++++-------
 sound/soc/intel/skylake/skl-sst-ipc.c   | 15 +++++++
 sound/soc/intel/skylake/skl-sst-ipc.h   |  5 +++
 sound/soc/intel/skylake/skl.c           | 61 ++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h           |  3 ++
 11 files changed, 275 insertions(+), 30 deletions(-)

-- 
1.9.1
