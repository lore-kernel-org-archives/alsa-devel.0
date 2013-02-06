From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Wed, 06 Feb 2013 21:20:44 +0100
Message-ID: <5112BB1C.8090105@gmail.com>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B48F526086D
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 21:20:56 +0100 (CET)
Received: by mail-bk0-f46.google.com with SMTP id j5so852443bkw.19
 for <alsa-devel@alsa-project.org>; Wed, 06 Feb 2013 12:20:56 -0800 (PST)
In-Reply-To: <5112B969.50905@ladisch.de>
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
Cc: Eldad Zack <eldad@fogrefinery.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.02.2013 21:13, Clemens Ladisch wrote:
> Eldad Zack wrote:
>> On Tue, 5 Feb 2013, Clemens Ladisch wrote:
>>> I thought I'd try to use implicit feedback with my simple audio device:
>>> [...]
>>> This works fine when playing something:
>> ...
>>> But when I then try to record at the same time, the driver refuses to
>>> configure the input endpoint (to the only format, which is already set):
>>> And despite that "alreay in use" check, the input endpoint is affected
>>> so much that playback breaks.
>>>
>>> Is full duplex supposed to work?  Does it work with other devices?
>>
>> This is probably a "yes, but" :)
>> I use my device mostly full duplex, but with jack opening both
>> playback and capture at the same time.
>>
>> I assume you are opening two different streams, one for playback and
>> one for capture.
> 
> Jack *also* uses two different streams, but it opens them at the same
> time.
> 
>> Can you try using jackd -d alsa -d hw:x with the device and see if that
>> works for you?
> 
> That works.  This means that there is a race condition in the driver, or
> that the different open/hw_params/prepare order trips it up.

I'll look for the FTU and re-try this with Eldad's latest additions once
I find some time. If there are races, we should definitely fix them.

> Anyway, I feel safe now to enable implicit feedback for other devices.

Nice.

On a general note, my idea from the beginning and part of the motivation
to split the driver into the snd_usb_endpoint logic was to pull that
class out to a separate library, so we can use it from other drivers as
well. Much like what snd-usbmidi does.

There are few bits to clean up in order to remove dependencies between
the endpoint code and the rest of the driver, but then your ua101
driver, snd-usb-caiaq and probably some more drivers in the future can
share the generic streaming functionality.


Daniel
