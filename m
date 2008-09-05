From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: are freebob firewire cards likely to be supported
	by alsa in the future?
Date: Fri, 5 Sep 2008 13:52:22 +0930 (CST)
Message-ID: <200809050422.m854MMAk010597@turbo.physics.adelaide.edu.au>
References: <mailman.1449.1220587355.2102.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E69D1037F1
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 06:22:25 +0200 (CEST)
In-Reply-To: <mailman.1449.1220587355.2102.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Sep 05, 2008 06:02:35 AM
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
Cc: andy@earthsong.free-online.co.uk, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andy

> Just wondering if there are any plans to develop alsa support for 
> firewire freebob cards like the M-Audio firewire solo (which I have). I 
> have this working fine under jackd using the freebob driver, but as far 
> as I know there isn't an alsa driver for it. I assume that since there 
> is already open source code to drive the chip, it should be possible to 
> write an alsa driver?

Yes, it would be possible.  However, doing so would require that almost
everything freebob/ffado currently does (which is a lot) would have to be
ported and/or reimplemented.  This doesn't seem like the best use of
anyone's time.

Instead, there are plans to write an alsa driver interface to libffado and
some preliminary work has been done, but there's no ETA on this at present. 
Currently our (ffado's) focus is on getting things working well under JACK
because users of firewire devices will also tend to be JACK users due to the
nature of the firewire devices and the kind of work one normally does with
them.

> This isn't an urgent thing for me - for the moment I'm quite happy to use
> my onboard card for playing music / movies etc, and keep the firewire card
> for recording music etc, but it might be useful sometimes to have an alsa
> driver for this card as well.

Many media players are capable of connecting to JACK.  xine, ecasound and
mplayer are a few which come to mind off the top of my head.  If your chosen
applications don't do JACK, then you might have some success with oss2jack
assuming your applications can use OSS devices (I haven't personally tried
it so I don't know how well it works).  There might even be an equivalent
"alsa2jack" bridge but I haven't seen it if there is.  Obviously your best
bet would be to find media players which support JACK natively.

Regards
  jonathan
