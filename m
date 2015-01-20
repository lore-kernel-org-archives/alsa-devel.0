From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: alsa-lib support for compress offload
Date: Tue, 20 Jan 2015 09:53:59 +0000
Message-ID: <54BE25B7.1040606@imgtec.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
 <54BD3D7F.6020105@imgtec.com> <54BD8036.5070405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id F171D260434
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 10:54:01 +0100 (CET)
In-Reply-To: <54BD8036.5070405@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/19/2015 10:07 PM, Pierre-Louis Bossart wrote:
> On 1/19/15 11:23 AM, Qais Yousef wrote:
>> On 01/16/2015 04:50 PM, Pierre-Louis Bossart wrote:
>>>
>>> Since there is no allowed processing/reformatting/reshuffling of
>>> compressed data, all the plugin system needs to be bypassed and you'd
>>> be looking at an alsa-lib API that interfaces directly with the
>>> ioctls, essentially replicating what tinycompress does. I agree it's
>>> not great to have independent packages, the decision to maintain
>>> tinycompress separately was driven by licensing concerns, not
>>> technical ones.
>>> -Pierre
>>>
>>
>> I'm not sure how dual licensing work. Is it ok to base alsa-lib support
>> for compress API on tinycompress then?
>
> no idea, and what is the objective really? it's not clear what you are 
> trying to achieve and what would be the merits of enhancing alsa-lib 
> with compressed audio support?
> -Pierre
>

Long story short, I am writing a new ALSA driver that supports compress 
offload. The only user land support I could find is in tinycompress. I 
was looking at adding gstreamer support to facilitate my testing and 
hopefully make the driver more useful.

I am happy to use tinycompress if that's the official way alsa wants to 
support userland applications. When Takashi suggested that he didn't get 
patches for compress API support in alsa-lib I thought it was a hint 
it's a better idea to have it there. I think it makes sense to merge 
tinycompress into alsa-lib as this will make the functionality more 
readily available - if license is not an issue.
