From: Robert Joop <rj@rainbow.in-berlin.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sun, 31 Mar 2002 13:53:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020331115359.GA15466@rainbow.internal>
References: <20020330202713.GF707@rainbow.internal> <20020330225341F.siemer@panorama.hadiko.de> <20020331004854.GH707@rainbow.internal> <20020331032556Y.siemer@panorama.hadiko.de> <20020331113824.GI707@rainbow.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020331113824.GI707@rainbow.internal>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02-03-31 13:38:24 MET DST, Robert Joop wrote:
> is pnp necessary anyway?!
> this is the first time ever (in about 9 years of using linux) that i
> give pnp a try.
> with kernel 2.2.19 it was just
> 
>   alias sound-slot-0 gen_sound
>   alias sound-service-0-3 gen_sound
>   alias gen_sound sb
>   options sb io=0x220 irq=5 dma=1 dma16=0
> 
> but this hangs the machine with 2.4.18, and i couldn't find out the
> correct module parameters for neither the kernel's ad1816 driver nor
> alsa's...

...until now.
i just permutated pnpdump's output and one combination actually works:

  modprobe ad1816 io=0x530 irq=5 dma=1 dma2=3

strange that the io port is so much different.
and that's the kernel's driver, but the alsa driver is more demanding,
it wants two more ports and one more IRQ.

perhaps i better stop with what i've got now, "if it ain't broke, don't
fix it"...

thanks for listening!
(and i'll keep using the alsa driver on the laptop. :-)

rj
