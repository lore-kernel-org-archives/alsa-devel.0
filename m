From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Thu, 12 May 2016 11:54:54 +0800
Message-ID: <5733FE8E.1040104@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk> <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk> <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk> <572FFCA7.8030604@nuvoton.com>
 <20160509163528.GD3458@sirena.org.uk> <573152EB.5090906@nuvoton.com>
 <20160511171506.GQ6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18E6B2607C8
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 05:54:58 +0200 (CEST)
In-Reply-To: <20160511171506.GQ6261@sirena.org.uk>
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

On 5/12/2016 1:15 AM, Mark Brown wrote:
> On Tue, May 10, 2016 at 11:18:03AM +0800, John Hsu wrote:
>   
>> On 5/10/2016 12:35 AM, Mark Brown wrote:
>>     
>
>   
>>> Well, the machine driver has to cope anyway.  What's not clear to me is
>>> if the device *has* to use the internal clock when doing accessory
>>> detection or if it's just lower power.
>>>       
>
>   
>> If the codec only does accessory insertion detection, the driver can setup
>> it and doesn't need any clock. That can make lower power. But if the codec
>> wants to do advanced jack detection like mic or impedance, the driver needs
>> the internal clock to setup auto detection. Thus, when no headset connected
>> yet, we use the solution without internal clock for power saving. When we
>> want to do advanced detection, we use the solution with internal clock.
>>     
>
> I'm afraid this still leaves me none the wiser, sorry.  If this
> switching to the internal clock is essential to the device operation
> then I'd expect it to be made transparent to callers so it should
> happen transparently rather than appearing via set_sysclk().  If it's
> not and it's just a performance optimisation then erroring out is
> definitely excessive but if the optimisation can be implemented
> transparently then it might be nice to do that.
>   

In the driver patch, the internal clock switching is transparently
done by driver when the codec runs advanced jack detection. Our
purpose is to prevent the machine turns on the internal clock by
itself when no headset connected. That will not affect function
work but make more power consumption. Maybe we can change to clock
disabled quietly when the machine turns on the internal clock when
no headset connected. Is it the right way?
