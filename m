From: Robert Joop <rj@rainbow.in-berlin.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sun, 31 Mar 2002 13:38:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020331113824.GI707@rainbow.internal>
References: <20020330202713.GF707@rainbow.internal> <20020330225341F.siemer@panorama.hadiko.de> <20020331004854.GH707@rainbow.internal> <20020331032556Y.siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020331032556Y.siemer@panorama.hadiko.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Siemer <siemer@panorama.hadiko.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02-03-31 03:25:56 MET DST, Robert Siemer wrote:
> You don't need to try anything with ALSA code, as 'kernel isapnp'
> does not find your card.

ok, if you are sure about this.
i must admit that i didn't give the kernel isapnp's output much
attention, because i read somewhere that alsa does its own isapnp.

> Try isapnp_rdp=0x273 and play with isapnp_reset module parameter.

doesn't help.

is pnp necessary anyway?!
this is the first time ever (in about 9 years of using linux) that i
give pnp a try.
with kernel 2.2.19 it was just

  alias sound-slot-0 gen_sound
  alias sound-service-0-3 gen_sound
  alias gen_sound sb
  options sb io=0x220 irq=5 dma=1 dma16=0

but this hangs the machine with 2.4.18, and i couldn't find out the
correct module parameters for neither the kernel's ad1816 driver nor
alsa's...

rj
