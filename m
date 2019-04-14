From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 0/5] soundwire: code cleanup
Date: Sun, 14 Apr 2019 15:34:17 +0530
Message-ID: <20190414100417.GH28103@vkoul-mobl>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Applied, 1, 3 and 4 (5 looked good but didnt apply)

Thanks

> 
> Changes since v2:
> fixed inversion of devm_kcalloc parameters, detected while rebasing
> additional patches.
> 
> Changes since v1:
> added missing newlines in new patch (suggested by Joe Perches)
> 
> Pierre-Louis Bossart (5):
>   soundwire: intel: fix inversion in devm_kcalloc parameters
>   soundwire: fix style issues
>   soundwire: bus: remove useless initializations
>   soundwire: stream: remove useless initialization of local variable
>   soundwire: add missing newlines in dynamic debug logs
> 
>  drivers/soundwire/Kconfig          |   2 +-
>  drivers/soundwire/bus.c            | 137 ++++++++-------
>  drivers/soundwire/bus.h            |  16 +-
>  drivers/soundwire/bus_type.c       |   4 +-
>  drivers/soundwire/cadence_master.c |  99 +++++------
>  drivers/soundwire/cadence_master.h |  22 +--
>  drivers/soundwire/intel.c          | 103 ++++++-----
>  drivers/soundwire/intel.h          |   4 +-
>  drivers/soundwire/intel_init.c     |  12 +-
>  drivers/soundwire/mipi_disco.c     | 116 +++++++------
>  drivers/soundwire/slave.c          |  10 +-
>  drivers/soundwire/stream.c         | 267 +++++++++++++++--------------
>  12 files changed, 404 insertions(+), 388 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
