From: Mario Kicherer <dev@kicherer.org>
Subject: Re: [PATCH v6] MIDI driver for Behringer BCD2000 USB
 device
Date: Mon, 24 Feb 2014 21:05:34 +0100
Message-ID: <530BA60E.9000408@kicherer.org>
References: <1392909089-6242-1-git-send-email-dev@kicherer.org>
 <530A58F6.7030700@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id D6E6F26527F
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:05:34 +0100 (CET)
In-Reply-To: <530A58F6.7030700@ladisch.de>
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

On 23.02.2014 21:24, Clemens Ladisch wrote:
> I wonder how much of this is the actual init sequence, and how much is
> random garbage.  :-)

Me too, but I want to make sure the module works before I start 
experimenting and risk modifying/damaging my device. Some bytes in
between stay the same, some seem to change randomly everytime I plug in
the device.

> The device often sends data as single-byte packets, so the structure
> actually is "length data...".

Yeah, it's a bit misleading here. I'll change this part.

>> +static void bcd2000_input_complete(struct urb *urb)
>> +{
>> +	if (urb->status) {
>> +		dev_warn(dev, PREFIX "input urb->status: %i\n", urb->status);
>> +		return;
>> +	}
>
> This will stop the input even on transient errors.

Hm, so, it is important to send the "acknowledge" urb afterwards
nonetheless?

> $ cat /proc/asound/cards
> ...
> 18 [bcd2000        ]: Behringer BCD200bcd2000 - bcd2000
>                        Behringer BCD2000, at usb-0000:00:13.1-3
>
> The driver name just identifies the driver, it does not need the vendor
> name.  (And it should not overflow its buffer.)
>
> The short name is shown to the user in many places, so it should be
> properly capitalized.
>
> The long name does not need the comma.

I removed the macros and just placed the names in there directly as
that's the only place they're used anyway.

Do you actually own a BCD2000?

>> +	dev_info(&bcd2k->dev->dev, PREFIX "%s", bcd2k->card->longname);
>
> What use does this message have in the log?

I saw this in another driver and thought this is common practice. I'll
remove it then.

Thank you for your comments!
Mario
