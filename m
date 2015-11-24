From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] ALSA: dice: constrain PCM
 substreams to current sampling transfer frequency
Date: Wed, 25 Nov 2015 00:04:22 +0900
Message-ID: <56547C76.6080607@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8qbe6pm.wl-tiwai@suse.de> <564D4360.8050503@sakamocchi.jp>
 <s5hziyab8ak.wl-tiwai@suse.de> <564E9D6C.7060408@sakamocchi.jp>
 <s5hy4dt9g5h.wl-tiwai@suse.de> <564F01D0.20603@sakamocchi.jp>
 <s5hegfk9aey.wl-tiwai@suse.de> <564FBAE4.9070203@sakamocchi.jp>
 <s5h7flbznvq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F102659C4
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 16:04:35 +0100 (CET)
In-Reply-To: <s5h7flbznvq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 21 2015 18:46, Takashi Iwai wrote:
> On Sat, 21 Nov 2015 01:29:24 +0100,
> Takashi Sakamoto wrote:
>>> In your original statement:
>>>> As a result, userspace applications can request PCM substreams at current
>>>> sampling transfer frequency. Therefore, when users want to start PCM
>>>> substreams at different rate, they should set the rate in advance by the
>>>> other ways (i.e. ffado-dbus-server/ffado-mixer).
>>>
>>> So, an application cannot change the PCM rate other than the value
>>> currently set by another tool.  Is it correct?
>>
>> Correct.
> 
> The single rate restriction is fairly common among many drivers.
> As this appears like a hardware limitation on DICE, it's fine, per se.
> But, requiring a special tool to set the sample rate is different; it
> sounds strange to me.
> 
> Why it must be *only* by another tool, not by PCM interface itself?
> Suppose you playing a single application.  Kernel driver also knows
> that it's currently only a single process accessing the hardware.
> What prevents it changing the sample rate? 
>
> And, even if we implement in that way -- allowing only the locked
> sample rate -- by some reason (e.g. due to the code complexity), why
> can't it be controlled via a more common interface like a normal mixer
> element or such?  Some drivers do so, simply by providing an enum
> control for the master sample rate.
> 
> So again: restricting the PCM per one rate itself is understandable.
> The main question is, however, how to manage the current sample rate.
> If the first-user-allowed rule is applied, there won't be a big
> regression, for example.

The first-user-allowed rule is also common in all of drivers in ALSA
firewire stack, so as ALSA dice module. The first process to access
hardware via ALSA PCM interface is dominant for deciding sampling
transfer frequency.


For ALSA firewire stack, we, at least I and Clemens, have an agreement
to implement driver functionality except for packet streaming in
userspace as much as possible. This is due to the consideration about
the difference of functionalities in models which applies the same
communication chipset. The much model-dependent codes increses codes in
kernel driver. And the codes make it hard to maintain it because they're
for model-dependent functionalities. Owners of the models has a
possibility to know mechanisms for the functionalities, while we don't
touch all of models and investigate them. Userspace is good in this case.

To the question about the tools except for ALSA PCM interface, I answer
that Dice framework doesn't allow drivers to get all of combinations for
PCM rate/channels. In this case, ALSA driver cannot have enough PCM
rules to tell all of the combinations and ALSA PCM applications cannot
decide to use which PCM rates or channels. This is not related to the
code complexity at all.

The reason not to use ALSA Control elements to change the state of clock
is that it can be achieved in userspace, so as FFADO does via fw
character devices. If ALSA dice driver had the ALSA Control elements,
application developers should use both of ALSA Control interface and
Linux FireWire character interface. The cost of the study becomes higher
than simply using Linux FireWire character interface. If I were the
developer, I might not use ALSA Control interface because what I want is
too simple to understand many APIs which alsa-lib produces.


Regards

Takashi Sakamoto
