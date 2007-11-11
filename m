From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: E-mu 1212M/1820M/1616M development
Date: Sun, 11 Nov 2007 22:51:34 +0000
Message-ID: <47378776.6050403@superbug.co.uk>
References: <47376DE9.5000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 572CB2474C
	for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2007 23:51:02 +0100 (CET)
In-Reply-To: <47376DE9.5000904@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ctirad Fertr <c.fertr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ctirad Fertr wrote:
> Hello,
>
> I just bought an 1616M PCMCIA in addition to my old 1212m v1 and want to 
> help improve the current driver. I wrote one little patch for those 
> cards in the past (and some bigger patches for my experiments which were 
> never released) and now I have some time to continue.
>
> I'm going to add missing switches into mixer, make some changes in mixer 
> to match the real I/O setup of each particular card model and perhaps 
> also write some graphics patchmix like app.
>   
A graphics patchmix like app would be the most useful at the moment. It 
would permit us to enable the 96kHz and 192kHz options, as for these 
different DSP code needs to be loaded, and that is best left to userland.

> Unfortunatelly, I'm unable to fix the most important bugs (at least from 
> my point of view) dua to lack of documentation and knowlenge of DSP 
> programming. These are:
>
> 1. non working 24bit playback. It should be on device 0,2 This device 
> exists, but cannot be openned for playback.It is the last thing needed 
> for serious DAW.
>   
I will look into this. Please raise a bug on alsa-project.org so we 
don't forget this.

> 2. Non working S/PDIF (and probably ADAT, too) on 1616(M) microdock 
> ports. I think tese ports uses different set of registers than PCI 1010 
> host card. Am I right?
>   
Correct, they are different. I will try to update the driver with some 
details tomorrow.
> 3. Midi I/O works well on 1212m v1, but only when 48kHz is set. At 
> 44.1kHz signalling is corrupted (different UART timing? How to fix it?). 
> On 1616m microdock MIDI I/O does not work at all.
>   
There is no mention in the docs regarding the clock rates affecting MIDI 
at all.
I think this might be a trial and error fix.
There is an extra register for midi routing config on the 1616m, so I 
might have to get that sorted.
> I welcome any comments, advices and patches ;)
>
> ----
> Ctirad
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
