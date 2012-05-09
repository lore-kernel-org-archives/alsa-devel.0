From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Tue, 08 May 2012 21:11:48 -0400
Message-ID: <4FA9C454.7060201@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
	<CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
	<4FA36114.2030305@rauros.net>
	<CAFz=ag5iwFf7DtfE8sucZWSNq14DZM7enwER5m_M=9=9Do9J7w@mail.gmail.com>
	<4FA45B69.5010608@rauros.net>
	<CAFz=ag4ST+StciziAjTyLs5E+kLedULYSceuABV0d1uL+hHeRA@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by alsa0.perex.cz (Postfix) with ESMTP id 83B0A243F4
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 03:12:31 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M3Q00ECUDZQI5H5@vms173001.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Tue, 08 May 2012 20:11:55 -0500 (CDT)
In-reply-to: <CAFz=ag4ST+StciziAjTyLs5E+kLedULYSceuABV0d1uL+hHeRA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I do not get that message anymore.

Fixing the "return 0" back to "break" results in the device not even 
registering, back to the -5 error from the beginning of this thread.

I'll capture more and get back to you.

The following derails the thread a bit:

As far as switching devices, I'm open. Due to a bug with a PCIE-PCI 
bridge on my mainboard, I cannot use any PCI devices (I've got a Delta44 
collecting dust). I really just want to find a single device, USB or 
Firewire (or PCIE), which works flawlessly in both Windows and Linux. 
Instrument/Mic input as well as independent balanced out and headphones.

Any thoughts on this?

On 5/5/2012 3:05 AM, Felix Homann wrote:
> Hi again,
>
> 2012/5/5 Chris Cavey<chris-alsa@rauros.net>:
>> No change.
>
> Hmm, do you still get this message:
>
>     ALSA mixer.c:352 cannot get ctl value: req = 0x83, wValue = 0x101,
> wIndex = 0x4001, type = 4
>     ALSA mixer.c:877 64:1: cannot get min/max values for control 1 (id 64)
>
> If so, can you please look at mixer.c 352 if line 352 corresponds to
> get_ctl_value_v2? (My line numbers are a bit off compared to yours it
> seems). Can you send some Ci lines from usbmon from before the
> mesasage appears.
>
>
>>   According to usbmon looks like no matter what channel I adjust,
>> the clock ctl is always being adjusted as if the wrong wIndex gets selected.
>> The clock wIndex is 0x8001 but the mixer volume is 0x4001. The wValue looks
>> correct (first mixer, according to my docs, should be 0x0100).
>
> That's strange. Can you try if your "return 0" instead of "break" in
> the device parsing is still needed now that we have a mixer quirk?
> (Just a blind guess...)
>
>
>> I'm going to
>> trace down the rabbit hole to learn how wValue/wIndex is derived from the
>> mixer controls.
>
> Just compare with the FTUs controls.
>
>>
>> I'll keep tinkering. At some point I should probably just buy you a C400,
>> probably easier.
>
> Have you thought about switching to a MOTU or RME device? Maybe we
> should work on these ;-)
>
> Kind regards,
>
> Felix
