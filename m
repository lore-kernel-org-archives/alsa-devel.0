From: Peter Chapman <x6pe9syq02@sneakemail.com>
Subject: Re: module_init fails with OEM SoundBlaster Live!
Date: Mon, 3 Nov 2003 15:56:06 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031103155606.GA17691@gondolin.homeip.net>
References: <20031102114634.GA13679@gondolin.homeip.net> <s5h4qxlve2h.wl@alsa2.suse.de> <20031103132012.GA16956@gondolin.homeip.net> <s5h3cd5v7bz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3cd5v7bz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 03, 2003 at 03:45:52PM +0100, Takashi Iwai tiwai-at-suse.de |alsa-devel| wrote:
> At Mon, 3 Nov 2003 13:20:12 +0000,
> Peter Chapman wrote:
> > 
> > Is this what you mean?
> > $ cat /proc/asound/card0/codec97#0/ac97#0-0
> > 0-0/0: Cirrus Logic CS4297A rev 4
> > 
> > Capabilities     : -headphone out-
> > DAC resolution   : 20-bit
> > ADC resolution   : 18-bit
> > 3D enhancement   : Crystal Semi 3D Stereo Enhancement
> > 
> > Current setup
> > Mic gain         : +0dB [+0dB]
> > POP path         : pre 3D
> > Sim. stereo      : off
> > 3D enhancement   : off
> > Loudness         : off
> > Mono output      : MIX
> > Mic select       : Mic1
> > ADC/DAC loopback : off
> > Extended ID      : codec=0 rev=0 AMAP DSA=0
> > Extended status  :
> > SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
> > 
> > I can't find any mention of IEC958, but then I don't really know what
> > I'm doing! I can check the chips on the card itself when I get home, if
> > that will help.
> 
> IEC958 is aka SPDIF.  you see it in the above too :)
> 
> does the board have spdif i/o?
> 
> 
> Takashi

Oh, I see! :) Yes, there is an spdif connector on the card, however I've
never managed to make it work, either under Linux or Windows. Not even
using Dell's own Windows drivers.
I've always suspected that I had a crippled version of the card from
Dell, but maybe it's just defective?
Personally, I'm happy to modify the source before I build it, but I
wonder if there are other people with the same hardware. I suppose time
will tell as 2.6.0 bings a whole load more alsa users.

Pete


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
