From: Akio <akioolin@gmail.com>
Subject: Re:
	=?utf-8?q?about_sound/core/pcm=5Flib=2Ec=3A1997=3A_c?=
	=?utf-8?q?apture_read_error_=28DMA_or_IRQ_trouble=3F=29?=
Date: Tue, 2 Oct 2007 10:58:55 +0000 (UTC)
Message-ID: <loom.20071002T105039-455@post.gmane.org>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
	<loom.20070927T042730-792@post.gmane.org>
	<1190877245.11159.1212855119@webmail.messagingengine.com>
	<loom.20070928T151557-644@post.gmane.org>
	<1191221393.9447.1213434499@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 61470243AF
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 12:59:30 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IcfT8-0007IO-EJ
	for alsa-devel@alsa-project.org; Tue, 02 Oct 2007 10:59:17 +0000
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 10:59:14 +0000
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 10:59:14 +0000
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

> >   in my case, the sampling rate is 16k,
> 
> At 16 kHz, a 32-bit counter overflows after about 74.5 hours.

so the unit is samples not frames. does snd_pcm_prepare will reset
the counter or not?

> > what is the unit of the counter? period counts or samples?
> 
> I do not know what counter this could be.  I'm just guessing that _some_
> counter overflows; this would fit the symptoms you've described.

   so I have to check out where is overflow occurred. which function should I
dive into?

> >   I use strerr to get the error message, and it tell me "Input/Output
> >   Error"
> 
> This error code is returned by the driver.  Which driver are you using?

my platform is Freescale i.mx27 TO1, the audio driver is come from Freescale.
the audio codec is Freescale PC13783. the alsa core version is 1.0.13, kernel 
version is 2.6.19.3.

Thank you very much.

Best Regards,
Akio
