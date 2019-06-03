From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/9] ASoC: SOF: new functionality with MINOR
	ABI changes
Date: Mon,  3 Jun 2019 11:18:12 -0500
Message-ID: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1632F80CC4
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:28 +0200 (CEST)
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

The first patches are to align with firmware, we unfortunately had a
couple of misses before the new ABI change process was introduced [1].

The new functionality added after the initial cleanup is:

1. sending the kernel time to firmware so that the trace logs use the
same base across suspend-resume cycles.

2. introducing an IPC flood mechanism which already helped harden the
IPC sequences, be it with QEMU or on real hardware.

3. support for mux/demux component

4. initial SoundWire support

This patchset is independent from the IPC changes submitted on
alsa-devel, but will only apply if previous trace related changes are
applied. ([PATCH 3/5] ASoC: SOF: trace: move to opt-in with Kconfig
and module parameter)

[1] https://github.com/orgs/thesofproject/projects/2


Bard liao (1):
  ASoC: SOF: send time stamp to FW for alignment

Jaska Uimonen (1):
  ASoC: SOF: topology: add support for mux/demux component

Kai Vehmanen (1):
  ASoC: SOF: fix DSP oops definitions in FW ABI

Pan Xiuli (1):
  ASoC: SOF: soundwire: add initial soundwire support

Pierre-Louis Bossart (2):
  ASoC: SOF: uapi: mirror firmware changes
  ASoC: SOF: bump to ABI 3.6

Ranjani Sridharan (3):
  ASoC: SOF: add mode parameter for snd_sof_debugfs_buf_item
  ASoC: SOF: ipc: Introduce SOF_IPC_GLB_TEST_MSG IPC command
  ASoC: SOF: debug: add new debugfs entries for IPC flood test

 include/sound/sof/dai.h      |   1 +
 include/sound/sof/header.h   |  30 ++++-
 include/sound/sof/topology.h |   3 +
 include/sound/sof/trace.h    |  10 ++
 include/sound/sof/xtensa.h   |   9 +-
 include/uapi/sound/sof/abi.h |   2 +-
 sound/soc/sof/Kconfig        |   8 ++
 sound/soc/sof/debug.c        | 247 ++++++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/bdw.c    |  17 ++-
 sound/soc/sof/intel/byt.c    |  15 ++-
 sound/soc/sof/intel/hda.c    |  16 ++-
 sound/soc/sof/ipc.c          |   9 ++
 sound/soc/sof/loader.c       |   4 +-
 sound/soc/sof/sof-priv.h     |   8 +-
 sound/soc/sof/topology.c     |   2 +
 sound/soc/sof/trace.c        |  16 ++-
 sound/soc/sof/xtensa/core.c  |   2 +-
 17 files changed, 366 insertions(+), 33 deletions(-)

-- 
2.20.1
