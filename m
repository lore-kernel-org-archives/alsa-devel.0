From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: USB Audio questions
Date: Wed, 17 Aug 2011 00:11:55 +0200
Message-ID: <4E4AEB2B.4030700@ivitera.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>	<4E4A100D.9020302@ladisch.de>	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
	<131d4536813.-8375004616171444232.4180326891785246293@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.pilsfree.net (mail.pilsfree.net [81.201.60.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 10ED810383B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 00:12:04 +0200 (CEST)
In-Reply-To: <131d4536813.-8375004616171444232.4180326891785246293@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 16.8.2011 22:41, Torsten Schenk napsal(a):
> Hi Pierre,
> 
> - The device/driver sends per urb a constant number of packets (as
> you already also discovered). The number of samples per packet differ
> however (+- 1 sample per packet). I accuse the asynchronousity
> between the urb interval and the sound card's internal clock for this
> fact. The device expects the driver to send back an urb with exactly
> the same structure. The device produced crackling noise if the
> samples per packet were not equal. I cannot say to what extend this
> is true (i.e. if you could wait some packets until catching up the
> difference without producing crackles) 

Could we attribute this to the adaptive mode and PLL striving to produce
steady stream of well-timed samples to the DAC? IMHO the lower variation
in samples per packet, the lower jitter of the PLL-recovered clock.

Pavel.
