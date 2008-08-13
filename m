From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re: ASoC machine driver: use more than one at91 ssc
Date: Wed, 13 Aug 2008 06:03:40 +0000 (UTC)
Message-ID: <loom.20080813T060220-577@post.gmane.org>
References: <loom.20080812T193653-308@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D32162442F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 08:03:49 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KT9SW-0000rF-1X
	for alsa-devel@alsa-project.org; Wed, 13 Aug 2008 06:03:48 +0000
Received: from modemcable024.51-130-66.mc.videotron.ca ([66.130.51.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 06:03:48 +0000
Received: from bidou by modemcable024.51-130-66.mc.videotron.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 06:03:48 +0000
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

Simon Tremblay <bidou <at> videotron.qc.ca> writes:

> 
> Hi, 
> 
> I want to use more than one SSC (2 to be more accurate) to be able to do what
 is
> indicated at Figure 4 of page 10/13 of this document
> http://www.atmel.com/dyn/resources/prod_documents/doc6020.pdf (how to setup 
SSC
> with a I2S codec).
> 
> I saw in sound/soc/at91/eti_b1_wm8731.c use of 1 SSC.
> 
> Does I need more than one snd_soc_dai_link in my snd_soc_machine? But for
what I
> understand for now, I need one SSC for sound output and 2 SSC for sound input.
> 
> I don't know if there is some example about how to do that.
> 
> Simon
> 


I was thinking about that and maybe the best way to resolve this is to modify
at91-ssc.c and add a new entry in at91_ssc_dai that supports ssc0 and ssc1
together (and modify / add some functions to support this new entry). Humm, I
need to find a way to be able to reuse code here. What do you think about all of
that ?

Thanks,

Simon
