From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: about sound/core/pcm_lib.c:1997: capture read
 error (DMA or IRQ trouble?)
Date: Mon, 01 Oct 2007 08:49:53 +0200
Message-ID: <1191221393.9447.1213434499@webmail.messagingengine.com>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
	<loom.20070927T042730-792@post.gmane.org>
	<1190877245.11159.1212855119@webmail.messagingengine.com>
	<loom.20070928T151557-644@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 09699243A1
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Oct 2007 08:49:55 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9BE5B2F366
	for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2007 02:49:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070928T151557-644@post.gmane.org>
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
List-Id: alsa-devel@alsa-project.org

Akio wrote:
> Clemens Ladisch <cladisch <at> fastmail.net> writes:
> > Akio wrote:
> > > Clemens Ladisch <cladisch <at> fastmail.net> writes:
> > > > I would have guessed that some 32-bit counter has overflowed, but at
> > > > 48 kHz, a frame counter would overflow after slightly less than
> > > > 25 hours.
> > > 
> > > Thanks for Clemens. Could you tell me the counter's name and which layer does it?
> > > in alsa driver or in alsa lib or in alsa core module?
> > 
> > I'm not aware of any such bug in the ALSA framework.  I'd guess this is
> > some problem with your driver.
> > 
> > What sample frequency are you using?
> 
>   in my case, the sampling rate is 16k,

At 16 kHz, a 32-bit counter overflows after about 74.5 hours.

> what is the unit of the counter? period counts or samples?

I do not know what counter this could be.  I'm just guessing that _some_
counter overflows; this would fit the symptoms you've described.

> > > snd_pcm_prepare does not work.
> > 
> > What error does it return?
> 
>   I use strerr to get the error message, and it tell me "Input/Output
>   Error"

This error code is returned by the driver.  Which driver are you using?


Regards,
Clemens
