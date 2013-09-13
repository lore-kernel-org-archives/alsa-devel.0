From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio initialization race
Date: Fri, 13 Sep 2013 22:55:43 +0200
Message-ID: <52337BCF.8040602@ladisch.de>
References: <Pine.LNX.4.44L0.1309131636250.1542-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 486FA2619ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 22:56:32 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
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
>
> The driver probably doesn't know when all the interfaces have been
> probed.  Maybe it would be better to send a signal to userspace each
> time snd_card_register is called, even if nothing is done.

New devices will result in a signal because they result in new device
nodes.

> Alternatively, when the first interface is probed, the driver could
> claim all the other interfaces belonging to the same association.

The driver already does this.


Regards,
Clemens
