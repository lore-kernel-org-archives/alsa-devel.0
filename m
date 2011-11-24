From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Thu, 24 Nov 2011 11:30:00 +0100
Message-ID: <jal6b9$mdi$1@dough.gmane.org>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<jal29f$6dt$1@dough.gmane.org> <jal4os$vs9$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 16AE9244DE
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:30:20 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RTWZM-00084t-8z
	for alsa-devel@alsa-project.org; Thu, 24 Nov 2011 11:30:16 +0100
Received: from 217-162-57-177.dynamic.hispeed.ch ([217.162.57.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:30:16 +0100
Received: from belegdol by 217-162-57-177.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:30:16 +0100
In-Reply-To: <jal4os$vs9$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W dniu 2011-11-24 11:03, Julian Sikorski pisze:
> W dniu 24.11.2011 10:20, Julian Sikorski pisze:
>> W dniu 20.08.2011 09:33, Andrew Mahone pisze:
>>> This laptop is detected as ALC892 audio (and by the codec ID this
>>> seems to be valid), but none of the configurations for it quite match
>>> this device. I've been working on documenting the connections with HDA
>>> Analyzer.
>>>
>>> alsa-info output:
>>> http://www.alsa-project.org/db/?f=b86e4c6447867fbd129a36d8a63e2f5caa836c52
>>>
>>> The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.
>>>
>>> DAC NIDs:
>>> 0x02 front
>>> 0x03 rear
>>> 0x04 clfe
>>> 0x05 side
>>>
>>> internal mixers:
>>> 0x0c front
>>> 0x0d rear
>>> 0x0e clfe
>>> 0x0f side
>>>
>>> internal speaker pins:
>>> 0x14 front
>>> 0x15 "rear" (front of laptop)
>>> 0x16 clfe
>>>
>>> external ports:
>>> fixed route:
>>> 0x17 side
>>>
>>> can select any output:
>>> 0x18 mic / output
>>> 0x1a line-in / output
>>> 0x1b headphone
>>>
>>> I've been experimenting with patch_realtek.c to add the extra DAC NID,
>>> and have had some success with a 6-channel mode for the built-in
>>> speakers and an 8-channel mode that mutes all internal speakers and
>>> sets the jacks up for output. I still need to manually connect pins
>>> 0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
>>> headphone plugin does not mute internal speakers in 5.1 mode. I have
>>> not added a plain stereo mode for internal speakers, although it
>>> appears that i can probably configure the codec to mix the front
>>> channels to center and LFE.
>>>
>>> Are there any suggestions for what to do next? My current state as a
>>> patch against the linux-3.0.y repository is at
>>> http://pastie.org/2400649
>>>
>> I tried this patch (attached a version ported to 3.1.x kernel) with
>> P150HM and I was still unable to get sound out of the subwoofer when on
>> 6 channel mode, could nonexisting rear be interfering?
>
> I tried a similar patch but also no luck there... Any ideas why the
> subwoofer might not be working? Is there a way to somehow eavesdrop the
> windows driver?

I am starting to be really convinced that THX TruStudio PRO is doing 
some shenanigans, since its "Speaker" function needs to be active for 
the subwoofer to work, even in realtek HD Audio Manager Speaker test. It 
will work if the function is dialled down all the way to 0 %, but as 
soon as you turn it off nothing can be heard.
Do you guys have any ideas what it might be doing. and is there a way to 
emulate this function under linux?

>> As Andrew said, 8 channel mode works once you manually unmute and
>> reattach mixers using hda-analyzer.
>>
>> Regards,
>> Julian
>>
>>
>>
>
>
>
