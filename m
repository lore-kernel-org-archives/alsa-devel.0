From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Does Gravis Classic driver work?
Date: Thu, 04 Sep 2008 00:22:01 +0200
Message-ID: <48BF0E09.9060804@keyaccess.nl>
References: <20080903213153.f3feda45.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D18C24517
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 00:19:47 +0200 (CEST)
In-Reply-To: <20080903213153.f3feda45.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03-09-08 21:31, Krzysztof Helt wrote:

> I have acquired an unknown clone of the GF1 classic card.

Probably a Primax Soundstorm.

> I load the snd-gusclassic driver with
> modprobe snd-gusclassic port=0x220
> 
> and the /proc/asound/cards says
>  0 [G37            ]: GUS - Gravis UltraSound Classic (3.7)
>                       Gravis UltraSound Classic (3.7) at 0x220, irq 5, dma 5&5
> 
> The alsamixer works. I set maximum volume for the PCM and master controls.
> 
> The aplay -l says:
> **** List of PLAYBACK Hardware Devices ****
> card 0: G37 [Gravis UltraSound Classic (3.7)], device 0: GF1 [GF1 (synth)]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> but the aplay -L says nothing.
> 
> the aplay with the .wav file does not play.
> aplay /usr/share/sounds/alsa/Front_Center.wav
> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:545: audio open error: No such file or directory
> 
> I have tried to follow the alsa wiki but it has not helped (btw, there is no
> driver the "gusclassic" listed, only the "gus"). Could you point me to
> any piece of information how to set up the card?
> 
> The card works with DOS game with Miles (?) drivers.

Known issue indeed. It works via OSS. When I noticed this (it's on this 
list somewhere) I was quite unaware of the user space stuff and none 
else seemed capable of hinting in some general direction either so the 
issue fell of the radar again. But it's probably just some lib/config 
issue. As said, OSS players (such as ogg123 -d oss, mpg321 -o oss) worked.

(I'm by the way ouf of action currently. I do have an original GUS 
classic, GUS MAX, GUS Extreme and several clones so I'll confirm 
anything you find in due course).

Rene.
