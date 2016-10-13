From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: inconsistent reference counting for snd-soc-skl
Date: Thu, 13 Oct 2016 22:54:43 +0900
Message-ID: <7ba3f3ea-d5ac-d90c-d5b7-2bc59897d116@sakamocchi.jp>
References: <120ab1f8-002d-de8e-358e-f3b486dc1012@sakamocchi.jp>
 <20161013134102.GA24627@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 0EB2C26640F
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 15:54:49 +0200 (CEST)
In-Reply-To: <20161013134102.GA24627@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dharageswari.r@intel.com, vinod.koul@intel.com, jayachandran.b@intel.com, broonie@kernel.org, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 13 2016 22:41, Subhransu S. Prusty wrote:
> On Thu, Oct 13, 2016 at 10:19:37PM +0900, Takashi Sakamoto wrote:
>> Hi,
>>
>> I find an issue of snd-soc-skl due to inconsistent reference counting.
>> See this call graph.
>>
>> skl_probe()
>> ->skl_first_init()
>>   ->skl_i915_init()
>>     ->snd_hdac_display_power() (CONFIG_SND_SOC_HDAC_HDMI is enabled)
>>       ->bus->i915_power_refcount++
>> ->all error pathes
>>   ->skl_free()
>>     ->snd_hda_i915_exit()
>>       ->WARN_ON(!bus->i915_power_refcount)
>>
>> This might be also hit by rmmod(8). I see this bug in kernel 4.8 and
>> pre-4.9.
> 
> Thanks Takashi for reporting. We will fix this.

Thanks for the quick reply.

I'd like to correct the explanation. In last half of skl_probe(), the
reference count is decremented.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/intel/skylake/skl.c#n719

So this issue may occur on error paths between call of skl_first_init()
and the part.


Takashi Sakamoto
