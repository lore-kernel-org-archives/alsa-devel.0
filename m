From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [Alsa-user] ALSA USB MIDI Input
Date: Thu, 22 Aug 2002 22:35:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020822203522.GE10066@tuba.home>
References: <633473941111D411AE94005004821C204F8305@LB_RWA_01> <Pine.HPX.4.33n.0208221809240.7805-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0208221809240.7805-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, Michael.Martin@evolution.co.uk, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 22, 2002 at 06:12:35PM +0200, Clemens Ladisch wrote:
> On Thu, 22 Aug 2002, Michael Martin wrote:
> > linux # cat /proc/asound/cards
> > 0 [card0          ]: USB-Audio - USB Audio Driver
> >                      Evolution Electronics Ltd. MK-249 USB MIDI keyboard
> > 1 [card1          ]: USB MIDI - Evolution Electronics Ltd. MK-2
> >                      Evolution Electronics Ltd. MK-249 USB MIDI keyboard at
> > 001/003 if 1
> 
> Oops.
> Set snd_cards_limits to 3, and add an alias from card 2 to snd-usb-audio,
> and add the option snd_index=2 to snd-usb-audio.

Isn't it a good argument to force an integration of both drivers to one card.

If there is one usb device which produces two cards, what would be the result
of a "graphical interface": two cards or one card? If this "graphical
interface" set snd_cards_limit wrong, it's a big source of more problems in
my opinion.

Clemens and Michael, it's called "snd_cards_limit" not "snd_cards_limits" - 
just to prevent more problems.


martin


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
