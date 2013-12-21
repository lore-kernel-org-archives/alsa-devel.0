From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [FFADO-devel] Sample program for hwdep interface
Date: Sat, 21 Dec 2013 14:48:25 +0100
Message-ID: <52B59C29.70900@ladisch.de>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>	<52B45837.2080804@sakamocchi.jp>
 <20131221101123.GA17855@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 42FB0262632
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 14:48:35 +0100 (CET)
In-Reply-To: <20131221101123.GA17855@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> On Fri, Dec 20, 2013 at 11:46:15PM +0900, Takashi Sakamoto wrote:
>> This is how to use hwdep interface for firewire devices.
>> I hope FFADO developers read this.
>>
>> With hwdep interface, the program in user land can do:
>> 1.get firewire node infomation
>> 2.get notification when starting/stopping kernel streaming
>> 3.lock/unlock kernel streaming
>
> 1 could be useful.  2 and 3, while not essential, are nice to have.

If a device has some settings that must not be changed while streaming
is active, the mixer application must take the lock before attempting
to change them.  The lock notification is needed for disabling/enabling
those control widgets.

> ... for FFADO to determine whether there's kernel streaming support
> for the device in question

This could be done either by enumerating ALSA hwdep devices, or by
looking in sysfs whether the device has any attached driver.

>> And with snd-fireworks, the program can do:
>> 4.transmit command of EFW transaction
>> 5.receive response of EFW transaction
>>
>> 4/5 is my complete solution for ticket #360.

I.e., sending commands not through FCP, but with the vendor-specific
addresses 0xecc000000000 (device) and 0xecc080000000 (PC).

> I thought this ticket was more or less resolved.  How exactly does this
> program deal with ticket #360?  This ticket requires fixes within FFADO's
> mixer/control code (or so I thought).

Yes, FFADO must allocate the reply address range.

But _if_ the kernel driver and FFADO are both running, FFADO must go
through the driver because the address range is already allocated.


Regards,
Clemens
