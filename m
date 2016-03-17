From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: add crosstalk suppression
	feature
Date: Thu, 17 Mar 2016 12:17:27 +0800
Message-ID: <56EA2FD7.2020209@nuvoton.com>
References: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
 <20160209183944.GL13270@sirena.org.uk> <56D380EC.6070302@nuvoton.com>
 <20160302043130.GB18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BAB4261564
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 05:17:37 +0100 (CET)
In-Reply-To: <20160302043130.GB18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On 3/2/2016 12:31 PM, Mark Brown wrote:
> On Mon, Feb 29, 2016 at 07:21:16AM +0800, John Hsu wrote:
>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>
>   
>> On 2/10/2016 2:39 AM, Mark Brown wrote:
>>     
>>> On Fri, Feb 05, 2016 at 01:52:46PM +0800, John Hsu wrote:
>>>       
>
>   
>>>> +static u32 nau8825_intlog10_dec3(u32 value)
>>>>         
>
>   
>>> This doesn't look driver specific, it should go somewhere generic
>>> (though I can't immediately see any relevant place for it...).
>>>       
>
>   
>> Do you have any advise what we can do? It's possible to move these functions
>> to other files, isn't it?
>>     
>
> Propose a maths helper library?
>   

I have no idea where to locate the logarithm function. The function was 
writen
in reference to dvb-math which provides some math functions for other dvb
driver to use. But I'm not sure the math is common for audio.

>   
>> It has to enable DAC and ADC path for detection and measurement. A little
>> like simple playback and record.
>> Indeed, it spent some time to finish the whole sequence and the situation
>> you mention will happen possibly.
>> Do we can add some mutex in driver to avoid something like race condition
>> happened? Could you give us suggenstion? Very thanks.
>>     
>
> Take a look at the da7219 driver, it is doing something similar.
>   

Now, we suffer an issue that the detection will interfere DAPM and clock
control when they start at the same time. I thought it's hard to protect
playback start sequence because audio hardware parameter and
preparation are independent operations from user application.
Is it better to let user application control it with kcontrol?
