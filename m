From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/9] ASoC: SOF: stability fixes
Date: Fri, 24 May 2019 14:09:16 -0500
Message-ID: <20190524190925.5931-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84D22F89630
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:09:36 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

No new functionality here but fixes to the IPC, memory allocation,
workqueues, control, runtime_pm and HDaudio support. These issues were
identified during the integration/productization of new platforms.

I added a 'Fixes' tag to make sure backports/stable can pick up these
patches, in case it's too late for them to land in 5.2

The next batch for SOF will be a set of new capabilities for trace,
IPC test, Hdaudio support, they will be submitted after additional
tests and once these fixes are reviewed/merged.

Thanks!

Changes since v2:
Removed 3 patches (Hdaudio memory allocation changes, will be
resubmitted when unclear system freeze is sorted out + patch already
merged by Mark)
Corrected merge issue with IPC patch from Guennadi

Changes since v1:
Feedback from Takashi: use spin_lock_irq instead of spin_lock_irq_save
Added Takashi's Reviewed-by tag


Guennadi Liakhovetski (1):
  ASoC: SOF: ipc: fix a race, leading to IPC timeouts

Keyon Jie (1):
  ASoC: SOF: control: correct the copy size for bytes kcontrol put

Libin Yang (1):
  ASoC: SOF: pcm: clear hw_params_upon_resume flag correctly

Pierre-Louis Bossart (2):
  ASoC: SOF: core: fix error handling with the probe workqueue
  ASoC: SOF: pcm: remove warning - initialize workqueue on open

Ranjani Sridharan (2):
  ASoC: SOF: core: remove DSP after unregistering machine driver
  ASoC: SOF: core: remove snd_soc_unregister_component in case of error

Zhu Yingjiang (2):
  ASoC: SOF: Intel: hda: fix the hda init chip
  ASoC: SOF: Intel: hda: use the defined ppcap functions

 sound/soc/sof/control.c        |   9 +--
 sound/soc/sof/core.c           |  29 +++++++--
 sound/soc/sof/intel/bdw.c      |   9 ++-
 sound/soc/sof/intel/byt.c      |  10 +--
 sound/soc/sof/intel/cnl.c      |   4 ++
 sound/soc/sof/intel/hda-ctrl.c | 102 +++++++++++++++++++++++++++---
 sound/soc/sof/intel/hda-ipc.c  |  17 ++++-
 sound/soc/sof/intel/hda.c      | 109 +++++++--------------------------
 sound/soc/sof/ipc.c            |  13 ----
 sound/soc/sof/pcm.c            |   8 +--
 10 files changed, 176 insertions(+), 134 deletions(-)


base-commit: 188d45fe779eeb8e3521b59fcb12cc48a6f2c203
-- 
2.20.1
