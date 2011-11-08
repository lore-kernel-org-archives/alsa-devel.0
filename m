From: ajay khandelwal <ajay.lforum@gmail.com>
Subject: Re: SPDIF: How to play mono sound
Date: Tue, 8 Nov 2011 19:29:54 +0530
Message-ID: <CAL7V=_G6do1oPfoJYu=M8J+6c=hkc1Z-3_r7Uv8ugmpi6eq-Hw@mail.gmail.com>
References: <CAL7V=_ETiUeQ1f30SFh-DLYjbvvjcdNoAN0Q1dtCSoOTNsUirw@mail.gmail.com>
	<4EB90212.2080000@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 390331038E0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 14:59:56 +0100 (CET)
Received: by iafi7 with SMTP id i7so589866iaf.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 05:59:55 -0800 (PST)
In-Reply-To: <4EB90212.2080000@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Pavel,
It worked, just little improvement
 it should be in quotes like this
aplay -D"plug:'iec958:CARD=ICH6,DEV=0'" mono_music.wav
Best Regards,
Ajay
On Tue, Nov 8, 2011 at 3:48 PM, Pavel Hofman <pavel.hofman@ivitera.com>wrote:

>
> Dne 8.11.2011 11:04, ajay khandelwal napsal(a):
>  > Hi all,
> >  I have a pc with SPDIF out. I want to play audio file with single
> > channel(mono) using aplay.
> >
> > How to do that, when I try to play with following command, it gives error
> >
> > aplay -Diec958:CARDICH6,DEV=0 mono_music.wav
> >
> > it gives following error
> > aplay: set_param:1065: Channels count not available.
> >
>
> How about
>
> aplay -Dplug:iec958:CARDICH6,DEV=0 mono_music.wav
>
> Spdif is a stereo device and does not accept a single channel stream.
> The plug plugin will do the conversion:
>
> Plug PCM: Route conversion PCM (sformat=S16_LE)
>  Transformation table:
>    0 <- 0
>    1 <- 0
>
>
> Pavel.
>
