From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v6] MIDI driver for Behringer BCD2000 USB
 device
Date: Mon, 24 Feb 2014 21:39:11 +0100
Message-ID: <530BADEF.5040806@ladisch.de>
References: <1392909089-6242-1-git-send-email-dev@kicherer.org>
 <530A58F6.7030700@ladisch.de> <530BA60E.9000408@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A54FA261ADC
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:39:42 +0100 (CET)
In-Reply-To: <530BA60E.9000408@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mario Kicherer wrote:
> On 23.02.2014 21:24, Clemens Ladisch wrote:
>>> +static void bcd2000_input_complete(struct urb *urb)
>>> +{
>>> +    if (urb->status) {
>>> +        dev_warn(dev, PREFIX "input urb->status: %i\n", urb->status);
>>> +        return;
>>> +    }
>>
>> This will stop the input even on transient errors.
>
> Hm, so, it is important to send the "acknowledge" urb afterwards
> nonetheless?

This has nothing to do with acknowledging.  Once the completion callback
was called, the URB is again owned by your driver, and nothing happens
unless you submit it again.

The only reason not to re-submit the URB is a permanent error (i.e., if
the device has been unplugged).

> Do you actually own a BCD2000?

Yes.


Regards,
Clemens
