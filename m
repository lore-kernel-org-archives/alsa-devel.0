From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 00/13] soundwire: Add stream support
Date: Mon, 16 Apr 2018 19:00:04 -0500
Message-ID: <b9859b31-aa9c-e501-e0b0-ef02a3a92c3e@linux.intel.com>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DAAB2673D4
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 02:00:07 +0200 (CEST)
In-Reply-To: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
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
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, ALSA <alsa-devel@alsa-project.org>, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org



On 04/16/2018 10:23 AM, Vinod Koul wrote:
> This series adds support in SoundWire subsystem for:
>   - Documentation for stream support
>   - stream management
>   - data port management
>   - DAI ops in cadence and Intel drivers
>   - ASoC API to propagate SDW stream
>
> Updates in v3:
>   - Remove stream state transition checks and redefine stream states
>   - Update bansk switch routines
>   - Other nitpicks pointed out by Pierre.
Thanks Vinod and team. This is much better than v2, now the stream 
management makes more sense. The only part that isn't clear is that the 
framework is supposed to call sdw_stream_add_master() last (to 
transition to CONFIGURED state), and that is not explicitly described in 
the documentation. The release part also has issues if the master is 
handled first, so again I believe there is an assumption that the slaves 
will be handled first.

There are still 3 or 4 issues on channel count and remaining comments 
not fixed, but this is starting to be reasonably self-explanatory and 
useful.

>
> Updates in v2:
>    - Make ASoC API inlined
>    - Make stream states as states and not action
>    - Update the direction enum
>    - Fix some typos and comment updates
>
> Sanyog Kale (7):
>    Documentation: soundwire: Add more documentation
>    soundwire: Add support for SoundWire stream management
>    soundwire: Add support for port management
>    soundwire: Add Master and Slave port programming
>    soundwire: Add helpers for ports operations
>    soundwire: Add bank switch routine
>    soundwire: Add stream configuration APIs
>
> Shreyas NC (2):
>    ASoC: Add SoundWire stream programming interface
>    soundwire: Remove cdns_master_ops
>
> Vinod Koul (4):
>    soundwire: cdns: Add port routines
>    soundwire: cdns: Add stream routines
>    soundwire: intel: Add stream initialization
>    soundwire: intel: Add audio DAI ops
>
>   .../driver-api/soundwire/error_handling.rst        |   65 +
>   Documentation/driver-api/soundwire/index.rst       |    3 +
>   Documentation/driver-api/soundwire/locking.rst     |  106 ++
>   Documentation/driver-api/soundwire/stream.rst      |  372 +++++
>   drivers/soundwire/Kconfig                          |    2 +-
>   drivers/soundwire/Makefile                         |    2 +-
>   drivers/soundwire/bus.c                            |   43 +
>   drivers/soundwire/bus.h                            |   72 +
>   drivers/soundwire/cadence_master.c                 |  453 +++++-
>   drivers/soundwire/cadence_master.h                 |  151 ++
>   drivers/soundwire/intel.c                          |  528 ++++++-
>   drivers/soundwire/intel.h                          |    4 +
>   drivers/soundwire/intel_init.c                     |    3 +
>   drivers/soundwire/stream.c                         | 1471 ++++++++++++++++++++
>   include/linux/soundwire/sdw.h                      |  332 ++++-
>   include/linux/soundwire/sdw_intel.h                |   14 +
>   include/sound/soc-dai.h                            |   21 +
>   17 files changed, 3628 insertions(+), 14 deletions(-)
>   create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
>   create mode 100644 Documentation/driver-api/soundwire/locking.rst
>   create mode 100644 Documentation/driver-api/soundwire/stream.rst
>   create mode 100644 drivers/soundwire/stream.c
>
