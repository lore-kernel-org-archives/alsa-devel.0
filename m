From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/6] soundwire: inits and PM additions for
 5.4
Date: Wed, 21 Aug 2019 14:23:10 -0500
Message-ID: <57e5dab5-2641-7c4b-a05a-fb4f0adccfc7@linux.intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org



On 8/13/19 4:32 PM, Pierre-Louis Bossart wrote:
> This is an update on the RFC, to be applied after the '[PATCH v2 0/3]
> soundwire: debugfs support for 5.4' and '[PATCH 00/17] soundwire:
> fixes for 5.4' series.
> 
> Total that makes 28 patches submitted for review, broken in 3 sets.

I double-checked that this patchset does apply on top of soundwire/next 
+ the 4 debugfs patches I just sent earlier.

I will now send the rather big changes needed for SOF integration as an 
RFC, assuming this set is applied.

> 
> Changes since RFC (Feedback from GregKH, Vinod, Cezary, Guennadi):
> Squashed init sequence fixes in one patch, which remains
> readable. Tested all return values and called update_config() as
> needed.
> Fixed hw-reset debugfs (removed -unsafe and noisy dev_info traces)
> Simplified enable_interrupt() with goto
> Fixed style, removed typos and FIXMES in pm_runtime code
> Clarified commit messages
> 
> Pierre-Louis Bossart (6):
>    soundwire: fix startup sequence for Intel/Cadence
>    soundwire: cadence_master: add hw_reset capability in debugfs
>    soundwire: intel: add helper for initialization
>    soundwire: intel: Add basic power management support
>    soundwire: cadence_master: make clock stop exit configurable on init
>    soundwire: intel: add pm_runtime support
> 
>   drivers/soundwire/cadence_master.c | 135 ++++++++++++++------
>   drivers/soundwire/cadence_master.h |   5 +-
>   drivers/soundwire/intel.c          | 194 +++++++++++++++++++++++++++--
>   3 files changed, 289 insertions(+), 45 deletions(-)
> 
