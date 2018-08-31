From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 00/12] Sound Open Firmware Core
Date: Fri, 31 Aug 2018 16:18:58 +0100
Message-ID: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D691C267956
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:19:44 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Sound Open Firmware (SOF) is a host and DSP architecture agnostic audio DSP firmware.
SOF is not tied to any specific host architecture or any specific
physical IO communication type (it will work with on SoC DSPs, or DSP connected
via SPI/I2C).

SOF is also not coupled to any particular DSP architecture and has abstraction
similar to Linux to allow porting to other DSP architectures. 

https://www.sofproject.org/

This patch series introduces the SOF core, later series will add host platform
support for SOF.

The SOF core manages all the core DSP services and ALSA/ASoC IO. The core is 
responsible for loading firmware, parsing topology, exposing PCMs and
kcontrols, providing debug and trace mechanisms and performing IPC between
host and DSP.

The SOF core also has logic to allow reuse of existing machine drivers for other
platforms/machines without any code modification. i.e. DAI links can be
modified at runtime to bind with SOF and SOF topologies instead of existing
hard coded DAI links and topology.

Changes since V1 :-

  o Added PM source.
  o Updated header comments to C++ style
  o Used generic private data in snd_soc_pcm_runtime
  o remove sof_get_pages()
  o Added comments for compressed SG pages.
  o Check return values for runtime_pm calls.

Liam Girdwood (12):
  ASoC: SOF: Add Sound Open Firmware driver core
  ASoC: SOF: Add Sound Open Firmware KControl support
  ASoC: SOF: Add driver debug support.
  ASoC: SOF: Add support for IPC IO between DSP and Host
  ASoC: SOF: Add PCM operations support
  ASoC: SOF: Add support for loading topologies
  ASoC: SOF: Add DSP firmware trace event support
  ASoC: SOF: Add DSP HW abstraction operations
  ASoC: SOF: Add firmware loader support
  ASoC: SOF: Add PM support
  ASoC: SOF: Add userspace ABI support
  ASoC: SOF: Add Build support for SOF core

 include/sound/soc.h               |    3 +
 include/sound/sof.h               |   82 ++
 include/uapi/sound/sof-abi.h      |   29 +
 include/uapi/sound/sof-eq.h       |  102 ++
 include/uapi/sound/sof-fw.h       |   67 +
 include/uapi/sound/sof-ipc.h      |  938 ++++++++++++
 include/uapi/sound/sof-tone.h     |   27 +
 include/uapi/sound/sof-topology.h |   94 ++
 sound/soc/Kconfig                 |    1 +
 sound/soc/Makefile                |    1 +
 sound/soc/sof/Kconfig             |   36 +
 sound/soc/sof/Makefile            |    6 +
 sound/soc/sof/control.c           |  270 ++++
 sound/soc/sof/core.c              |  381 +++++
 sound/soc/sof/debug.c             |  157 ++
 sound/soc/sof/ipc.c               |  788 ++++++++++
 sound/soc/sof/loader.c            |  287 ++++
 sound/soc/sof/ops.c               |  210 +++
 sound/soc/sof/ops.h               |  298 ++++
 sound/soc/sof/pcm.c               |  733 ++++++++++
 sound/soc/sof/pm.c                |  345 +++++
 sound/soc/sof/sof-priv.h          |  519 +++++++
 sound/soc/sof/topology.c          | 2222 +++++++++++++++++++++++++++++
 sound/soc/sof/trace.c             |  293 ++++
 24 files changed, 7889 insertions(+)
 create mode 100644 include/sound/sof.h
 create mode 100644 include/uapi/sound/sof-abi.h
 create mode 100644 include/uapi/sound/sof-eq.h
 create mode 100644 include/uapi/sound/sof-fw.h
 create mode 100644 include/uapi/sound/sof-ipc.h
 create mode 100644 include/uapi/sound/sof-tone.h
 create mode 100644 include/uapi/sound/sof-topology.h
 create mode 100644 sound/soc/sof/Kconfig
 create mode 100644 sound/soc/sof/Makefile
 create mode 100644 sound/soc/sof/control.c
 create mode 100644 sound/soc/sof/core.c
 create mode 100644 sound/soc/sof/debug.c
 create mode 100644 sound/soc/sof/ipc.c
 create mode 100644 sound/soc/sof/loader.c
 create mode 100644 sound/soc/sof/ops.c
 create mode 100644 sound/soc/sof/ops.h
 create mode 100644 sound/soc/sof/pcm.c
 create mode 100644 sound/soc/sof/pm.c
 create mode 100644 sound/soc/sof/sof-priv.h
 create mode 100644 sound/soc/sof/topology.c
 create mode 100644 sound/soc/sof/trace.c

-- 
2.17.1
