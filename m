From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 00/14] Sound Open Firmware (SOF) core
Date: Tue, 11 Dec 2018 15:23:04 -0600
Message-ID: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sound Open Firmware (SOF) is a host and DSP architecture agnostic
audio DSP firmware. SOF is not tied to any specific host architecture
or any specific physical IO communication type (it will work with on
SoC DSPs, or DSP connected via SPI/I2C).

SOF is also not coupled to any particular DSP architecture and has
abstraction similar to Linux to allow porting to other DSP
architectures.

https://www.sofproject.org/

This patch series introduces the SOF core and utilities. Support for
Intel devices is provided as a follow-up series.

The SOF core manages all the core DSP services and ALSA/ASoC IO. The
core is responsible for loading firmware, parsing topology, exposing
PCMs and kcontrols, providing debug and trace mechanisms and
performing IPC between host and DSP.

The SOF core also has logic to allow reuse of existing machine drivers
for other platforms/machines without any code modification. i.e. DAI
links can be modified at runtime to bind with SOF and SOF topologies
instead of existing hard coded DAI links and topology.

Main changes since v2 (end of August):

There are honestly too many changes to be listed... The biggest
changes are the introduction of an ABI check and runtime_pm, as well
as countless improvements coming from product validation. We will
provide a revision history starting with the next update.

Precisions:

Since I've been maintaining the SOF kernel parts for most of 2018,
Liam and I mutually agreed that it would be more efficient for me to
send the patches upstream to avoid any disconnects. The code in this
patchset is directly squashed from the SOF development branch [1],
which tracks Mark Brown's for-next branch on a weekly basis and the
configurations used for testing are based on the defconfigs at [2]

Full disclosure on known limitation and issues (full list at [3])

a) the interaction with ASoC is not always perfect, there are a couple
of points where a better solution is desired (use of private data,
support for link DMA, etc). The known points are explicitly documented
in the code and will be updated. To be clearer, it's our belief that
SOF does not cripple ASoC in any way, and that merging this SOF core
does not harm others. It's just complicated to get things right,
especially on a couple of cases where the topology and DPCM frameworks
generate complex flows that very few people understand.
b) The get/put methods for controls generate an IPC and possibly a
wake-up. This is not optimal and is being fixed.
c) The debugfs parts will be updated for runtime_pm parts
d) The topology free, firmware release and Hdaudio exit sequences will
be updated. It is our intention to fully support module load/unload
and free all resources.
e) runtime_pm is being hardened and the use of SMART_SUSPEND was suggested.

Thank you for reviews and comments, we appreciate the time spent
commenting on this large patchset. Thanks in particular to Alan Cox
and Andy Shevchenko for their comments on an earlier version.

Pierre

[1] https://github.com/thesofproject/linux
[2] https://github.com/thesofproject/kconfig
[3] https://github.com/thesofproject/linux/issues

Liam Girdwood (12):
  ASoC: SOF: Add Sound Open Firmware driver core
  ASoC: SOF: Add Sound Open Firmware KControl support
  ASoC: SOF: Add driver debug support.
  ASoC: SOF: Add support for IPC IO between DSP and Host
  ASoC: SOF: Add PCM operations support
  ASoC: SOF: Add support for loading topologies
  ASoC: SOF: Add DSP firmware logger support
  ASoC: SOF: Add DSP HW abstraction operations
  ASoC: SOF: Add firmware loader support
  ASoC: SOF: Add userspace ABI support
  ASoC: SOF: Add PM support
  ASoC: SOF: Add Nocodec machine driver support

