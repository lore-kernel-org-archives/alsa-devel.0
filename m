From: Daniel Mack <daniel@zonque.org>
Subject: Re: USB Implicit Feedback
Date: Sun, 07 Sep 2014 13:31:25 +0200
Message-ID: <540C420D.6000202@zonque.org>
References: <op.xlq6q9vfeorkce@apollo13> <540AF652.8080501@zonque.org>
 <op.xls10oxteorkce@apollo13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B466265122
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 13:31:27 +0200 (CEST)
In-Reply-To: <op.xls10oxteorkce@apollo13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre C <lists@peufeu.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 09/07/2014 09:06 AM, Pierre C wrote:
> - The Apple app notes seem to say it's the best way to do things, and I'd  
> like it to also work on Macs. But I'm not married to Apple, and it seems  
> Macs also support explicit feedback, so this isn't a very important point.

Explicit feedback is much more common than anything else, and I haven't
yet seen a standard compliant device with implicit feedback in the wild.
And more common means more test coverage :)

> - Implicit feedback would use one less IN endpoint, and that would be  
> useful.

Yes, but it will always cause traffic in both directions, even if only
one is actually used. Unless you're in full-duplex mode, you'll waste
50% of the bandwidth.

>> The usage mask of bmAttributes of the endpoint should be
>> USB_ENDPOINT_USAGE_IMPLICIT_FB, along with some other constraints. See
>> set_sync_endpoint() in sound/usb/pcm.c
> 
> I have read this source code before but I'm not sure what the second  
> parameter of "get_endpoint(alts, 1)" really means, does it imply that an
> altsetting has to have 2 endpoints and it takes the second one, but in  
> which order ? order of definition in descriptors, endpoint number ?...

That's the index of the endpoint in the given alt interface.

> But is it bmAttributes in the playback endpoint descriptor, or its buddy  
> capture endpoint ? The USB docs are quite vague and I see several possible  
> interpretations ... Does the playback AudioStreaming descriptor need to  
> have 1 endpoint, or 2 ?... I've tried various combinations with the latest  
> stable linux kernel, none worked.

It's been a while since I looked into this, but when I implemented the
code in the first place, I had no standard compliant device to test
with, so I had to force the driver into implicit mode with a quirk. I'd
recommend adding printk() to the driver and trace the calls and see how
they parse the descriptors.

But as I said - if explicit feedback mode already works for you, I'd
stick with it.


Best regards,
Daniel
