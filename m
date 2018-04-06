From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 00/13] soundwire: Add stream support
Date: Thu, 5 Apr 2018 19:46:08 -0500
Message-ID: <050f17cb-519e-65d9-b34c-0d760c6ddedc@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 611382672B2
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 02:46:12 +0200 (CEST)
In-Reply-To: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, ALSA <alsa-devel@alsa-project.org>, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 4/5/18 11:48 AM, Vinod Koul wrote:
> This series adds support in SoundWire subsystem for:
>   - Documentation for stream support
>   - stream management
>   - data port management
>   - DAI ops in cadence and Intel drivers
>   - ASoC API to propagate SDW stream
> 
> Updates in v2:
>    - Make ASoC API inlined
>    - Make stream states as states and not action
>    - Update the direction enum
>    - Fix some typos and comment updates

This is better than v1 and has few minor comments to be addressed but 
one big problem: you shot yourselves in the foot with the changes in 
state management that are inconsistent with the documentation (see e.g 
the patch #2). Without explanations on the intent that entire stream 
management section makes little sense. If you can fix this in a v3 the 
series will be in much better shape. Thanks!

> 
> Sanyog Kale (7):
>    soundwire: Add more documentation
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
>   Documentation/driver-api/soundwire/stream.rst      |  368 +++++
>   drivers/soundwire/Kconfig                          |    2 +-
>   drivers/soundwire/Makefile                         |    2 +-
>   drivers/soundwire/bus.c                            |   43 +
>   drivers/soundwire/bus.h                            |   72 +
>   drivers/soundwire/cadence_master.c                 |  449 +++++-
>   drivers/soundwire/cadence_master.h                 |  151 ++
>   drivers/soundwire/intel.c                          |  528 ++++++-
>   drivers/soundwire/intel.h                          |    4 +
>   drivers/soundwire/intel_init.c                     |    3 +
>   drivers/soundwire/stream.c                         | 1549 ++++++++++++++++++++
>   include/linux/soundwire/sdw.h                      |  332 ++++-
>   include/linux/soundwire/sdw_intel.h                |   14 +
>   include/sound/soc-dai.h                            |   21 +
>   17 files changed, 3698 insertions(+), 14 deletions(-)
>   create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
>   create mode 100644 Documentation/driver-api/soundwire/locking.rst
>   create mode 100644 Documentation/driver-api/soundwire/stream.rst
>   create mode 100644 drivers/soundwire/stream.c
> 