Pierre-Louis Bossart (2):
  ASoC: SOF: Add xtensa support
  ASoC: SOF: Add utils

 include/sound/soc.h               |    3 +
 include/sound/sof.h               |   91 +
 include/sound/sof/control.h       |  125 ++
 include/sound/sof/dai-intel.h     |  175 ++
 include/sound/sof/dai.h           |   75 +
 include/sound/sof/header.h        |  158 ++
 include/sound/sof/info.h          |  118 ++
 include/sound/sof/pm.h            |   48 +
 include/sound/sof/stream.h        |  149 ++
 include/sound/sof/topology.h      |  256 +++
 include/sound/sof/trace.h         |   66 +
 include/sound/sof/xtensa.h        |   44 +
 include/uapi/sound/sof/abi.h      |   63 +
 include/uapi/sound/sof/eq.h       |  164 ++
 include/uapi/sound/sof/fw.h       |   67 +
 include/uapi/sound/sof/header.h   |   27 +
 include/uapi/sound/sof/manifest.h |  188 ++
 include/uapi/sound/sof/tokens.h   |   95 +
 include/uapi/sound/sof/tone.h     |   21 +
 include/uapi/sound/sof/trace.h    |   93 +
 sound/soc/sof/control.c           |  421 +++++
 sound/soc/sof/core.c              |  398 +++++
 sound/soc/sof/debug.c             |  176 ++
 sound/soc/sof/ipc.c               |  813 +++++++++
 sound/soc/sof/loader.c            |  322 ++++
 sound/soc/sof/nocodec.c           |   81 +
 sound/soc/sof/ops.c               |  200 +++
 sound/soc/sof/ops.h               |  379 ++++
 sound/soc/sof/pcm.c               |  755 ++++++++
 sound/soc/sof/pm.c                |  403 +++++
 sound/soc/sof/sof-priv.h          |  574 ++++++
 sound/soc/sof/topology.c          | 2775 +++++++++++++++++++++++++++++
 sound/soc/sof/trace.c             |  295 +++
 sound/soc/sof/utils.c             |  173 ++
 sound/soc/sof/xtensa/Kconfig      |    3 +
 sound/soc/sof/xtensa/Makefile     |    5 +
 sound/soc/sof/xtensa/core.c       |  152 ++
 37 files changed, 9951 insertions(+)
 create mode 100644 include/sound/sof.h
 create mode 100644 include/sound/sof/control.h
 create mode 100644 include/sound/sof/dai-intel.h
 create mode 100644 include/sound/sof/dai.h
 create mode 100644 include/sound/sof/header.h
 create mode 100644 include/sound/sof/info.h
 create mode 100644 include/sound/sof/pm.h
 create mode 100644 include/sound/sof/stream.h
 create mode 100644 include/sound/sof/topology.h
 create mode 100644 include/sound/sof/trace.h
 create mode 100644 include/sound/sof/xtensa.h
 create mode 100644 include/uapi/sound/sof/abi.h
 create mode 100644 include/uapi/sound/sof/eq.h
 create mode 100644 include/uapi/sound/sof/fw.h
 create mode 100644 include/uapi/sound/sof/header.h
 create mode 100644 include/uapi/sound/sof/manifest.h
 create mode 100644 include/uapi/sound/sof/tokens.h
 create mode 100644 include/uapi/sound/sof/tone.h
 create mode 100644 include/uapi/sound/sof/trace.h
 create mode 100644 sound/soc/sof/control.c
 create mode 100644 sound/soc/sof/core.c
 create mode 100644 sound/soc/sof/debug.c
 create mode 100644 sound/soc/sof/ipc.c
 create mode 100644 sound/soc/sof/loader.c
 create mode 100644 sound/soc/sof/nocodec.c
 create mode 100644 sound/soc/sof/ops.c
 create mode 100644 sound/soc/sof/ops.h
 create mode 100644 sound/soc/sof/pcm.c
 create mode 100644 sound/soc/sof/pm.c
 create mode 100644 sound/soc/sof/sof-priv.h
 create mode 100644 sound/soc/sof/topology.c
 create mode 100644 sound/soc/sof/trace.c
 create mode 100644 sound/soc/sof/utils.c
 create mode 100644 sound/soc/sof/xtensa/Kconfig
 create mode 100644 sound/soc/sof/xtensa/Makefile
 create mode 100644 sound/soc/sof/xtensa/core.c

-- 
2.17.1
