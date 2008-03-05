From: Armando Di Cianno <armando@goodship.net>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Wed, 05 Mar 2008 10:15:04 -0500
Message-ID: <1204730104.6310.40.camel@localhost>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
	<1204498741.10206.26.camel@razman.gruemaster.com>
	<1204623862.13915.10.camel@localhost.localdomain>
	<75b66ecd0803041654x2733bf35pbce849e7bef2ea85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from squid9.laughingsquid.net (squid9.laughingsquid.net
	[72.32.92.32]) by alsa0.perex.cz (Postfix) with ESMTP id 40362243FA
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 16:16:43 +0100 (CET)
In-Reply-To: <75b66ecd0803041654x2733bf35pbce849e7bef2ea85@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tue, 2008-03-04 at 19:54 -0500, Lee Revell wrote:
> In addition to anecdotal evidence, I can confirm that on my work
> machine the ATI video driver does seem to touch the audio.
> Interestingly it's the userspace X driver, not the in-kernel FGLRX
> module.
> 
> rlrevell@chronopolis:~$ strings
> /usr/lib/xorg/modules/drivers/fglrx_drv.so | grep -i hdmi | grep -i
> audio
> ex_aHDMIAudioParameters
> 
> Isn't DRM fun? ;-)

A similar test with nvidia-drivers 169.12 proved fruitless (as
expected).

-- 
Armando Di Cianno
http://dicianno.org/blog
armando@dicianno.org
armando@goodship.net
