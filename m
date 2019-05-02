From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 22/22] soundwire: add missing newlines in dynamic
 debug logs
Date: Thu, 2 May 2019 11:07:46 +0530
Message-ID: <20190502053746.GE3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> For some reason the newlines are not used everywhere. Fix as needed.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c            |  74 +++++++++----------
>  drivers/soundwire/cadence_master.c |  12 ++--
>  drivers/soundwire/intel.c          |  12 ++--
>  drivers/soundwire/stream.c         | 110 ++++++++++++++---------------

Sorry this needs to be split up. I think bus.c and stream.c should go
in patch with cadence_master.c and intel.c in different ones


>  4 files changed, 104 insertions(+), 104 deletions(-)
-- 
~Vinod
