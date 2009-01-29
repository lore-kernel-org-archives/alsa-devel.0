From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Thu, 29 Jan 2009 09:28:12 +0100
Message-ID: <4981689C.7000609@ladisch.de>
References: <20090120025727.GA30499@tango.0pointer.de>	<49758B71.8090605@ladisch.de>	<20090120142614.GA27494@tango.0pointer.de>	<49761C79.8060605@ladisch.de>	<20090120202933.GA17626@tango.0pointer.de>	<s5hwscpqypo.wl%tiwai@suse.de>	<20090122222015.GB9379@tango.0pointer.de>	<s5htz7q54k3.wl%tiwai@suse.de>
	<497A04D6.4000603@ladisch.de>
	<20090128183000.GG11770@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id BBB7810384A
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 09:28:15 +0100 (CET)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.fastmail.fm (Postfix) with ESMTP id 020F326361B
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 03:28:14 -0500 (EST)
Received: from [10.1.2.151] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7F0503441E
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 03:28:14 -0500 (EST)
In-Reply-To: <20090128183000.GG11770@tango.0pointer.de>
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

Lennart Poettering wrote:
> On Fri, 23.01.09 18:56, Clemens Ladisch (clemens@ladisch.de) wrote:
> > Instead of writing a callback in the USB driver to compute the time
> > until the next underrun, I'd rather rip out that fast start code.

(Done.)

> > So, no kernel computation is needed.  :-)
> 
> While I think it would be good not have this kind of double-buffering
> I wonder if this is really future-proof. i.e. can this done with every
> driver that uses 'fast starts'? 

Yes, because the USB driver was the only one that did this.

There are other drivers that use double-buffering (and the USB driver
still does), but there the playback speed does not change, i.e., the
stream is not more underrun-prone when starting.

> > * For many devices (legacy ISA, etc.), we just don't know the correct
> >   value.
> 
> But it should be possible to pick a safe boundary, shouldn't it?

In theory, the _safe_ boundary is one period.  In practice, ISA devices
cannot afford to prefetch much data due to the low bus bandwidth, so
one (frame) should be OK.  (And we _know_ devices that do whole-period
double-buffering because the code is right there in the driver.)


Best regards,
Clemens
