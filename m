From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: SPDIF: How to play mono sound
Date: Tue, 08 Nov 2011 11:18:58 +0100
Message-ID: <4EB90212.2080000@ivitera.com>
References: <CAL7V=_ETiUeQ1f30SFh-DLYjbvvjcdNoAN0Q1dtCSoOTNsUirw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 0171B24365
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:18:59 +0100 (CET)
In-Reply-To: <CAL7V=_ETiUeQ1f30SFh-DLYjbvvjcdNoAN0Q1dtCSoOTNsUirw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ajay khandelwal <ajay.lforum@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Dne 8.11.2011 11:04, ajay khandelwal napsal(a):
> Hi all,
>  I have a pc with SPDIF out. I want to play audio file with single
> channel(mono) using aplay.
> 
> How to do that, when I try to play with following command, it gives error
> 
> aplay -Diec958:CARDICH6,DEV=0 mono_music.wav
> 
> it gives following error
> aplay: set_param:1065: Channels count not available.
> 

How about

aplay -Dplug:iec958:CARDICH6,DEV=0 mono_music.wav

Spdif is a stereo device and does not accept a single channel stream.
The plug plugin will do the conversion:

Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0


Pavel.
