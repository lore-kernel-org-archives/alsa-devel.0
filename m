From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Tue, 10 May 2016 11:18:03 +0800
Message-ID: <573152EB.5090906@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk> <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk> <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk> <572FFCA7.8030604@nuvoton.com>
 <20160509163528.GD3458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAFA12651D3
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 05:18:09 +0200 (CEST)
In-Reply-To: <20160509163528.GD3458@sirena.org.uk>
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

On 5/10/2016 12:35 AM, Mark Brown wrote:
> On Mon, May 09, 2016 at 10:57:43AM +0800, John Hsu wrote:
>   
>> On 5/7/2016 2:18 AM, Mark Brown wrote:
>>     
>
>   
>>> I'm not sure I fully follow the above explanation.  I appreciate that
>>> power consumption is not going to be optimal when the clock is provided
>>> and the chip is idle but does it actually stop anything working?
>>>       
>
>   
>> The conditional check for the situation is limited. Only when jack dis-
>> connect, the clock id just will be restricted. Do you think it is better
>> to control by machine driver and codec driver not to add any restriction?
>>     
>
> Well, the machine driver has to cope anyway.  What's not clear to me is
> if the device *has* to use the internal clock when doing accessory
> detection or if it's just lower power.
>
>   
If the codec only does accessory insertion detection, the driver can setup
it and doesn't need any clock. That can make lower power. But if the codec
wants to do advanced jack detection like mic or impedance, the driver needs
the internal clock to setup auto detection. Thus, when no headset connected
yet, we use the solution without internal clock for power saving. When we
want to do advanced detection, we use the solution with internal clock.

>>> I don't see how the probe function can handle the fact that the resume
>>> function is unconditionally calling enable_irq()?
>>>       
>
>   
>> Maybe I'm not very clear about what the probe function means. Could you
>>     
>
> The probe function is the function that runs on device probe, usually
> with probe() in the name.  The relevant one here is nau8825_i2c_probe().
>
>   

I see. Thank you.

>> tell me more detail? The codec resumption recovers the interruption func-
>> tion because the function turns off when suspension. The interruption is
>> managed in resume setup function after resumption. The driver will enable
>> the insertion and ejection interruptions here. Let the codec to detect the
>> event and do report instead of manual check the jack status.
>>     
>
> There may not *be* an interrupt.
>   

For the condition, the driver makes setup to detect insertion or ejection
only, and triggers detection manually. The codec can detect the accessory
status and send the interruption out.
