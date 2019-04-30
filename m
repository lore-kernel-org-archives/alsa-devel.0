From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/19] ASoC: SOF: improvements for ABI checks
	and Intel code
Date: Tue, 30 Apr 2019 18:09:15 -0500
Message-ID: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57FEBF80C0D
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:54 +0200 (CEST)
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

This series is a set of relatively small SOF changes after the big
batch merged last week (Thanks!). Since we are very close to the merge
window and in May where most of the world takes time off, it'd be
perfectly understandable if those patches were queued for 5.3, after
feedback and corrections as needed.

First we added optional stricter ABI checks when the firmware,
topology and kernel ABI levels differ, which can happen when patches
are merged at different times on Github. This is mainly for developers
and the Github CI to track disconnects, should they happen despite our
new process to keep evolutions under control. This option has no
impact on the usual problem of updating the kernel without updating
the firmware files.

The Intel changes are mainly
a) fixes for the slave mode suppport
b) clean-ups such as removal of a static index for HDAudio support or
removal of unneeded include file
c) use of a workqueue to defer period elapsed events after the
IPC completion.
d) simplification of the IRQ code
e) fixes to deal with resume on HDaudio links. In the previous
patchset we removed the RESUME_INFO flag but missed the need to
explicitly set the hw_params on resume.
f) a set of routines to dump the Intel IPC registers, mainly for early
platform enablement.

Keyon Jie (7):
  ASoC: SOF: Intel: cnl: add pointer ops to use DPIB position
  ASoC: SOF: PCM: add period_elapsed work to fix race condition in
    interrupt context
  ASoC: SOF: Intel: use snd_sof_pcm_period_elapsed
  ASoC: SOF: ipc: use snd_sof_pcm_period_elapsed
  ASoC: SOF: Intel: hda-ipc: simplify handling of IPC IRQ
  ASoC: SOF: Intel: hda-stream: store stream capabilities
  ASoC: SOF: Intel: hda-stream: handle real stream interrupts only

Pan Xiuli (3):
  ASoC: SOF: IPC: add ipc dump function
  ASoC: SOF: Intel: APL: add ipc dump function
  ASoC: SOF: Intel: CNL: add ipc dump function

Pierre-Louis Bossart (4):
  ASoC: SOF: add Kconfig option for strict ABI checks
  ASOC: SOF: ipc: add support for stricter ABI checks
  ASoC: SOF: topology: add support for stricter ABI checks
  ASoC: SOF: Intel: hda-pcm: remove useless dependency on hdac_ext

Ranjani Sridharan (1):
  ASoC: SOF: intel: hda: add hw_params_upon_resume flag for hda stream

Zhu Yingjiang (4):
  ASoC: SOF: Intel: hda: add the SSP Host Device memory space
  ASoC: SOF: Intel: hda: add SSP info to the chip info struct
  ASoC: SOF: Intel: hda: set I2S slave before enabling DSP
  ASoC: SOF: Intel: hda: set bus->idx as 0

 sound/soc/sof/Kconfig            | 15 ++++++++++
 sound/soc/sof/intel/apl.c        |  4 +++
 sound/soc/sof/intel/cnl.c        | 27 +++++++++++++++---
 sound/soc/sof/intel/hda-bus.c    |  9 ++++--
 sound/soc/sof/intel/hda-dai.c    | 23 +++++++++------
 sound/soc/sof/intel/hda-dsp.c    | 16 +++++++++++
 sound/soc/sof/intel/hda-ipc.c    | 13 ++++-----
 sound/soc/sof/intel/hda-loader.c | 11 ++++++++
 sound/soc/sof/intel/hda-pcm.c    |  1 -
 sound/soc/sof/intel/hda-stream.c | 15 ++++++++--
 sound/soc/sof/intel/hda.c        | 18 ++++++++++++
 sound/soc/sof/intel/hda.h        | 23 +++++++++++++++
 sound/soc/sof/intel/shim.h       |  2 ++
 sound/soc/sof/ipc.c              | 12 +++++++-
 sound/soc/sof/ops.h              | 12 ++++++++
 sound/soc/sof/pcm.c              | 48 ++++++++++++++++++++++++++++++++
 sound/soc/sof/pm.c               |  3 ++
 sound/soc/sof/sof-priv.h         |  5 +++-
 sound/soc/sof/topology.c         | 43 +++++++++++++++++++---------
 19 files changed, 257 insertions(+), 43 deletions(-)

-- 
2.17.1
