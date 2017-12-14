From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v6 00/14] soundwire: Add a new SoundWire subsystem
Date: Thu, 14 Dec 2017 10:02:22 +0100
Message-ID: <CAOFm3uH1njyJmPykLT0NjBfi2eB2+KfOeQUhzZDDModqG85LEg@mail.gmail.com>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Vinod,

On Thu, Dec 14, 2017 at 6:49 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> We are going to merge this series thru sound tree, need Mark's ack on
> regmap patch or to take it thru regmap tree.
>
> This patch series adds a new SoundWire subsystem which implements a
> new MIPI bus protocol 'SoundWire'.
>
> The SoundWire protocol is a robust, scalable, low complexity, low
> power, low latency, two-pin (clock and data) multi-drop bus that
> allows for the transfer of multiple audio streams and embedded
> control/commands.  SoundWire provides synchronization capabilities
> and supports both PCM and PDM, multichannel data, isochronous and
> asynchronous modes.
>
> This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
> Configuration) sysfs interface, regmap and Documentation summary.
>
> This patch series is also available on
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v6
>
> v5: https://lkml.org/lkml/2017/12/6/545
> v4: https://lkml.org/lkml/2017/12/1/205
> v3: https://lkml.org/lkml/2017/11/30/160
> v2: https://lkml.org/lkml/2017/11/10/216
> v1: https://lkml.org/lkml/2017/10/18/1030
> RFC: https://lkml.org/lkml/2016/10/21/395
>
> Changes in v6:
>   - Add reviewed/acked tags from Philippe, Pierre, Takashi and Greg
>   - Fix nitpicks from Takashi
>   - Drop the sysfs patch for now
>
> Changes in v5:
>   - Address comments by Pierre
>   - add reference to mid.mipi.org in documentation
>   - add group and master device number and don't use those for enumeration
>   - fix unused calls in disco code and also remove superfluous initialization
>   - remove sdw_transfer apis slave arg, make enum values integer and not
>     bitmaps
>   - clarify the sdw_program_device_num loop and fix interrupt handling
>
> Changes in v4:
> - Remove text licenses and add SPDX tags only with C99 style comments
> - make bus_type code as GPL v2.0 only
>
> Changes in v3:
> - Update the kernel-doc styles and fix included headers for files
> - handle dev_pm_domain_attach() for defered probe
> - remove OF placeholders
> - change regmap license to GPLv2 only
>
> Changes in v2:
> - move documentation into driver-api and do rst conversion
> - fix documentation comments
> - add SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) to all
>   source files
> - rework the transfer logic and paging logic as commented on v1
> - remove dummy sysfs fns
> - registration checks and fixes
> - remove slave check for regamp as that turned superfluous
> - remove depends SoundWire symbol
> - make modalias api arg const
> - use bitmap for tracking assigned
> - add counter for report present tracking
> todo: add the dt-bindings
>
> Sanyog Kale (4):
>   Documentation: Add SoundWire summary
>   soundwire: Add SoundWire MIPI defined registers
>   soundwire: Add Slave status handling helpers
>   soundwire: cdns: Add sdw_master_ops and IO transfer support
>
> Vinod Koul (10):
>   soundwire: Add SoundWire bus type
>   soundwire: Add Master registration
>   soundwire: Add MIPI DisCo property helpers
>   soundwire: Add IO transfer
>   regmap: Add SoundWire bus support
>   soundwire: Add slave status handling
>   soundwire: cdns: Add cadence library
>   soundwire: intel: Add Intel Master driver
>   soundwire: intel: Add Intel init module
>   MAINTAINERS: Add SoundWire entry
>
>  Documentation/driver-api/index.rst             |   1 +
>  Documentation/driver-api/soundwire/index.rst   |  15 +
>  Documentation/driver-api/soundwire/summary.rst | 207 +++++
>  MAINTAINERS                                    |   9 +
>  drivers/Kconfig                                |   2 +
>  drivers/Makefile                               |   1 +
>  drivers/base/regmap/Kconfig                    |   4 +
>  drivers/base/regmap/Makefile                   |   1 +
>  drivers/base/regmap/regmap-sdw.c               |  92 +++
>  drivers/soundwire/Kconfig                      |  37 +
>  drivers/soundwire/Makefile                     |  18 +
>  drivers/soundwire/bus.c                        | 997 +++++++++++++++++++++++++
>  drivers/soundwire/bus.h                        |  71 ++
>  drivers/soundwire/bus_type.c                   | 193 +++++
>  drivers/soundwire/cadence_master.c             | 751 +++++++++++++++++++
>  drivers/soundwire/cadence_master.h             |  48 ++
>  drivers/soundwire/intel.c                      | 345 +++++++++
>  drivers/soundwire/intel.h                      |  23 +
>  drivers/soundwire/intel_init.c                 | 198 +++++
>  drivers/soundwire/mipi_disco.c                 | 401 ++++++++++
>  drivers/soundwire/slave.c                      | 114 +++
>  include/linux/mod_devicetable.h                |   6 +
>  include/linux/regmap.h                         |  37 +
>  include/linux/soundwire/sdw.h                  | 479 ++++++++++++
>  include/linux/soundwire/sdw_intel.h            |  24 +
>  include/linux/soundwire/sdw_registers.h        | 194 +++++
>  include/linux/soundwire/sdw_type.h             |  19 +
>  scripts/mod/devicetable-offsets.c              |   4 +
>  scripts/mod/file2alias.c                       |  15 +
>  29 files changed, 4306 insertions(+)
>  create mode 100644 Documentation/driver-api/soundwire/index.rst
>  create mode 100644 Documentation/driver-api/soundwire/summary.rst
>  create mode 100644 drivers/base/regmap/regmap-sdw.c
>  create mode 100644 drivers/soundwire/Kconfig
>  create mode 100644 drivers/soundwire/Makefile
>  create mode 100644 drivers/soundwire/bus.c
>  create mode 100644 drivers/soundwire/bus.h
>  create mode 100644 drivers/soundwire/bus_type.c
>  create mode 100644 drivers/soundwire/cadence_master.c
>  create mode 100644 drivers/soundwire/cadence_master.h
>  create mode 100644 drivers/soundwire/intel.c
>  create mode 100644 drivers/soundwire/intel.h
>  create mode 100644 drivers/soundwire/intel_init.c
>  create mode 100644 drivers/soundwire/mipi_disco.c
>  create mode 100644 drivers/soundwire/slave.c
>  create mode 100644 include/linux/soundwire/sdw.h
>  create mode 100644 include/linux/soundwire/sdw_intel.h
>  create mode 100644 include/linux/soundwire/sdw_registers.h
>  create mode 100644 include/linux/soundwire/sdw_type.h
>
> --
> 2.7.4
>

Thanks!

For the whole patch set my reviewed-by stands for the usage of SPDX
license tags.
(I am not qualified to review the rest ;) )

-- 
Cordially
Philippe Ombredanne
