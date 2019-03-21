From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 00/20] ASoC: Sound Open Firmware (SOF) -
	Intel support
Date: Thu, 21 Mar 2019 11:10:35 -0500
Message-ID: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch series introduces the support for Intel devices (Baytrail,
CherryTrail, Broadwell, ApolloLake, GeminiLake, CannonLake,
IceLake). Support for Haswell, Skylake and KabyLake is incomplete at
the moment and is not shared for now.

The series starts with the 'legacy' devices, then all the more recent
ones and concludes with ACPI/PCI hooks. SKL+ platforms can be compiled
without HDaudio link/codec support, in which case the hdac library is
not used. When support for HDMI or HDaudio codecs is selected, parts
of this library are used.

A small set of machine drivers supported by SOF is now provided as
part of this series, more to follow.

Support for SPI-based devices, compressed streams is also not provided
for now since it's not ready for upstream just yet.

Thank you for reviews and comments, we appreciate the time spent
commenting on this large patchset. Thanks in particular to Alan Cox
and Andy Shevchenko for their comments on an earlier version.

Changes since v3:

Removed Haswell, Skylake and Kabylake support (code is not tested or
is still under development). These devices will be re-added when there
is functional firmware and for Skylake/Kabylake a signed version of
the firmware usable on existing platforms.
Added support for existing machine drivers when relevant (more machine
drivers will be added in next batch)
Fixed hardware programming sequences (ROM init timeout, HDaudio
capture, simultaneous capture and playback, DMA preload)
Avoid reading IPC reply on CTX_SAVE reply since memory windows might
be powered off.
Simplified NOCODEC support, now mutually exclusive with HDaudio link
to avoid suspend/resume issues.

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
  ASoC: SOF: Intel: add SKL+ platform DAIs

Liam Girdwood (15):
  ASoC: SOF: Intel: Add BYT, CHT and BSW DSP HW support.
  ASoC: SOF: Intel: Add BDW HW DSP support
  ASoC: SOF: Intel: Add APL/CNL HW DSP support
  ASoC: SOF: Intel: Add HDA controller for Intel DSP
  ASoC: SOF: Intel: Add Intel specific HDA DSP HW operations
  ASoC: SOF: Intel: Add Intel specific HDA IPC mechanisms.
  ASoC: SOF: Intel: Add Intel specific HDA firmware loader
  ASoC: SOF: Intel: Add Intel specific HDA PCM operations
  ASoC: SOF: Intel: Add Intel specific HDA stream operations
  ASoC: SOF: Intel: Add Intel specific HDA trace operations
  ASoC: SOF: Intel: Add platform differentiation for APL and CNL
  ASoC: SOF: Add ACPI device support
  ASoC: SOF: Add PCI device support
  ASoC: SOF: Add Build support for SOF core and Intel drivers
  ASoC: Intel: Make sure HSW/BDW based machine drivers build for SOF

Pierre-Louis Bossart (3):
  ASoC: SOF: Intel: Add support for HDAudio codecs
  ASoC: Intel: Kconfig: expose common option between SST and SOF drivers
  ASoC: Intel: select relevant machine drivers for SOF

 sound/soc/Kconfig                   |   1 +
 sound/soc/Makefile                  |   1 +
 sound/soc/intel/Kconfig             |   7 +-
 sound/soc/intel/boards/Kconfig      |  22 +-
 sound/soc/intel/boards/bdw-rt5677.c |   4 +
 sound/soc/intel/boards/broadwell.c  |   4 +
 sound/soc/intel/boards/haswell.c    |   4 +
 sound/soc/sof/Kconfig               | 141 +++++
 sound/soc/sof/Makefile              |  18 +
 sound/soc/sof/intel/Kconfig         | 222 ++++++++
 sound/soc/sof/intel/Makefile        |  15 +
 sound/soc/sof/intel/apl.c           | 112 ++++
 sound/soc/sof/intel/bdw.c           | 694 ++++++++++++++++++++++
 sound/soc/sof/intel/byt.c           | 853 ++++++++++++++++++++++++++++
 sound/soc/sof/intel/cnl.c           | 257 +++++++++
 sound/soc/sof/intel/hda-bus.c       | 108 ++++
 sound/soc/sof/intel/hda-codec.c     | 171 ++++++
 sound/soc/sof/intel/hda-ctrl.c      | 165 ++++++
 sound/soc/sof/intel/hda-dai.c       | 318 +++++++++++
 sound/soc/sof/intel/hda-dsp.c       | 428 ++++++++++++++
 sound/soc/sof/intel/hda-ipc.c       | 402 +++++++++++++
 sound/soc/sof/intel/hda-loader.c    | 366 ++++++++++++
 sound/soc/sof/intel/hda-pcm.c       | 242 ++++++++
 sound/soc/sof/intel/hda-stream.c    | 682 ++++++++++++++++++++++
 sound/soc/sof/intel/hda-trace.c     |  98 ++++
 sound/soc/sof/intel/hda.c           | 672 ++++++++++++++++++++++
 sound/soc/sof/intel/hda.h           | 546 ++++++++++++++++++
 sound/soc/sof/intel/shim.h          | 179 ++++++
 sound/soc/sof/sof-acpi-dev.c        | 310 ++++++++++
 sound/soc/sof/sof-pci-dev.c         | 373 ++++++++++++
 30 files changed, 7407 insertions(+), 8 deletions(-)
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
 create mode 100644 sound/soc/sof/intel/hda-loader.c
 create mode 100644 sound/soc/sof/intel/hda-pcm.c
 create mode 100644 sound/soc/sof/intel/hda-stream.c
 create mode 100644 sound/soc/sof/intel/hda-trace.c
 create mode 100644 sound/soc/sof/intel/hda.c
 create mode 100644 sound/soc/sof/intel/hda.h
 create mode 100644 sound/soc/sof/intel/shim.h
 create mode 100644 sound/soc/sof/sof-acpi-dev.c
 create mode 100644 sound/soc/sof/sof-pci-dev.c

-- 
2.17.1
