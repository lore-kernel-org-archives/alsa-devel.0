From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 0/3] Add SPIB Support for Intel Skylake
	platforms
Date: Tue, 30 Jan 2018 15:06:23 +0530
Message-ID: <1517304986-16847-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 395FA26753C
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 10:43:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Skylake audio controller supports SPIB (Software Position in buffer)
capability, which can be used to inform position of application pointer
to host DMA controller. When SPIB mode is enabled, driver could write
the application pointer position in SPIB register. Host DMA will make
sure it won't read/write beyond bytes specified in SPIB register.

SPIB mode will be useful in low power use cases, where DSP could
pre-fetch large buffers to avoid frequent wakes caused due to interrupts.

To support SPIB in the driver, save the spib values in stream context
which can be restored during resume from S3. Add new hw_params flag to
explicitly tell driver that rewinds will never be used.

Pierre-Louis Bossart (1):
  ALSA: core: let low-level driver or userspace disable rewinds

Ramesh Babu (2):
  ALSA: hda: ext: add spib to stream context
  ASoC: Intel: Skylake: Add support for spib mode

 include/sound/hdaudio_ext.h       |  1 +
 include/sound/pcm.h               |  1 +
 include/uapi/sound/asound.h       |  1 +
 sound/core/pcm_native.c           |  8 ++++++++
 sound/hda/ext/hdac_ext_stream.c   |  2 ++
 sound/soc/intel/skylake/skl-pcm.c | 43 ++++++++++++++++++++++++++++++++++++++-
 6 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.4
