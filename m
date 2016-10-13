From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: inconsistent reference counting for snd-soc-skl
Date: Thu, 13 Oct 2016 19:11:06 +0530
Message-ID: <20161013134102.GA24627@subhransu-desktop>
References: <120ab1f8-002d-de8e-358e-f3b486dc1012@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3094626640F
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 15:48:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <120ab1f8-002d-de8e-358e-f3b486dc1012@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dharageswari.r@intel.com, vinod.koul@intel.com, jayachandran.b@intel.com, broonie@kernel.org, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2016 at 10:19:37PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> I find an issue of snd-soc-skl due to inconsistent reference counting.
> See this call graph.
> 
> skl_probe()
> ->skl_first_init()
>   ->skl_i915_init()
>     ->snd_hdac_display_power() (CONFIG_SND_SOC_HDAC_HDMI is enabled)
>       ->bus->i915_power_refcount++
> ->all error pathes
>   ->skl_free()
>     ->snd_hda_i915_exit()
>       ->WARN_ON(!bus->i915_power_refcount)
> 
> This might be also hit by rmmod(8). I see this bug in kernel 4.8 and
> pre-4.9.

Thanks Takashi for reporting. We will fix this.

Regards,
Subhransu

> 
> 
> Regards
> 
> Takashi Sakamoto

-- 
