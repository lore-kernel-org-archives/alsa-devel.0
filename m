From: Robert Siemer <Robert.Siemer@gmx.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sat, 30 Mar 2002 22:53:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020330225341F.siemer@panorama.hadiko.de>
References: <20020329230421.GD707@rainbow.internal>
	<20020330202713.GF707@rainbow.internal>
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020330202713.GF707@rainbow.internal>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: rj@rainbow.in-berlin.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Robert Joop <rj@rainbow.in-berlin.de>

> what makes me wonder is:
> - at boot time, the BIOS says it initializes the plug and play cards
>   and detects the sound card, it prints its name.
> - but the linux ISA PNP does not seem to detect it:
>   Mar 30 19:20:13 moonbow kernel: isapnp: Scanning for PnP cards...
>   Mar 30 19:20:13 moonbow kernel: isapnp: No Plug & Play device found
> - nor does the soundcard driver:
>   Mar 30 19:20:18 moonbow kernel: ALSA card-ad1816a.c:348: no
>   AD1816A based soundcards found.
>
> i've tried to make some sense of the output of pnpdump(1) and added
> an entry to snd_ad1816a_pnpids[], but it hasn't helped.

pnpdump does find the card and 'kernel isapnp' does not? You have a
problem beyound ALSA.

What is pnpdump saying? Maybe some parameters to isa-pnp.o can
help. At least isapnp_verbose I think. Look for MODULE_PARM in 
linux/drivers/pnp/isapnp.c


Bye,
	Robert
