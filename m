From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH 1/2] [EXPERIMENTAL] Add support for the
 latest IndigoIOx and IndigoDJx cards
Date: Wed, 4 Feb 2009 01:15:32 +0100
Message-ID: <20090204011532.85974bcf.pochini@shiny.it>
References: <20090201230320.f665cc5e.pochini@shiny.it>
	<20090203011606.GA4774@x.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F848103875
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 01:15:30 +0100 (CET)
In-Reply-To: <20090203011606.GA4774@x.myhome.westell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: carmen <_@whats-your.name>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2 Feb 2009 20:16:06 -0500
carmen <_@whats-your.name> wrote:

> On Sun Feb 01, 2009 at 11:03:20PM +0100, Giuliano Pochini wrote:
> 
> i like your patch better, for the unique PCI ID and firmware 
> 
> enables DJx providing it is a module (so FS exists for firmware)
> 
> card 1: DJ [Indigo DJ], device 0: PCM [Indigo DJ]
>   Subdevices: 8/8
>   Subdevice #0: subdevice #0
>   Subdevice #1: subdevice #1
>   Subdevice #2: subdevice #2
>   Subdevice #3: subdevice #3
>   Subdevice #4: subdevice #4
>   Subdevice #5: subdevice #5
>   Subdevice #6: subdevice #6
>   Subdevice #7: subdevice #7
> 
> 
> unfortunately SampleRate is still FUBAR
> 
> eg sounds like 48000 playing @ 44.1 but adding -sr 44100 to jackd or mplayer results in the same pitch
> 
> -sr 32000 sounds pitched up (software downsampling, then card still playing at 44 or something)

Uhm, I don't know. I don't have the card (yet), and I can't test it. I'll
recheck the code as soon as I can. Did you try something simpler, eg.
aplay/arecord and speakertest ?


> if the firmware was *cough* open i might try to figure it out :)

Nope, they don't release the sources.


--
Giuliano.
