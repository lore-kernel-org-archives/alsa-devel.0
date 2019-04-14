From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
Date: Sun, 14 Apr 2019 15:43:47 +0530
Message-ID: <20190414101347.GJ28103@vkoul-mobl>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On 11-04-19, 14:28, Pierre-Louis Bossart wrote:
> 0-day/Kbuild starts complaining about missed module dependencies and
> compilation issues. Since codecs and soc drivers need to be compilable
> independently, let's fix this using the following model:

I have not seen a build report on this one, is this some internal Intel
report or on upstream tree?

> SOUNDWIRE_INTEL ---- select -----------
>                                       |
> 				      v
> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
> 
> 
> Pierre-Louis Bossart (2):
>   regmap: soundwire: fix Kconfig select/depend issue
>   soundwire: fix SOUNDWIRE_BUS option
> 
>  drivers/base/regmap/Kconfig | 3 ++-
>  drivers/soundwire/Kconfig   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
