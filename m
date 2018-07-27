From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v8 00/10] soundwire: Add multi link support
Date: Fri, 27 Jul 2018 10:12:29 -0500
Message-ID: <8a155a5e-f0d2-aae3-2331-353c43afdaaf@linux.intel.com>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id B006C26720C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 17:12:32 +0200 (CEST)
In-Reply-To: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
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
To: Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On 7/27/18 4:14 AM, Shreyas NC wrote:
> Currently, in the SoundWire subsystem, the concept of stream is limited
> to a Master and one or more Slaves(Codecs). This series aims to add
> support for multiple Master(s) sharing the same reference clock and
> synchronized in the hardware.
> 
> This patch series adds:
>   - Fix to avoid duplicate stream state assignment
>   - Avoid incorrect stream release after configuring Master
>   - Fix to avoid bus lock acquired twice
>   - Helpers to lock bus instances part of the stream
>   - Boiler plate conversion of code to support a list of Master runtime
>   - Support multi link bank switch to support synchronization between
>     multiple masters
>   - Add Intel platform ops for pre/post bank switch
> 
> Additionally, as suggested by Vinod, the generic fixes are arranged
> at the top of the series followed by the Documentation patch for
> multi link support and then the multi link patches.

Looks good!

All patches
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


Thanks Shreyas and Sanyog for the updates and taking care of the comments.

> 
> changes in v8:
>   - Check both m_rt_count and bus->multi_link flag for clean up after
>     single instance bankswitch as suggested by Pierre.
> 
> changes in v7:
>   - Fix the git bisect issue pointed by Pierre. Now, the initialization
>     of the m_rt_count and its modification/usage is split into 2 patches.
>     While the declaration and initialization is in one patch,
>     modification of the refcount and usage is in the multilink bankswitch
>     patch.
>   - Re-arrange the patches as suggested by Vinod
> 
> Sanyog Kale (3):
>    soundwire: Fix acquiring bus lock twice during master release
>    Documentation: soundwire: Add documentation for multi link
>    soundwire: Add support to lock across bus instances
> 
> Shreyas NC (6):
>    soundwire: Fix duplicate stream state assignment
>    soundwire: Fix incorrect exit after configuring stream
>    soundwire: Initialize completion for defer messages
>    soundwire: keep track of Masters in a stream
>    soundwire: Add support for multi link bank switch
>    soundwire: intel: Add pre/post bank switch ops
> 
> Vinod Koul (1):
>    soundwire: Handle multiple master instances in a stream
> 
>   Documentation/driver-api/soundwire/stream.rst |  28 ++
>   drivers/soundwire/bus.c                       |   6 +
>   drivers/soundwire/bus.h                       |   4 +
>   drivers/soundwire/intel.c                     |  65 ++++
>   drivers/soundwire/stream.c                    | 511 +++++++++++++++++++-------
>   include/linux/soundwire/sdw.h                 |  12 +-
>   6 files changed, 489 insertions(+), 137 deletions(-)
> 
