From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 00/15] soundwire: Add a new SoundWire
 subsystem
Date: Fri, 1 Dec 2017 18:24:10 -0600
Message-ID: <404dd97d-767d-1f93-949b-487dcca96256@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1130D2670F4
 for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2017 01:24:14 +0100 (CET)
In-Reply-To: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 12/1/17 3:56 AM, Vinod Koul wrote:
> This patch series adds a new SoundWire subsystem which implements a
> new MIPI bus protocol 'SoundWire'.

Sorry for the late feedback Vinod and team.

Overall the code looks very good to me and aligned with the MIPI specs, 
there are only a couple of points that were added (or some code not 
removed) during the code cleanups, e.g.
- device12..14 should not be used
- device_property handling (master/controller confusion?)
- error cases on transfers
- spec race condition on interrupt clear (not bad but to be discussed 
further)
- some comments and code nit-picks

This is starting to get into second-order reviews really, which shows 
this is becoming quite mature. And for the record this work isn't just 
scratching the surface, it helped identify a couple of documentation 
issues in the MIPI specs which will lead to clarifications in future 
revisions.

Looking forward to a v5 ;-)

Thanks,
-Pierre

> 
> The SoundWire protocol is a robust, scalable, low complexity, low
> power, low latency, two-pin (clock and data) multi-drop bus that
> allows for the transfer of multiple audio streams and embedded
> control/commands.  SoundWire provides synchronization capabilities
> and supports both PCM and PDM, multichannel data, isochronous and
> asynchronous modes.
> 
> This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
> Configuration) sysfs interface, regmap and Documentation summary
> 
> This patch series is also available on
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v4
> 
> v3: https://lkml.org/lkml/2017/11/30/160
> v2: https://lkml.org/lkml/2017/11/10/216
> v1: https://lkml.org/lkml/2017/10/18/1030
> RFC: https://lkml.org/lkml/2016/10/21/395
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
>    source files
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
>    Documentation: Add SoundWire summary
>    soundwire: Add SoundWire MIPI defined registers
>    soundwire: Add Slave status handling helpers
>    soundwire: cdns: Add sdw_master_ops and IO transfer support
> 
> Vinod Koul (11):
>    soundwire: Add SoundWire bus type
>    soundwire: Add Master registration
>    soundwire: Add MIPI DisCo property helpers
>    soundwire: Add IO transfer
>    regmap: Add SoundWire bus support
>    soundwire: Add slave status handling
>    soundwire: Add sysfs for SoundWire DisCo properties
>    soundwire: cdns: Add cadence library
>    soundwire: intel: Add Intel Master driver
>    soundwire: intel: Add Intel init module
>    MAINTAINERS: Add SoundWire entry
> 
>   Documentation/driver-api/index.rst             |   1 +
>   Documentation/driver-api/soundwire/index.rst   |  15 +
>   Documentation/driver-api/soundwire/summary.rst | 205 ++++++
>   MAINTAINERS                                    |  10 +
>   drivers/Kconfig                                |   2 +
>   drivers/Makefile                               |   1 +
>   drivers/base/regmap/Kconfig                    |   4 +
>   drivers/base/regmap/Makefile                   |   1 +
>   drivers/base/regmap/regmap-sdw.c               |  92 +++
>   drivers/soundwire/Kconfig                      |  37 +
>   drivers/soundwire/Makefile                     |  18 +
>   drivers/soundwire/bus.c                        | 958 +++++++++++++++++++++++++
>   drivers/soundwire/bus.h                        |  74 ++
>   drivers/soundwire/bus_type.c                   | 193 +++++
>   drivers/soundwire/cadence_master.c             | 749 +++++++++++++++++++
>   drivers/soundwire/cadence_master.h             |  48 ++
>   drivers/soundwire/intel.c                      | 347 +++++++++
>   drivers/soundwire/intel.h                      |  23 +
>   drivers/soundwire/intel_init.c                 | 198 +++++
>   drivers/soundwire/mipi_disco.c                 | 374 ++++++++++
>   drivers/soundwire/slave.c                      | 115 +++
>   drivers/soundwire/sysfs.c                      | 343 +++++++++
>   include/linux/mod_devicetable.h                |   6 +
>   include/linux/regmap.h                         |  37 +
>   include/linux/soundwire/sdw.h                  | 487 +++++++++++++
>   include/linux/soundwire/sdw_intel.h            |  24 +
>   include/linux/soundwire/sdw_registers.h        | 194 +++++
>   include/linux/soundwire/sdw_type.h             |  19 +
>   scripts/mod/devicetable-offsets.c              |   4 +
>   scripts/mod/file2alias.c                       |  15 +
>   30 files changed, 4594 insertions(+)
>   create mode 100644 Documentation/driver-api/soundwire/index.rst
>   create mode 100644 Documentation/driver-api/soundwire/summary.rst
>   create mode 100644 drivers/base/regmap/regmap-sdw.c
>   create mode 100644 drivers/soundwire/Kconfig
>   create mode 100644 drivers/soundwire/Makefile
>   create mode 100644 drivers/soundwire/bus.c
>   create mode 100644 drivers/soundwire/bus.h
>   create mode 100644 drivers/soundwire/bus_type.c
>   create mode 100644 drivers/soundwire/cadence_master.c
>   create mode 100644 drivers/soundwire/cadence_master.h
>   create mode 100644 drivers/soundwire/intel.c
>   create mode 100644 drivers/soundwire/intel.h
>   create mode 100644 drivers/soundwire/intel_init.c
>   create mode 100644 drivers/soundwire/mipi_disco.c
>   create mode 100644 drivers/soundwire/slave.c
>   create mode 100644 drivers/soundwire/sysfs.c
>   create mode 100644 include/linux/soundwire/sdw.h
>   create mode 100644 include/linux/soundwire/sdw_intel.h
>   create mode 100644 include/linux/soundwire/sdw_registers.h
>   create mode 100644 include/linux/soundwire/sdw_type.h
> 
