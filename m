From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Tue, 15 Oct 2002 17:24:50 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210151659320.6379-100000@studcom.urz.uni-halle.de>
References: <20021015144056.40474.qmail@web12202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20021015144056.40474.qmail@web12202.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> I am in the process of updating the tascam us-428
> patch for alsa-current and need some hints:
> formerly the snd-usb-us428 issued
> "request_module( "snd-usb-midi");"
> to load that module. this doesn't work with
> alsa-current anymore as the snd-usb-audio
> initialisation, which is triggered, conflicts with the
> initialisation of snd-usb-us428.
> thus I deleted that "request_module( "snd-usb-midi");"
> from snd_usb_us428.

snd-usb-midi isn't anymore an independent driver, it has been integrated
into snd-usb-audio (as you've seen), although it's still a separate
module. In theory, it may be possible to do the same stuff as
snd_usb_create_midi_interface() to make it load correctly.

IMHO the "best" solution would be to add a quirk to usbaudio.c, instead of
writing an entirely separate driver with most of the code duplicated. I
didn't look at your patch in full length, but it seems to me that the
changes needed would be firmware loading (best done in a separate driver
or a userspace program) and adding some information about supported audio
formats/bitrates. (I'm sure I've missed something. :)

> I remember from some Mail on this list, that
> snd-usb-midi  would be autoloaded if a users process
> accesses a mididevice, which has been created by
> "snd_seq_device_new( ...SNDRV_SEQ_DEV_ID_USBMIDI)".
> this does not happen here now.

Autoloading happens if there is an alias for snd-card-x (x derived from
the client number) in modules.conf, and if the card driver calls
snd_seq_device_new() for the sequencer driver. (BTW: there was a bug with
autoloading sequencer drivers which has been fixed yesterday)


HTH Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
