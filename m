From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Fri, 6 May 2016 15:41:42 +0800
Message-ID: <572C4AB6.9030106@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk> <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F6FE265342
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 09:41:47 +0200 (CEST)
In-Reply-To: <20160504163943.GZ6292@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 5/5/2016 12:39 AM, Mark Brown wrote:
> On Tue, May 03, 2016 at 05:20:00PM +0800, John Hsu wrote:
>   
>> On 5/3/2016 12:27 AM, Mark Brown wrote:
>>     
>>> On Fri, Apr 29, 2016 at 04:15:17PM +0800, John Hsu wrote:
>>>       
>
>   
>>>> +	/* Mask all interruptions except jack insertion interruption */
>>>> +	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0xfffe);
>>>>         
>
>   
>>> So if any other interrupts occur then things will break...
>>>       
>
>   
>> The codec only has headset output and its function works when headset is
>> connected. When headset is not connected, the driver only permit insertion
>> interruption to happen. After insertion, the internal clock of codec turns
>> on and all other interruptions just will be enabled. Without clock, the
>> codec can detect jack insertion only.
>>     
>
> People do surprising things with devices - they may not wire up the
> headphone detection for some reason, or may connect some external
> circuit.
>
>   

I see. Thanks for your reminder. I'll enable insertion interruption but
disable ejection interruption here when headset ejection.

>>> This is ignoring the attempt to set up a clock but returning success
>>> which is going to break things, printing the warning is dubious (a
>>> system could be built without detection for example, or a speaker driver
>>> connected) but probably OK in itself but the fact that we don't tell the
>>> caller may make things worse.
>>>       
>
>   
>> For clear expression, we should print error message and return error to
>> caller. Is it right?
>>     
>
> It'd be better to just accept the configuration but what you suggest is
> less bad than just completely ignoring the problem.
>
>   

The codec needs internal clock for interruption at auto mode. Therefor, the
system clock will go back to internal clock after playback to end. But we
don't want this happened when jack is ejected already. We expected no in-
ternal clock when no headset connected; but the system will turn on it when
playback finish. For the reason, the driver adds error check to avoid this
situation happened.


>>>> +		nau8825_eject_jack(nau8825);
>>>> +		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
>>>> +	}
>>>> +	enable_irq(nau8825->irq);
>>>>         
>
>   
>>> The interrupt is optional (that bug appears to be already present in the
>>> driver but should be fixed).
>>>       
>
>   
>> If headset ejection happened when system suspend. After resume, the codec
>> won't detect the change and no report to the kernel. The application does
>> not aware the device change and still outputs stream to the headset device.
>> For the issue, the driver has to notice the application of ejection ever
>> happened in suspend. Let the application to change its device correctly.
>>     
>
> This does not address the issue at all.  The interrupt is optional, it
> may not have been wired up and the probe function handles that case
> gracefully.
>   

The ejection interruption will turn on when resume for the issue. Let the
probe function to handle it.
