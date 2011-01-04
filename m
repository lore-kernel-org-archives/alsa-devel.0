From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: VIA VT1708 bugs
Date: Tue, 04 Jan 2011 10:21:34 +0100
Message-ID: <4D22E69E.1000101@canonical.com>
References: <4D22C24A.1080302@canonical.com>
	<AANLkTik8uKj97GOOOtPuftePUDcs01nP8aAHsOtAmiZE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C1BBF1038ED
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 10:21:36 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1Pa35C-0001KO-CB
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 09:21:34 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1Pa35C-0005rR-8y
	for alsa-devel@alsa-project.org; Tue, 04 Jan 2011 09:21:34 +0000
In-Reply-To: <AANLkTik8uKj97GOOOtPuftePUDcs01nP8aAHsOtAmiZE@mail.gmail.com>
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

On 2011-01-04 08:43, Raymond Yau wrote:
> 2011/1/4 David Henningsson<david.henningsson@canonical.com>
>
>> Hi,
>>
>> the state of VIA VT1708 in the current kernel is far from optimal. It
>> would be good to improve the situation, at least for 2.6.38. On the
>> machine here, I experience at least these bugs:
>> 3) Several users report headphones output being broken
>>
>> * Symptoms vary a little and some might be due to bug 2), but some
>> however report the headphones volume being "grayed out" in alsamixer. I
>> haven't seen that in particular on the hardware here.
>>
>> 4) All these extra controls - "Independent HP", "Jack Detect", "Smart 5.1"
>>
>
> Independent headphone
>
> http://www.viaarena.com/forums/showthread.php?t=41015

Ok, that makes some sense. It translates to me as
* With independent HP turned off - activates auto-mute between 
speaker-out/line-out and headphone out. Note the difference between VIA 
and Realtek/Sigmatel here as line-out are auto-muted as well.

* With independent HP turned on - headphone out and speaker-out/line-out 
should take output from different PCM subdevices.

> "Smart 5.1"  similar to switch "channel mode" from 2 to 6 in intedl
> desktop motherboard with 3 audio jacks in rear panel

But does turning "Smart 5.1" on, mean that mic-in and line-in are always 
turned into C/LFE and Back L/R jacks, or is it trying to do some kind of 
autodetection of the current thing plugged in?

Also, it is not obvious to me how "Jack detect" comes into this equation 
and how they affect the two parameters above...?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
