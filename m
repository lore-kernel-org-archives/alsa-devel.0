From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/2] ASoC: Add support for the Allwinner A10 codec
Date: Tue, 29 Sep 2015 23:13:56 +0200
Message-ID: <560AFF14.80400@redhat.com>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442928417.6509.12.camel@plaes.org> <20150928074248.GI7104@lukather>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBG76VOYAKGQETJULV4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150928074248.GI7104@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 09/28/2015 09:42 AM, Maxime Ripard wrote:
> Hi Priit,
>
> On Tue, Sep 22, 2015 at 04:26:57PM +0300, Priit Laes wrote:
>> On Sat, 2015-09-12 at 15:26 +0200, Maxime Ripard wrote:
>>> Hi everyone,
>>>
>>> This patch set adds the support for what Allwinner calls the codec on
>>> their SoCs.
>>>
>>> This codec is actually a combination of a codec and DAI, tied
>>> together
>>> in a single memory-mapped IP. It is completely standalone, and
>>> outputs
>>> directly the analog signal.
>>>
>>> While it supports both playback and capture, the capture is not
>>> implemented in this patch, and will be posted eventually as a
>>> separate
>>> one.
>>>
>>> This set, in order to be functional, has a dependency on the audio
>>> clocks patch set posted separately. However, it doesn't needs this to
>>> compile properly, so I guess it can be merged without really caring
>>> for the merging status of the clock patches.
>>
>> It works on Gemei G9 tablet which has also extra chip that
>> automatically switches output over from internal speakers to headphones
>> when connector is inserted.
>>
>> Now I noticed some weird things:
>>
>> When I have all the switches as ON in alsamixer, and I start disabling
>> them, I get following weird results.
>>
>> Left Mixer Left - LML
>> Right Mixer Left - LMR
>> Right Mixer Right - RMR
>>
>> Very faint output:
>> LML - ON
>> RML - Mute
>> RMR - ON
>>
>> Output works fully:
>> LML - Mute
>> RML - Mute
>> RMR - Mute
>>
>> When I Mute Pre-Amplifier and fiddle any of LML, RML or RMR, the output
>> stays mute even after setting Pre-Amplifier Mute back on:
>>
>> 1. All switches on
>> 2. Mute pre-amplifier
>> 3. Mute RMR
>> 4. Pre-Amilifier Mute Off
>> .. Music stays off
>> 5. Toggle Pre-Amplifier twice - output turns on
>
> Unfortunately, I don't have access to that SoC or that setup.

I'm seeing similar stuff on a cubieboard, both A10 and A20
based cubieboards, I have to fiddle a bit with the switches
to get things to work. At boot all switches are disabled.

On both A10 and A20 I need to enable to following for things to work:

unmute Pre-Amplifier DAC
unmute Pre-Amplifier Mute

I guess this is just a question if adding some mixer defaults to
the alsa userspace somewhere ?

Regards,

Hans
