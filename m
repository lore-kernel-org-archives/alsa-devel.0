From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Wed, 16 Oct 2002 09:34:42 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210160851001.2959-100000@studcom.urz.uni-halle.de>
References: <20021015172751.82908.qmail@web12208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20021015172751.82908.qmail@web12208.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> here is the routine that is used in snd-usb-us428:
> ...
> its a copy-change of usb-audio. something wrong here ?

No, it's fine. The problem is elsewhere.

> > IMHO the "best" solution would be to add a quirk to
> > usbaudio.c, (...) (I'm sure I've missed something.
> > :)
> the us-428 audio is very nonstandard:
> it is necessary to know how many frames are just
> recorded to be able to playback without unwanted
> crackles.

I.e. an asynchronous endpoint without frequency feedback? :-(
There isn't a second endpoint in the playback interface?

> furthermore there are the hardware knobs, sliders and lights,
> the digital in switch....

... and I guess those aren't in any way compatible with USB audio mixer
controls.

> > Autoloading happens if there is an alias for
> > snd-card-x (x derived from
> > the client number) in modules.conf, ...
>
> I put a line
> "alias snd-card-1 snd-usb-midi"
> (the us-428 is my second card)
> into modules.conf. is it this what you suggest?

No, the alias should be for the card driver:
  alias snd-card-1 snd-usb-us428

> unfortunately the autoload still does not happen.

Autoloading works for sequencer ports and for "real" rawmidi devices,
but not for rawmidi devices emulated on top of a sequencer port.

Takashi, would it be possible/desirable to change snd_rawmidi_hw_open()
to load sequencer drivers if the card driver is loaded but the rawmidi
device doesn't exist?
Something like:

	if ((fd = open(filename, fmode)) < 0) {
-		snd_card_load(card);
+		card_loaded = snd_card_load(card) == 0; // 0 or 1?
-		if ((fd = open(filename, fmode)) < 0) {
+		fd = open(filename, fmode);
+		if (card_loaded && fd < 0) {
+			load_seq_dev(...); // hw_open, get_client_info ?
+			fd = open(filename, fmode);
+		}
+		if (fd < 0) {
			snd_ctl_close(ctl);
			SYSERR("open %s failed", filename);
			return -errno;
		}
	}


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
