From: Robert Joop <rj@rainbow.in-berlin.de>
Subject: Re: help needed for my AD1816A based soundcard
Date: Sat, 30 Mar 2002 21:27:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020330202713.GF707@rainbow.internal>
References: <20020329230421.GD707@rainbow.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020329230421.GD707@rainbow.internal>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02-03-30 00:04:21 MET, Robert Joop wrote:
> alsa's ad1816a driver doesn't find my card.
> i've ISAPNP turned on.
> the card is a Highscreen Sound-Boostar 32 Wave 3D, it doesn't seem to
> have an entry in card-ad1816a.c.
> the entries in snd_ad1816a_pnpids[] look rather esoteric and i haven't
> found any documentation on adding an entry.
> how do i collect the necessary information?
> is it sufficient just adding an entry to the array?
> 
> the card has an AD1816A and two DSP chips on it.
> 
> (btw, with kernel 2.2.x's sb driver the card worked, but 2.4.18's sb it
> hangs the computer.
> and kernel 2.4.18's ad1816 driver doesn't detect the card either.)

btw, i'm using debian's alsa-source 0.9+0beta10-6 package.

what makes me wonder is:
- at boot time, the BIOS says it initializes the plug and play cards
  and detects the sound card, it prints its name.
- but the linux ISA PNP does not seem to detect it:
  Mar 30 19:20:13 moonbow kernel: isapnp: Scanning for PnP cards...
  Mar 30 19:20:13 moonbow kernel: isapnp: No Plug & Play device found
- nor does the soundcard driver:
  Mar 30 19:20:18 moonbow kernel: ALSA card-ad1816a.c:348: no AD1816A based soundcards found.

i've tried to make some sense of the output of pnpdump(1) and added an
entry to snd_ad1816a_pnpids[], but it hasn't helped.

rj
