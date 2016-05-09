From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 9 May 2016 10:57:43 +0800
Message-ID: <572FFCA7.8030604@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk> <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk> <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C0930260670
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 04:57:46 +0200 (CEST)
In-Reply-To: <20160506181855.GZ6292@sirena.org.uk>
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

On 5/7/2016 2:18 AM, Mark Brown wrote:
> On Fri, May 06, 2016 at 03:41:42PM +0800, John Hsu wrote:
>   
>> On 5/5/2016 12:39 AM, Mark Brown wrote:
>>     
>>> On Tue, May 03, 2016 at 05:20:00PM +0800, John Hsu wrote:
>>>       
>
>   
>>>> For clear expression, we should print error message and return error to
>>>> caller. Is it right?
>>>>         
>
>   
>>> It'd be better to just accept the configuration but what you suggest is
>>> less bad than just completely ignoring the problem.
>>>       
>
>   
>> The codec needs internal clock for interruption at auto mode. Therefor, the
>> system clock will go back to internal clock after playback to end. But we
>> don't want this happened when jack is ejected already. We expected no in-
>> ternal clock when no headset connected; but the system will turn on it when
>> playback finish. For the reason, the driver adds error check to avoid this
>> situation happened.
>>     
>
> I'm not sure I fully follow the above explanation.  I appreciate that
> power consumption is not going to be optimal when the clock is provided
> and the chip is idle but does it actually stop anything working?
>
>   

The conditional check for the situation is limited. Only when jack dis-
connect, the clock id just will be restricted. Do you think it is better
to control by machine driver and codec driver not to add any restriction?

>>> This does not address the issue at all.  The interrupt is optional, it
>>> may not have been wired up and the probe function handles that case
>>> gracefully.
>>>       
>
>   
>> The ejection interruption will turn on when resume for the issue. Let the
>> probe function to handle it.
>>     
>
> I don't see how the probe function can handle the fact that the resume
> function is unconditionally calling enable_irq()?
>   

Maybe I'm not very clear about what the probe function means. Could you
tell me more detail? The codec resumption recovers the interruption func-
tion because the function turns off when suspension. The interruption is
managed in resume setup function after resumption. The driver will enable
the insertion and ejection interruptions here. Let the codec to detect the
event and do report instead of manual check the jack status.
