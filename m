From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 27/40] soundwire: Add Intel resource management
 algorithm
Date: Fri, 26 Jul 2019 13:07:35 +0200
Message-ID: <869edbf2-1fdd-6b21-818f-20c39c013c11@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> This implementation is optimal for Intel platforms. Developers can
> also implement their own .compute_params() callback for specific
> resource management algorithm.
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.
> 
> FIXME: remove checkpatch report
> WARNING: Reusing the krealloc arg is almost always a bug
> +			group->rates = krealloc(group->rates,
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Could you specify the requirements and limitations for this algorithm? 
Last year I written calc for Linux based on Windows (please don't burn 
me here) equivalent though said requirements/ limitiations might have 
changed and nothing is valid any longer.

I remember that some parts of specification overcomplicated the 
calculator and due to actual, realtime usecases it could be greatly 
simplified (that's why I mention that my work is probably no longer 
valid). However, these details would help me in reviewing your 
implementation and providing suggestions.

And yes, "Frame shape calculator" probably suits this better.
Though this might be just a preference thingy : )
