From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v6 00/14] ASoC: Sound Open Firmware (SOF) core
Date: Fri, 12 Apr 2019 11:05:05 -0500
Message-ID: <20190412160519.30207-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
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

Changes since v5:

In addition to addressing feedback from Takashi, the major
change in this series is the IPC rework. We reverted some
optimizations to help Daniel Baluta @ NXP submit support for i.MX
platforms, additional IPC core refactorization will start once we have
two platforms supported on github. Hopefully by then the code will be
accepted in the ASoC tree and we can submit delta patches, hint hint
wink wink.

All feedback from Takashi addressed:
Tabify/align Kconfigs
Remove INFO_RESUME flag
Add const char* for core prototypes
Fix snd_sof_get_status return value
Use smd_pcm_format_physical_width()
Fix hw_constraints and BUFFER_BYTES/SIZE confusion
Remove useless fallthrough statements
Fix typos and duplicate words in comments and commit messages
Remove unnecessary casts, use container_of
Remove superfluous initializations
Fix potential race condition in debugfs
Check for wrap-arounds in loader
Fix alignment in debugfs read
Don't use devm_kasprintf for firmware name string.

Other updates:
Major refactor of IPC handling (support for large messages, code
optimization, better abstraction to push Intel-specific code out of
the core).
Regenerate compressed page table only if needed
Support for multiple DAI hw_config (from <dragos_tarcatu@mentor.com>)
Use iopoll macros (with small change due to indirection)
Fix PM refcount handling on errors
Rename/unify all definitions for effects (now 'process')
Added basic support for keyword/hotword detection and binding widgets
with external events
Fix release of topology resources
Support new IPC_PANIC message
Clean-up mandatory/optional callbacks, simplify wrappers
Add topology ABI check
Fix acpi/machine driver handling
Fix memory leak in debugfs error handling
Alignment with firmware header files
Fixed topology endianness issues

Changes since v4:

feedback from Mark:
Removed need for private field in soc_runtime
Completely reworked IPC, now much simpler and robust. IPC refactoring
work will continue to e.g. allow for different types of IPC hardware
and a better split between core and platform-specific drivers.

Feedback from Takashi:
Clarified endianness and alignment issues for page tables
Removed useless mutexes
Removed unneeded initializations, return types and wrappers
Use snd_mask_set_format()
Trace code flow optimization
Removed checks on preallocate_pages()
Test status of open/close functions.

Released reference when pm_runtime_get_sync fails
Fixed multiple memory allocation issues
Fixed static analysis warnings
Fixed error checks with copy_to_user()
Added support for multi-core DSPs
Fixed leaked references with firmware handling on resume
Multiple topology fixes/improvements (enum/switch, mux, removal of
duplicate connections, widget power not reported as ON)
Code simplifications (removed set-but-unused, typecasts, etc).

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

 include/sound/sof.h               |  100 +
 include/sound/sof/control.h       |  158 ++
 include/sound/sof/dai-intel.h     |  178 ++
 include/sound/sof/dai.h           |   75 +
 include/sound/sof/header.h        |  158 ++
 include/sound/sof/info.h          |  118 ++
 include/sound/sof/pm.h            |   48 +
 include/sound/sof/stream.h        |  148 ++
 include/sound/sof/topology.h      |  256 +++
 include/sound/sof/trace.h         |   67 +
 include/sound/sof/xtensa.h        |   44 +
 include/uapi/sound/sof/abi.h      |   62 +
 include/uapi/sound/sof/eq.h       |  172 ++
 include/uapi/sound/sof/fw.h       |   78 +
 include/uapi/sound/sof/header.h   |   27 +
 include/uapi/sound/sof/manifest.h |  188 ++
 include/uapi/sound/sof/tokens.h   |  107 +
 include/uapi/sound/sof/tone.h     |   21 +
 include/uapi/sound/sof/trace.h    |   66 +
 sound/soc/sof/control.c           |  552 +++++
 sound/soc/sof/core.c              |  506 +++++
 sound/soc/sof/debug.c             |  232 +++
 sound/soc/sof/ipc.c               |  832 ++++++++
 sound/soc/sof/loader.c            |  400 ++++
 sound/soc/sof/nocodec.c           |  109 +
 sound/soc/sof/ops.c               |  163 ++
 sound/soc/sof/ops.h               |  399 ++++
 sound/soc/sof/pcm.c               |  719 +++++++
 sound/soc/sof/pm.c                |  385 ++++
 sound/soc/sof/sof-priv.h          |  632 ++++++
 sound/soc/sof/topology.c          | 3164 +++++++++++++++++++++++++++++
 sound/soc/sof/trace.c             |  297 +++
 sound/soc/sof/utils.c             |  112 +
 sound/soc/sof/xtensa/Kconfig      |    2 +
 sound/soc/sof/xtensa/Makefile     |    5 +
 sound/soc/sof/xtensa/core.c       |  138 ++
 36 files changed, 10718 insertions(+)
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


base-commit: 5f2ab35fe853f4886da490de8bc47637f5fc2921
-- 
2.17.1
