From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: usb-midi rc3 patch request
Date: Mon, 19 Aug 2002 20:17:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020819181700.67854.qmail@web12206.mail.yahoo.com>
References: <s5helcvt801.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5helcvt801.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote: > At Fri, 16
Aug 2002 12:34:50 +0200 (CEST),
> karsten wiese wrote:
> > 
> > hallo,
> >
> > the attached patch exports two functions of
usb-midi,
> > so other "device-owning" drivers can use
usb-midi's
> > capabilities.
> > the patched usb-midi driver is used by the us428
> > driver through those exported functions.
> > we can avoid having different alsa-devices for the
> > same physical device this way.
> > plus usb-midi can be used for non standard
devices,
> > which need special initialisations through a
special
> > driver first.
> > the patched usb-midi drivers should work in all
other
> > cases exactly as before.
>
> sorry, your patch looks still a bit hacky, perhaps
> because you wanted
> to keep the usb-midi code as original as possible.
>
> i think we need rather rewrite the top of usb device
> management (on
> alsa).  there is also another problem in this
> regard, for example,
> a device with both midi and audio is assigned to two
> different cards,
> since midi and audio handles it individually.

the patch adresses just that. here the output of
cat /proc/asound/devices
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
 32: [1- 0]: ctl
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 40: [1- 0]: raw midi
 41: [1- 1]: raw midi

cat /proc/asound/cards
0 [card0          ]: ES1978 - ESS ES1978 (Maestro 2E)
                     ESS ES1978 (Maestro 2E) at
0x1400, irq 5
1 [card1          ]: USB US-428 - TASCAM US-428
                     TASCAM US-428 (1604:8001 if 0 at
001/003)

the us428 driver calls the snd-usb-midi like this:

 err = snd_usbmidi_card_create(  us428->dev,
     &us428->usbmidi,
        &us428->card,
     &us428->usbmidi_devnum
     );
interesting here is that us428->card has already been
initialized from the us428 driver before.
the patched snd_usbmidi_card_create() creates thus
er...  (hacky, cause the name doesnt fit anymore)
NO card on its own but uses the supplied one.
Would it be sufficient to add an extra function like
snd_usbmidi_card_attach() instead of overloading
snd_usbmidi_card_create()?

>
> let's discuss about it at first.
>
> (BTW, could you check the legal condition of
> firmware on tascam
>  device?  i'd like to put the stuffs but without
> this permission it's
>  of course unacceptable...)

what exactly do you need? I once tried to get an
answer from turtle beach,
which did not happen...
tascam will most likely not agree to release the
firmware under GPL in any form nor object- nor
source-code.
is it sufficient, if tascam just allows ALSA to use &
publish their firmware as it is now?
now it consists of char arrays in C header files
representing raw binary data sniffed from the win2k
USB.
tascam will likely want a comment in the header
stating that it is forbidden to disassemble,
that the code in that file is their property and may
only be used to compile the code & nothing else.
is there such a file header aside the GPL-world
already to be used as temlate?

AND does anybody know somebody @ TASCAM?

Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
