From: Jarek <jarek@poczta.srv.pl>
Subject: Re: Alsa soc UDA1380 - no duplex
Date: Thu, 05 Apr 2012 19:46:51 +0200
Message-ID: <1333648011.2480.3.camel@tower.local>
References: <1333445641.7330.59.camel@jlap2.macro.local>
	<CA+E=qVfpt-m73SaTE92ASNNLVwE+Q0DNYC-2Z8v26CZ=Ukpp_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.srv.pl (mail.srv.pl [217.17.32.250])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB9910402A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 19:47:11 +0200 (CEST)
In-Reply-To: <CA+E=qVfpt-m73SaTE92ASNNLVwE+Q0DNYC-2Z8v26CZ=Ukpp_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dnia 2012-04-03, wto o godzinie 18:09 +0300, Vasily Khoruzhick pisze:

> Probably it's lpc313x limitation (CPU DAI does not support duplex?)

Do you know how to check if this is hardware limitation ? I have
reviewed documentation and from my point of view it should work.
http://ics.nxp.com/products/lpc3000/datasheet/lpc3130.lpc3131.pdf

> Anyway, looks like its code is not upstreamed.

Yes, I didn't notice before, that all code comes from this patch (for
kernel 3.2):

http://www.lpclinux.com/pub/Forums/ForumLPC313x0055/lpc.tar.gz 
> 
> >        The other question is why there are two drivers to the same device.
> 
> AFAIK there's only one driver for uda1380 codec.

I've found separete folders for samsung and lpc in sound/soc/ and I
suspected that there are two separate drivers. As I understand now,
there is only separate intermediary layer. The files in those folders
are quite different, so I don't know how to compare them, to find the
difference.
In mean time. I have received the following respone from lpclinux:
=====
As I understand,it is the SW limitation limitation because of which we
can not use playback & capture feature simultaneously. The audio driver
code is based on ALSA framework available in sound/soc/lpc313x. Please
give it a try & let us know about the results
=====
I'll be glad, if can take a look at this code.
or just give me some direction 
