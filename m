From: Thomas Rabe <raven@drehmoment.org>
Subject: questions about usbmidi
Date: Wed, 09 Apr 2003 15:01:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E941991.7080000@drehmoment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

hello,

I try to hack a little bit on Karstens tascam-us428 alsa patch and have 
some problems to integrate usbmidi (usbaudio works). in the patch 
(written for alsa rc3?) this was done with:

8<-----------------------------------------------------------
static int snd_us428_create_usbmidi( snd_card_t* card )
{
#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
         static snd_usb_audio_quirk_t quirk = {
                 .vendor_name =  "TASCAM",
                 .product_name = "US-428",
                 .ifnum =        0,
                 .endpoints = {{
                         .epnum =        6,
                         .out_cables =   3,
                         .in_cables =    3
                         }}
         };
         snd_seq_device_t *seq_device;
         snd_usb_midi_t *umidi;
         int err;

         err = snd_seq_device_new( card, us428( card)->chip.next_seq_device,
                                  SNDRV_SEQ_DEV_ID_USBMIDI,
                                  sizeof(snd_usb_midi_t), &seq_device);
         if (err < 0)
                 return err;
         us428( card)->chip.next_seq_device++;
         strcpy(seq_device->name, card->shortname);
         umidi = (snd_usb_midi_t *)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
         umidi->chip = &us428( card)->chip;
         umidi->ifnum = 0;
         umidi->quirk = &quirk;
         umidi->seq_client = -1;
#endif
         return 0;
}

8<------------------------------------------------------------------

i changed this to:
8<----------------------------------------------------------------
static int snd_us428_create_usbmidi( snd_card_t* card )
{
#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
	static snd_usb_audio_quirk_t quirk = {
		.vendor_name =	"TASCAM",
		.product_name =	"US-428",
		.ifnum = 	0,
        		.type = QUIRK_MIDI_FIXED_ENDPOINT,
		.data = & (const snd_usb_midi_endpoint_info_t) {
        		  .out_ep =0x06,
		  .in_ep = 0x86,
			.out_cables =	0x003,
			.in_cables =	0x003
			}
	};

	int err;

	err = snd_usb_create_midi_interface(&us428( card)->chip, us428( 
card)->chip.dev->actconfig->interface , &quirk);
         if (err < 0)
           return err;

#endif
	return 0;
}
8<--------------------------------------------------------------------

but if i insert the module with modprobe i get segfault + kernel oops. 
what should be wrong?
is it a good idea to link against usbmidi.o? (the us428 is non standard 
audio/midi device).
btw: karstens original code is available at
http://hal9000.drehmoment.org/tascam



Greetings,

Thomas Rabe.



-- mail: raven at drehmoment dot org
-- home: http://hal9000.drehmoment.org
-- more: http://drehmoment.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
