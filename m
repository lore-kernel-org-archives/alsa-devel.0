From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 00/14] ASoC: Sound Open Firmware (SOF) core
Date: Wed, 13 Feb 2019 16:07:20 -0600
Message-ID: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
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

Changes since v3:

Addressed dozens ofcomments from Takashi Iwai, Mark Brown, Andy
Shevchenko, Daniel Baluta (Thanks!)
Hardened memory allocation, fixed module load/unload oops or errors
(now at hundreds of cycles on ApolloLake devices)
Fixed suspend/resume and removed use of suspend_late, now using
snd_soc_pm_ops and standard flow
Fixed topology free (multiple patches already contributed for
ASoC-core)
Fixed debugfs/pm_runtime interaction
Removed error checks on debugfs, changed to EXPORT_SYMBOL_GPL
Added filenames in debug messages, ues hex_dump_to_buffer
Removed "sof-audio" platform device and added better error checks on
probe
Reworked data structures to remove mix of const/variable fields and
duplication of pointers for platform-specific changes
Removed redundant ops tables
Fixed trace/logger issues
Fixed issues with loader (alignment and block size errors)
Fixed release_firmware handling (was all over the place)
Simplified PCI handling
Added comments on non-atomic triggers
Removed enum controls (not supported in topology)
Simplified include file dependencies
Fix cppcheck warnings
Fixed Kconfigs to deal with Kbuild warnings on exotic architectures

Precisions:

The code in this patchset is directly squashed from the SOF
development branch [1], which tracks Mark Brown's for-next branch on a
weekly basis and the configurations used for testing are based on the
defconfigs at [2]. The patches are also used backported for Chromebook
devices.

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
c) runtime_pm is being hardened and the use of SMART_SUSPEND was suggested.

Thank you for reviews and comments, we appreciate the time spent
commenting on this large patchset. Thanks in particular to Alan Cox
and Andy Shevchenko for their comments on an earlier version. This
patchset also includes contributions from Daniel Baluta for loading
code on non-Intel platforms.

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
 include/sound/sof.h               |  100 +
 include/sound/sof/control.h       |  125 ++
 include/sound/sof/dai-intel.h     |  178 ++
 include/sound/sof/dai.h           |   75 +
 include/sound/sof/header.h        |  158 ++
 include/sound/sof/info.h          |  118 ++
 include/sound/sof/pm.h            |   48 +
 include/sound/sof/stream.h        |  149 ++
 include/sound/sof/topology.h      |  256 +++
 include/sound/sof/trace.h         |   66 +
 include/sound/sof/xtensa.h        |   44 +
 include/uapi/sound/sof/abi.h      |   62 +
 include/uapi/sound/sof/eq.h       |  164 ++
 include/uapi/sound/sof/fw.h       |   78 +
 include/uapi/sound/sof/header.h   |   27 +
 include/uapi/sound/sof/manifest.h |  188 ++
 include/uapi/sound/sof/tokens.h   |   98 +
 include/uapi/sound/sof/tone.h     |   21 +
 include/uapi/sound/sof/trace.h    |   93 +
 sound/soc/sof/control.c           |  361 ++++
 sound/soc/sof/core.c              |  473 +++++
 sound/soc/sof/debug.c             |  219 +++
 sound/soc/sof/ipc.c               |  842 +++++++++
 sound/soc/sof/loader.c            |  363 ++++
 sound/soc/sof/nocodec.c           |  109 ++
 sound/soc/sof/ops.c               |  204 +++
 sound/soc/sof/ops.h               |  414 +++++
 sound/soc/sof/pcm.c               |  710 ++++++++
 sound/soc/sof/pm.c                |  381 ++++
 sound/soc/sof/sof-priv.h          |  599 ++++++
 sound/soc/sof/topology.c          | 2808 +++++++++++++++++++++++++++++
 sound/soc/sof/trace.c             |  298 +++
 sound/soc/sof/utils.c             |  109 ++
 sound/soc/sof/xtensa/Kconfig      |    2 +
 sound/soc/sof/xtensa/Makefile     |    5 +
 sound/soc/sof/xtensa/core.c       |  138 ++
 37 files changed, 10086 insertions(+)
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
