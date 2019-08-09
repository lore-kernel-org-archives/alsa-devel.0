From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
Date: Fri, 9 Aug 2019 10:21:31 +0530
Message-ID: <20190809045131.GF12733@vkoul-mobl.Dlink>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 18-07-19, 18:02, Pierre-Louis Bossart wrote:
> The existing code has a mixed select/depend usage which makes no sense.
> 
> config SOUNDWIRE_BUS
>        tristate
>        select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>         tristate
>         depends on SOUNDWIRE_BUS
> 
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.

Applied, thanks

-- 
~Vinod
