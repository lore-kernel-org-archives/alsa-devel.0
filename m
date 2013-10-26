From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: include/uapi/firewire.h for other firewire drivers
Date: Sat, 26 Oct 2013 14:16:07 +0900
Message-ID: <526B5017.8010106@sakamocchi.jp>
References: <526A6092.4030709@sakamocchi.jp> <526A6C50.2000901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id C78C72654CA
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 07:16:13 +0200 (CEST)
In-Reply-To: <526A6C50.2000901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

 > Because every device can have settings that should not be changed
 > while streaming.

For this, I have a further question.

Currently my Fireworks/BeBoB driver give Control interfaces for these 
settings, like changing sampling rate, switching digital interface. The 
primarry purpose of these is the same, a prevention from stopping 
streaming. The secondary purpose is debug codes for these functionality.

But based on firewire.h interface, it is the applications' 
responsibility, not drivers'. Is my understanding correct?

Here some devices has "write-only" settings. For such device, my driver 
remember these settings. If the applications has such responsibility, 
there may be some inconsistency.


Thanks

Takashi Sakamoto


(Oct 25 2013 22:04), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> About include/uapi/firewire.h, I'd like you to give me an advice.
>>
>> I'm sorry but I have little knowledgement about Dice chipset. So here
>> I want to know what I should do for snd-fireworks/snd-bebob.
>
> The primary purpose is to support control panel/mixer applications,
> which should be able to find out which ALSA device corresponds to which
> FireWire device.
>
>> The header file includes an interface  for users to know its already
>> streaming or not, and lock it.
>
> Because every device can have settings that should not be changed while
> streaming.
>
>> But for Fireworks/BeBoB, I think checking CMP connections do the same
>> thing.
>
> When a control panel wants to change several settings, it should not
> need to establish a CMP connection just to be able to prevent the driver
> from starting streaming at the same time.
>
>> Current FFADO can be failed when CMP connections on the device are
>> established, and ALSA can do the same. (but there are some problems.
>> both drivers set sampling rate before checking CMP connections. For this
>> I have a plan to post a patch for both FFADO and ALSA.)
>
> This lock is not intended to prevent ALSA/FFADO conflicts.
>
> At the moment, snd-dice and FFADO do not attach to the same devices.
> When this is possible, the kernel FireWire framework should be extended
> to allow the driver to prevent FFADO from using the device.  However, it
> would be hard for the kernel to differentiate between FFADO and some
> control panel, so I guess FFADO should be changed to not attach to
> a device that already has a kernel driver.
>
>> Should I implement the same lock for Fireworks/BeBoB drivers?
>
> Yes.
>
> For Fireworks devices, applications will need to send EFC commands, but
> will not be able to allocate the same 0xecc080000000 address, so the
> driver needs a SEND_EFC ioctl.  (That's the same reason why snd-dice has
> DICE_NOTIFICATION.)
>
>
> Regards,
> Clemens
