From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio in ALSA 0.9.0rc5
Date: Wed, 13 Nov 2002 09:50:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211130912420.5971-100000@studcom.urz.uni-halle.de>
References: <200211122006.36454.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200211122006.36454.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> On Tuesday 12 November 2002 10:36, you wrote:
> > When you open the device as /dev/midiX (or /dev/snd/midiCXD0), ALSA will
> > open the first available subdevice, so you can access both ports by
> > opening /dev/midiX twice.
>
> This trick does work for input only, but not for output. Seems that /dev/midiX
> can be opened for output several times at once, but it mixes every MIDI
> events on the first MIDI port only. Anyway, it's funny but not a very
> practical solution, is it?

Sharing of output ports is an option with ALSA ports (/dev/snd/midiCxDy),
but it's always done with OSS ports (/dev/midix), probably for
compatibility reasons.

So, use /dev/snd/midiCcDd instead of /dev/midix.
Or delete /dev/midix and make it a symlink to /dev/snd/midiCcDd.  :-)

> > You can change the device number of /dev/amidiX with the "amidi_map"
> > parameter of the snd-rawmidi module. The default is
> >     options snd-rawmidi midi_map=0,0,0,0,0,0,0,0 amidi_map=1,1,1,1,1,1,1,1
> > meaning that /dev/midiX is device 0 and /dev/amidiX is device 1 for all
> > eight cards. If you change the amidi_map number for the 2x2 card to 0,
> > both /dev/midiX and /dev/amidiX will map to a port of the 2x2.
>
> That is also interesting, but a 'subdevice_map' option may be still more
> useful.

Yes, but we'd need two (for /dev/midiX and /dev/amidiX).
And it wouldn't help if you wanted to use more than two ports on a card.

> IMHO, mapping the card MIDI ports to subdevices may be OK, but only for ALSA
> native rawmidi. After all, you can access some MIDI port with "hw:x,y,z"
> instead of "hw:x,y", but for OSS emulation a better approach is needed. For
> major 14, why not to bind minors sequentially for each MIDI port on the
> system? I mean: first port minor=2, second port minor=18, ... thru -and up-
> minor=242 (/dev/midi15) if needed, regardless of ALSA card numbers?

This would break if cards are loaded dynamically, i.e. the port number
would depend on the order the drivers are loaded.

But the OSS emulation uses only 16 minors per card, and ALSA doesn't
handle more than 8 cards, so the minors 128..255 are currently unused.

Well, for obvous reasons (i.e. laziness), the current answer for this is
"don't use OSS".  ;-)


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
