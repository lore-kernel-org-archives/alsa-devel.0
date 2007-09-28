From: Akio <akioolin@gmail.com>
Subject: Re:
	=?utf-8?q?about_sound/core/pcm=5Flib=2Ec=3A1997=3A_c?=
	=?utf-8?q?apture_read_error_=28DMA_or_IRQ_trouble=3F=29?=
Date: Fri, 28 Sep 2007 15:23:57 +0000 (UTC)
Message-ID: <loom.20070928T151557-644@post.gmane.org>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
	<loom.20070927T042730-792@post.gmane.org>
	<1190877245.11159.1212855119@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BBF010381B
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 17:26:17 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IbHhq-0002qQ-W6
	for alsa-devel@alsa-project.org; Fri, 28 Sep 2007 15:24:43 +0000
Received: from 219-69-46-27.idc.static.giga.net.tw ([219.69.46.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 15:24:42 +0000
Received: from akioolin by 219-69-46-27.idc.static.giga.net.tw with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 15:24:42 +0000
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
> Akio wrote:
> > Clemens Ladisch <cladisch <at> fastmail.net> writes:
> > > Akio write:
> > > > after long time amr-wb codec loopback test. (above 90 hours)
> > > > I got the following kernel message.  it comes from snd_pcm_lib_read1()
> > > > function. 
> > > > ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ 
trouble?)
> > > 
> > > This error indicates that no interrupt has been received for ten
> > > seconds.
> > > 
> > > I would have guessed that some 32-bit counter has overflowed, but at
> > > 48 kHz, a frame counter would overflow after slightly less than
> > > 25 hours.
> > 
> > Thanks for Clemens. Could you tell me the counter's name and which layer 
does it?
> > in alsa driver or in alsa lib or in alsa core module?
> 
> I'm not aware of any such bug in the ALSA framework.  I'd guess this is
> some problem with your driver.
> 
> What sample frequency are you using?

  in my case, the sampling rate is 16k, and test voice codec is amr-wb
  the period size is 64bytes and period counts is 128.
  what is the unit of the counter? period counts or samples?

> > snd_pcm_prepare does not work.
> 
> What error does it return?

  I use strerr to get the error message, and it tell me "Input/Output Error"

  I have to do the test again to make sure the exactly time and make sure
  if the time exceed, the message will come out again or not.

  BTW, is there any other test should I have to do?

> Regards,
> Clemens
