From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 03/22] soundwire: fix alignment issues in header files
Date: Thu, 2 May 2019 10:55:44 +0530
Message-ID: <20190502052544.GB3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> use Linux style
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 12 ++++++------
>  drivers/soundwire/cadence_master.h | 18 +++++++++---------

Again this touches core and lib.

Btw I applied the patches to check for alignment and they look good on
that part.

Thanks

-- 
~Vinod
