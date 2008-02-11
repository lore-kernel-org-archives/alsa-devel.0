From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Ac97 on Au1200- No Sound
Date: Mon, 11 Feb 2008 17:09:47 +0000
Message-ID: <1202749787.3466.55.camel@localhost.localdomain>
References: <834996.85920.qm@web50101.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09EF9244BF
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 18:09:49 +0100 (CET)
In-Reply-To: <834996.85920.qm@web50101.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nitinm76@yahoo.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-02-08 at 12:00 +0000, Nitin Mahajan wrote:
> HI!
> 
> I am working with a Au1200 based board and trying to
> make the audio(AC97 + STAC9752) work after applying
> the ASoC patch at
> http://opensource.wolfsonmicro.com/~git/asoc/.
> 
> After writing the machine driver for my board based on
> the exmmb-ac97.c as a template, my codec is being
> detected, which is on PSC1.
> 
> But when I play some .wav file using aplay, I get to
> hear the sound with a very low volume, which is almost
> not recognizable.

It sounds like the AC97 link is up and running and your DMA is sending
PCM data to the codec.

> 
> I unmuted the codec with these two commands
> 
> #amixer set "Master" 255 unmute
> #amixer set "PCM" 255 unmute
> 
> I also tried to watch /proc/interrupts but I am not
> able to see any interrupts coming on IRQ 11 that is
> for PSC1.
> 
> Could some one provide more insight into what might be
> going wrong?
> 

Can you try using alsamixer. It's possible you are not unmuting the
correct kcontrols.

Liam
