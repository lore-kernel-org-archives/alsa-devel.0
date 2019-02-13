From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 00/20] ASoC: Sound Open Firmware (SOF) -
	Intel support
Date: Wed, 13 Feb 2019 16:08:27 -0600
Message-ID: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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

This patch series introduces the support for Intel devices (Baytrail,
CherryTrail, Broadwell/Haswell, ApolloLake, GeminiLake, CannonLake,
IceLake). Support for Skylake and KabyLake is incomplete at the moment
but the basic building blocks required are already present.

The series starts with the 'legacy' devices, then all the more recent
ones and concludes with ACPI/PCI hooks. SKL+ platforms can be compiled
without HDaudio link/codec support, in which case the hdac library is
not used. When support for HDMI or HDaudio codecs is selected, parts
of this library are used.

The machine drivers supported by SOF are not provided as part of this
series. The build will only work in 'nocodec' mode for now.

Support for SPI-based devices, compressed streams is also not provided
for now since it's not ready for upstream just yet.

Thank you for reviews and comments, we appreciate the time spent
commenting on this large patchset. Thanks in particular to Alan Cox
and Andy Shevchenko for their comments on an earlier version.

Changes since v2:

Addressed dozens of comments from Takashi Iwai, Mark Brown, Andy
Shevchenko, Daniel Baluta (Thanks!)
Transition to new display power management
Fixed suspend issues
Optimized register polling, better handling of timeouts and firmware
download retries
Detect number of HDaudio codec and select machine driver accordingly
Added workqueue based probe for HDaudio (dependency on modules)
Fixed platform name override and conflicts with DT deferred probe
changes
Added prefix for firmware and topology files and module arguments
Split Baytrail and Edison
Fixed warnings (smatch, cppcheck)

Keyon Jie (2):
  ASoC: SOF: Intel: Add hda-bus support and initialization
  ASoC: SOF: Intel: SKL, CNL, APL platform DAIs

Liam Girdwood (15):
  ASoC: SOF: Intel: Add BYT, CHT and BSW DSP HW support.
  ASoC: SOF: Intel: Add HSW HW DSP support
  ASoC: SOF: Intel: Add BDW HW DSP support
  ASoC: SOF: Intel: Add APL/CNL HW DSP support
  ASoC: SOF: Intel: Add HDA controller for Intel DSP
  ASoC: SOF: Intel: Add Intel specific HDA DSP HW operations
  ASoC: SOF: Intel: Add Intel specific HDA IPC mechanisms.
  ASoC: SOF: Intel: Add Intel specific HDA firmware loader
  ASoC: SOF: Intel: Add Intel specific HDA PCM operations
  ASoC: SOF: Intel: Add Intel specific HDA stream operations
  ASoC: SOF: Intel: Add Intel specific HDA trace operations
  ASoC: SOF: Intel: Add platform differentiation for SKL, APL and CNL
  ASoC: SOF: Add ACPI device support
  ASoC: SOF: Add PCI device support
  ASoC: SOF: Add Build support for SOF core and Intel drivers

Pierre-Louis Bossart (3):
  ASoC: SOF: Intel: Add support for HDAudio codecs
  ASoC: SOF: Intel: Add SKL-specific code loader
  ASoC: Intel: Kconfig: expose common option between SST and SOF drivers

 sound/soc/Kconfig                    |   1 +
 sound/soc/Makefile                   |   1 +
 sound/soc/intel/Kconfig              |   7 +-
 sound/soc/sof/Kconfig                | 141 +++++
 sound/soc/sof/Makefile               |  18 +
 sound/soc/sof/intel/Kconfig          | 253 ++++++++
 sound/soc/sof/intel/Makefile         |  17 +
 sound/soc/sof/intel/apl.c            | 111 ++++
 sound/soc/sof/intel/bdw.c            | 716 +++++++++++++++++++++
 sound/soc/sof/intel/byt.c            | 893 +++++++++++++++++++++++++++
 sound/soc/sof/intel/cnl.c            | 269 ++++++++
 sound/soc/sof/intel/hda-bus.c        | 108 ++++
 sound/soc/sof/intel/hda-codec.c      | 171 +++++
 sound/soc/sof/intel/hda-ctrl.c       | 165 +++++
 sound/soc/sof/intel/hda-dai.c        | 362 +++++++++++
 sound/soc/sof/intel/hda-dsp.c        | 440 +++++++++++++
 sound/soc/sof/intel/hda-ipc.c        | 403 ++++++++++++
 sound/soc/sof/intel/hda-loader-skl.c | 526 ++++++++++++++++
 sound/soc/sof/intel/hda-loader.c     | 359 +++++++++++
 sound/soc/sof/intel/hda-pcm.c        | 235 +++++++
 sound/soc/sof/intel/hda-stream.c     | 663 ++++++++++++++++++++
 sound/soc/sof/intel/hda-trace.c      |  98 +++
 sound/soc/sof/intel/hda.c            | 680 ++++++++++++++++++++
 sound/soc/sof/intel/hda.h            | 549 ++++++++++++++++
 sound/soc/sof/intel/hsw.c            | 717 +++++++++++++++++++++
 sound/soc/sof/intel/shim.h           | 177 ++++++
 sound/soc/sof/intel/skl.c            | 104 ++++
 sound/soc/sof/sof-acpi-dev.c         | 310 ++++++++++
 sound/soc/sof/sof-pci-dev.c          | 351 +++++++++++
 29 files changed, 8844 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/sof/Kconfig
 create mode 100644 sound/soc/sof/Makefile
 create mode 100644 sound/soc/sof/intel/Kconfig
 create mode 100644 sound/soc/sof/intel/Makefile
 create mode 100644 sound/soc/sof/intel/apl.c
 create mode 100644 sound/soc/sof/intel/bdw.c
 create mode 100644 sound/soc/sof/intel/byt.c
 create mode 100644 sound/soc/sof/intel/cnl.c
 create mode 100644 sound/soc/sof/intel/hda-bus.c
 create mode 100644 sound/soc/sof/intel/hda-codec.c
 create mode 100644 sound/soc/sof/intel/hda-ctrl.c
 create mode 100644 sound/soc/sof/intel/hda-dai.c
 create mode 100644 sound/soc/sof/intel/hda-dsp.c
 create mode 100644 sound/soc/sof/intel/hda-ipc.c
 create mode 100644 sound/soc/sof/intel/hda-loader-skl.c
 create mode 100644 sound/soc/sof/intel/hda-loader.c
 create mode 100644 sound/soc/sof/intel/hda-pcm.c
 create mode 100644 sound/soc/sof/intel/hda-stream.c
 create mode 100644 sound/soc/sof/intel/hda-trace.c
 create mode 100644 sound/soc/sof/intel/hda.c
 create mode 100644 sound/soc/sof/intel/hda.h
 create mode 100644 sound/soc/sof/intel/hsw.c
 create mode 100644 sound/soc/sof/intel/shim.h
 create mode 100644 sound/soc/sof/intel/skl.c
 create mode 100644 sound/soc/sof/sof-acpi-dev.c
 create mode 100644 sound/soc/sof/sof-pci-dev.c

-- 
2.17.1
