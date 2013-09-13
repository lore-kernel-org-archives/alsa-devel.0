From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: USB Audio initialization race
Date: Fri, 13 Sep 2013 16:53:06 -0400
Message-ID: <52337B32.4080304@canonical.com>
References: <Pine.LNX.4.44L0.1309131636250.1542-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C56362619ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 22:53:08 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1309131636250.1542-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

2013-09-13 16:39, Alan Stern skrev:
> On Fri, 13 Sep 2013, David Henningsson wrote:
>
>> I'm sometimes seeing that USB audio devices are not initialized
>> correctly by PulseAudio, but I can't reproduce this myself.
>>
>> I have, however, spotted what I think is a race condition in the driver
>> code, if a device has more than one interface. snd_card_register is
>> called once for every interface, which means that it will be shown to
>> userspace after the first interface has been probed. So the race could
>> look like:
>>
>> 1) The first interface is probed, which might contain the mixer controls
>> 2) snd_card_register is called, which sends a signal to userspace
>> 3) PulseAudio probes the device and notices that it has no PCMs, so it
>> ignores the device
>> 4) The second interface is probed, which adds the PCMs
>> 5) snd_card_register is again called, which is a no-op since the card
>> already exist
>> 6) User is unhappy because his plugged in sound card did not show up in
>> PulseAudio.
>>
>> So, assuming all this is right, it seems like we need some type of
>> callback from the usb driver when all the interfaces for the sound card
>> has been probed, so we can call snd_card_register at that point instead.
>> Thoughts?
> The driver probably doesn't know when all the interfaces have been
> probed.
I'm unsure if you mean "the usb driver" or "the usb audio driver" in the 
sentence above, but the USB driver would enumerate all interfaces and 
call the usb audio driver for every interface, and so the USB driver 
would know when all the interfaces have been probed, right?

Is there a way the USB audio driver can subscribe, or get an additional 
callback of some sort, when that happens?

> Maybe it would be better to send a signal to userspace each
> time snd_card_register is called, even if nothing is done.

That sounds very suboptimal, given that PulseAudio's probing mechanism 
can be quite heavy (depending on the device).
>
> Alternatively, when the first interface is probed, the driver could
> claim all the other interfaces belonging to the same association.
Not sure how well that would work out with "composite" devices, e g 
headset with volume up/down buttons?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
