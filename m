From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Tue, 15 Oct 2002 19:27:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021015172751.82908.qmail@web12208.mail.yahoo.com>
References: <Pine.HPX.4.33n.0210151659320.6379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210151659320.6379-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch schrieb: 
> karsten wiese wrote:
> > I am in the process of updating the tascam us-428
> > patch for alsa-current and need some hints:
> > formerly the snd-usb-us428 issued
> > "request_module( "snd-usb-midi");"
> > to load that module. this doesn't work with
> > alsa-current anymore as the snd-usb-audio
> > initialisation, which is triggered, conflicts with
> the
> > initialisation of snd-usb-us428.
> > thus I deleted that "request_module(
> "snd-usb-midi");"
> > from snd_usb_us428.
> 
> snd-usb-midi isn't anymore an independent driver, it
> has been integrated
> into snd-usb-audio (as you've seen), although it's
> still a separate
> module. In theory, it may be possible to do the same
> stuff as
> snd_usb_create_midi_interface() to make it load
> correctly.
here is the routine that is used in snd-usb-us428:
static int snd_us428_create_usbmidi( snd_card_t* card
)
{
#if defined(CONFIG_SND_SEQUENCER) ||
defined(CONFIG_SND_SEQUENCER_MODULE)
	static snd_usb_audio_quirk_t quirk = {
		.vendor_name =	"TASCAM",
		.product_name =	"US-428",
		.ifnum = 	0,
		.type = QUIRK_MIDI_FIXED_ENDPOINT,
		.data = & (const snd_usb_midi_endpoint_info_t) {
			.epnum =	6,
			.out_cables =	3,
			.in_cables =	3
			}
	};
	snd_seq_device_t *seq_device;
	snd_usb_midi_t *umidi;
	int err;

	err = snd_seq_device_new( card, us428(
card)->chip.next_seq_device,
				 SNDRV_SEQ_DEV_ID_USBMIDI,
				 sizeof(snd_usb_midi_t), &seq_device);
	if (err < 0)
		return err;
	us428( card)->chip.next_seq_device++;
	strcpy(seq_device->name, card->shortname);
	umidi = (snd_usb_midi_t
*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
	umidi->chip = &us428( card)->chip;
	umidi->ifnum = 0;
	umidi->quirk = &quirk;
	umidi->seq_client = -1;
#endif
	return 0;
}
its a copy-change of usb-audio. something wrong here ?
cannot be completely wrong: if snd-usb-midi is loaded
manually,
everything works ok.

> 
> IMHO the "best" solution would be to add a quirk to
> usbaudio.c, instead of
> writing an entirely separate driver with most of the
> code duplicated. I
> didn't look at your patch in full length, but it
> seems to me that the
> changes needed would be firmware loading (best done
> in a separate driver
> or a userspace program) and adding some information
> about supported audio
> formats/bitrates. (I'm sure I've missed something.
> :)
the us-428 audio is very nonstandard:
it is necessary to know how many frames are just
recorded to be able to playback without unwanted
crackles. I found no other way to determine the exact
samplerate. furthermore there are the hardware knobs,
sliders and lights, the digital in switch....

> 
> > I remember from some Mail on this list, that
> > snd-usb-midi  would be autoloaded if a users
> process
> > accesses a mididevice, which has been created by
> > "snd_seq_device_new(
> ...SNDRV_SEQ_DEV_ID_USBMIDI)".
> > this does not happen here now.
> 
> Autoloading happens if there is an alias for
> snd-card-x (x derived from
> the client number) in modules.conf, and if the card
> driver calls
> snd_seq_device_new() for the sequencer driver. (BTW:
> there was a bug with
> autoloading sequencer drivers which has been fixed
> yesterday)
mmh, i just checked again my tree: it is current.
I put a line 
"alias snd-card-1 snd-usb-midi" 
(the us-428 is my second card) 
into modules.conf. is it this what you suggest?
unfortunately the autoload still does not happen.
Trying to start the Synth with:
"./startBristol -alsa -audiodev hw:1 -mididev hw:1"
snd-usb-midi is still not loaded and the error message
is:
"ALSA lib rawmidi_hw.c:227:(snd_rawmidi_hw_open) open
/dev/snd/midiC1D0 failed: No such file or directory"
Could somebody please explain, how a specific midi
module gets loaded on a user processes access of an
alsa (raw)midi device ?

Karsten



__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
