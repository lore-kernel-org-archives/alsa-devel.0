From: Akio <akioolin@gmail.com>
Subject: Re:
	=?utf-8?q?about_sound/core/pcm=5Flib=2Ec=3A1997=3A_c?=
	=?utf-8?q?apture_read_error_=28DMA_or_IRQ_trouble=3F=29?=
Date: Thu, 27 Sep 2007 04:31:10 +0000 (UTC)
Message-ID: <loom.20070927T042730-792@post.gmane.org>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AA8A1037EB
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 06:31:31 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ial20-0006Gu-Sf
	for alsa-devel@alsa-project.org; Thu, 27 Sep 2007 04:31:28 +0000
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2007 04:31:20 +0000
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2007 04:31:20 +0000
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

Clemens Ladisch <cladisch <at> fastmail.net> writes:

> 
> Akio write:
> > after long time amr-wb codec loopback test. (above 90 hours)
> > I got the following kernel message.  it comes from snd_pcm_lib_read1()
> > function. 
> > ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ trouble?)
> 
> This error indicates that no interrupt has been received for ten
> seconds.
> 
> I would have guessed that some 32-bit counter has overflowed, but at
> 48 kHz, a frame counter would overflow after slightly less than
> 25 hours.
> 
> HTH
> Clemens
> 


Thanks for Clemens. Could you tell me the counter's name and which layer does it?
in alsa driver or in alsa lib or in alsa core module?
BTW, when this error happened, what could I do?
snd_pcm_prepare does not work.

Thank you very much.

Best Regards,
Akio
