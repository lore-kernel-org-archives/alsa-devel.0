From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Application supporting forward/rewind APIs
Date: Wed, 7 Oct 2009 14:58:23 +0800
Message-ID: <4f3252890910062358p6ea8a600ya01a5d6812ca5d26@mail.gmail.com>
References: <2ee9e08d0909240034t6fdab6aftc24e733621638f09@mail.gmail.com>
	<s5hocp0vlm6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f174.google.com (mail-px0-f174.google.com
	[209.85.216.174])
	by alsa0.perex.cz (Postfix) with ESMTP id E181924386
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 08:58:24 +0200 (CEST)
Received: by pxi4 with SMTP id 4so4679213pxi.23
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 23:58:24 -0700 (PDT)
In-Reply-To: <s5hocp0vlm6.wl%tiwai@suse.de>
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

It seem that the difference between the application pointer and the hardware
pointer is just the theoretical value which none of the sound card can
achieve


static snd_pcm_sframes_t snd_pcm_hw_rewindable(snd_pcm_t *pcm)
{
    return snd_pcm_mmap_hw_avail(pcm);
}

To allow the application rewind the application pointer to hardware pointer
and rewrite the next sample immediately at any time

The audio controller have to fetch the audio data as the same rate as the
sampling rate.

The practical value may be the difference between the application pointer
and the nearest period boundary


2009/9/24 Takashi Iwai <tiwai@suse.de>

> At Thu, 24 Sep 2009 13:04:24 +0530,
> Anuj Aggarwal wrote:
> >
> > Hi,
> >
> > I want to try the forward/rewind APIs supported by the ALSA library.
> > Can someone point to an ALSA application which exercises these APIs?
>
> Pulseaudio is using snd_pcm_rewind().
> About snd_pcm_forward(), I don't know of...
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
