From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Wed, 16 Oct 2002 13:19:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210161227530.11784-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.33.0210160954510.731-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.33.0210160954510.731-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 16 Oct 2002, Clemens Ladisch wrote:
> > Takashi, would it be possible/desirable to change snd_rawmidi_hw_open()
> > to load sequencer drivers if the card driver is loaded but the rawmidi
> > device doesn't exist?
> > Something like:
> > (...)
>
> It looks ugly.

Yes.

> Wouldn't be better to create a direct rawmidi USB driver?
> Could you remind me reason, why you parse sequencer events? There's
> something special for USB?

USB MIDI is not the same as rawmidi as each MIDI command must be sent as a
32-bit packet, so the driver must parse the stream somehow. (There is a
USB MIDI code to send a raw MIDI byte, but there are devices not
supporting this. (The USB MIDI specification and said device are, of
course, from the same company.))

Well, the real reason why I wrote a sequencer driver was that I wanted to
decide between a rawmidi and a sequencer driver, but there wasn't any
sequencer driver supporting input, so I had to write one to find out about
it.  ;-)

It turns out there isn't any real advantage over a rawmidi driver, so I
think I'll change the driver to use rawmidi in the next few days.


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
