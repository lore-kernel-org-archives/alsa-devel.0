From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: Re: Timer interface
Date: Tue, 2 Aug 2011 12:43:43 +0200
Message-ID: <71FDAAAC218B4762B64D80302DB55B5E@domain.local>
References: <1731E52B1A4E4804B5D5A4820E26368F@domain.local><s5h4o20tl3g.wl%tiwai@suse.de><C58CA57B5617482A934848228E6EB13D@domain.local>
	<s5hwrewnlqf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE46244E6
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 12:43:46 +0200 (CEST)
In-Reply-To: <s5hwrewnlqf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I got it. I've fixed the problem with the node creation and dmix works fine
now. 
Thanks

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: 02 August 2011 12:37
To: Nenad Sljivic
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Timer interface

At Tue, 2 Aug 2011 12:33:32 +0200,
Nenad Sljivic wrote:
> 
> Takashi,
> 
> Thanks for your help. My timer device has not been created at the correct
> path (/dev/snd), so I thought it was missing and that I need to implement
> it.  

No, you don't have to implement the timer in your driver explicitly.
A slave-timer instance is created for each PCM stream (see
sound/core/pcm_timer.c), and dmix uses this.
Look at /proc/asound/timers.  On my machine, it shows like:

G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P0-2-3: PCM capture 0-2-3 : SLAVE
P1-3-0: PCM playback 1-3-0 : SLAV


Takashi

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: 02 August 2011 07:54
> To: Nenad Sljivic
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Timer interface
> 
> At Fri, 29 Jul 2011 17:05:23 +0200,
> Nenad Sljivic wrote:
> > 
> > Hi,
> > 
> > I am extending my ALSA driver in order to support software mixing.
Driver
> > currently supports both MMAP and RW access modes. However, I am still
not
> > able to use dmix since it requires timer interface to be implemented.
> > My hardware does not generate interrupts at the period boundary but
issues
> > timer interrupts at a fixed timer rate. 
> 
> The timer interface is always present with ALSA (kernel) PCM
> interface, thus normally you don't have to implement it.
> Or are you trying to implement without the normal kernel driver but
> with alsa-lib ioplug or such?
> 
> 
> Takashi
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
