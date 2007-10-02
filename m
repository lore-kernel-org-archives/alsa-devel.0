From: Akio <akioolin@gmail.com>
Subject: Re:
	=?utf-8?q?about_sound/core/pcm=5Flib=2Ec=3A1997=3A_c?=
	=?utf-8?q?apture_read_error_=28DMA_or_IRQ_trouble=3F=29?=
Date: Tue, 2 Oct 2007 11:37:24 +0000 (UTC)
Message-ID: <loom.20071002T113246-759@post.gmane.org>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
	<loom.20070927T042730-792@post.gmane.org>
	<1190877245.11159.1212855119@webmail.messagingengine.com>
	<loom.20070928T151557-644@post.gmane.org>
	<1191221393.9447.1213434499@webmail.messagingengine.com>
	<loom.20071002T105039-455@post.gmane.org>
	<1191324230.918.1213682039@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FFED24408
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 13:38:00 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Icg4O-00036X-OW
	for alsa-devel@alsa-project.org; Tue, 02 Oct 2007 11:37:44 +0000
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 11:37:44 +0000
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 11:37:44 +0000
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

> > so the unit is samples not frames. does snd_pcm_prepare will reset
> > the counter or not?
> 
> You said that snd_pcm_prepare() returns -EIO, so I guess the driver
> does not.

you mean the drivers doesn't work very well when snd_pcm_prepare called.
 
> > my platform is Freescale i.mx27 TO1, the audio driver is come from Freescale.
> Then I'd suggest you'd ask Freescale.

   thank you very much. I'll ask Freescale to clarify this problem.

> In any case I cannot help you if you don't tell me where to find the
> source code of the driver.

   Actually I can give the driver. How do I give you the file?
   thank you very much.

Best Regards,
akio
