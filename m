From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
Date: Thu, 8 Aug 2019 14:48:28 +0100
Message-ID: <8529d213-bfbb-780a-092d-3607eeb5e543@linaro.org>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, "Rafael J. Wysocki" <rafael@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 19/07/2019 00:02, Pierre-Louis Bossart wrote:
> The existing code has a mixed select/depend usage which makes no sense.
> 
> config SOUNDWIRE_BUS
>         tristate
>         select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>          tristate
>          depends on SOUNDWIRE_BUS
> 
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/base/regmap/Kconfig | 2 +-
>   drivers/soundwire/Kconfig   | 7 +------
>   drivers/soundwire/Makefile  | 2 +-
>   3 files changed, 3 insertions(+), 8 deletions(-)

I have been using some thing similar in my setup.
I did test this with Qualcomm WSA881x codec.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
