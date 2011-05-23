From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: GR-55 Driver
Date: Mon, 23 May 2011 17:01:58 +0100
Message-ID: <201105231701.59052.maillist@superlative.org>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTinmnzEpRspYb74edaH1q8NPqXZg5w@mail.gmail.com>
	<1305839384.4443.41.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D130124334
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 18:02:02 +0200 (CEST)
Received: by wyg36 with SMTP id 36so4845552wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 09:02:02 -0700 (PDT)
In-Reply-To: <1305839384.4443.41.camel@TrinaryDragon>
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
Cc: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 19 May 2011 22:09:44 Jeffrey Scott Flesher Gmail wrote:
> Please take a second look at this information:
> 
> I do not see evidence that this driver patch is working as it should;

I'm tempted to agree from the info on the thread.

> 
> Lets step back and look at this with Fresh eyes:
> 
> This is the Roland GR-55 Guitar Synthesizer
> http://www.rolandus.com/products/productdetails.php?ProductId=1148
> 
> You based this driver patch on the
> 
> BOSS JS-8
> http://www.bossus.com/gear/productdetails.php?ProductId=1027
> 
> Instead of the GT-10; which seems more similar, but I do not know
> anything about the difference in drivers, nor do I know that you have a
> working driver for the GT-10, or that its based on the JS-8.

I would say not. I "developed" (rather a grand term for the little I actually 
did) the quirks for the JS-8 just recently.

 I'm not sure where the GT-10 came from, but it's not derived from the JS-8. 
In fact my memory on this is poor (and I had some pointers from this mailing 
list) so the JS-8 may have been derived from the GT-10 at least in part, 
rather than the other way around

So with this, and also with the benefit of knowing what the JS-8, GT-10 and 
GR-55 are, I would agree the JS-8 probably isn't the right starting point for 
this.


> As such, all I can do is go along and see if I can get this to work; so
> humor me, and lets see about basing this on the GT-10 and see how that
> works; from what I read; they might be based on the same chip set;

On the other hand, the quirk entries for GT-10 and JS-8 are very close to 
being identical. I wonder if the GR-55 needs some specific .data like the GT-10 
does. It may be worth taking the GT-10 entry and changing it for the GR-55 
vid/pid and trying it.

Unfortunately, much as I would love a GR-55 to play with, I can't really 
justify getting one to experiment with drivers on, otherwise I would love to 
tinker with trying to get this going.

Cheers,

-- 
Keith A. Milner
