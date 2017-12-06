From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5 00/15] soundwire: Add a new SoundWire
	subsystem
Date: Wed, 6 Dec 2017 21:44:40 +0100
Message-ID: <CAOFm3uFNo2Y9_4mHzzsypO4n67KtJF8ZKqW8si_F46K77NFwrg@mail.gmail.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B33267044
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 21:45:21 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id g53so5283314wra.2
 for <alsa-devel@alsa-project.org>; Wed, 06 Dec 2017 12:45:21 -0800 (PST)
In-Reply-To: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 6, 2017 at 4:46 PM, Vinod Koul <vinod.koul@intel.com> wrote:
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
> Configuration) sysfs interface, regmap and Documentation summary
>
> This patch series is also available on
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v5
>
> v4: https://lkml.org/lkml/2017/12/1/205
> v3: https://lkml.org/lkml/2017/11/30/160
> v2: https://lkml.org/lkml/2017/11/10/216
> v1: https://lkml.org/lkml/2017/10/18/1030
> RFC: https://lkml.org/lkml/2016/10/21/395
>
> Changes in v5:
> - Address comments by Pierre
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
> Vinod Koul (11):
>   soundwire: Add SoundWire bus type
>   soundwire: Add Master registration
>   soundwire: Add MIPI DisCo property helpers
>   soundwire: Add IO transfer
>   regmap: Add SoundWire bus support
>   soundwire: Add slave status handling
>   soundwire: Add sysfs for SoundWire DisCo properties
>   soundwire: cdns: Add cadence library
>   soundwire: intel: Add Intel Master driver
>   soundwire: intel: Add Intel init module
>   MAINTAINERS: Add SoundWire entry
>
>  Documentation/driver-api/index.rst             |   1 +
>  Documentation/driver-api/soundwire/index.rst   |  15 +
>  Documentation/driver-api/soundwire/summary.rst | 207 ++++++
>  MAINTAINERS                                    |  10 +
>  drivers/Kconfig                                |   2 +
>  drivers/Makefile                               |   1 +
>  drivers/base/regmap/Kconfig                    |   4 +
>  drivers/base/regmap/Makefile                   |   1 +
>  drivers/base/regmap/regmap-sdw.c               |  92 +++
>  drivers/soundwire/Kconfig                      |  37 +
>  drivers/soundwire/Makefile                     |  18 +
>  drivers/soundwire/bus.c                        | 967 +++++++++++++++++++++++++
>  drivers/soundwire/bus.h                        |  73 ++
>  drivers/soundwire/bus_type.c                   | 193 +++++
>  drivers/soundwire/cadence_master.c             | 749 +++++++++++++++++++
>  drivers/soundwire/cadence_master.h             |  48 ++
>  drivers/soundwire/intel.c                      | 347 +++++++++
>  drivers/soundwire/intel.h                      |  23 +
>  drivers/soundwire/intel_init.c                 | 198 +++++
>  drivers/soundwire/mipi_disco.c                 | 370 ++++++++++
>  drivers/soundwire/slave.c                      | 115 +++
>  drivers/soundwire/sysfs.c                      | 343 +++++++++
>  include/linux/mod_devicetable.h                |   6 +
>  include/linux/regmap.h                         |  37 +
>  include/linux/soundwire/sdw.h                  | 495 +++++++++++++
>  include/linux/soundwire/sdw_intel.h            |  24 +
>  include/linux/soundwire/sdw_registers.h        | 194 +++++
>  include/linux/soundwire/sdw_type.h             |  19 +
>  scripts/mod/devicetable-offsets.c              |   4 +
>  scripts/mod/file2alias.c                       |  15 +
>  30 files changed, 4608 insertions(+)

Vinod:
For the whole patch series usage of the new SPDX-License-identifiers:
Thank you very much!
This makes the code so much more pleasant to read.

I am not qualified to review the code, but feel free to add my ack or
review for the license id parts.
Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
-- 
Cordially
Philippe Ombredanne
