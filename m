From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Thu, 04 Jul 2002 13:52:17 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0207041308380.15122-100000@studcom.urz.uni-halle.de>
References: <s5hznx7rfik.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznx7rfik.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> i changed virmidi codes for easier use, and added
> snd_virmidi_receive() to usbmidi.c.
> could you check the updated driver?

It is obvious that you have not been able to check it.  :-)

My snd_usbmidi_port_input() function actually does the _output_ (I named
it 'input' because it began its life as the function to be assigend to
port_callback.event_input -- well, that's input _to_ the usb-midi port.
A better name for it would be snd_usbmidi_event_for_output).

The call to snd_virmidi_receive() should go into snd_usbmidi_input_packet.

And now it turns out that moving the rmidi pointer from the input to the
output endpoint structure was rather stupid by me because rmidi is needed
for input only. That change needs to be reverted, too.

The virmidi creation in snd_usbmidi_create_endpoint_ports should look like
the following: (warning: untested and made by hand because I don't have
access to my Linux box right now. patch probably won't accept those line
numbers! :-)


@@ at the end of snd_usbmidi_create_endpoint_ports
	if (in)
		umidi->in_endpoints[ep]->ports[c].seq_port = port;

-	if (out && *port_idx < SNDRV_MINOR_RAWMIDIS) {
+	if (in && *port_idx < SNDRV_MINOR_RAWMIDIS) {
		snd_rawmidi_t *rmidi;
		snd_virmidi_dev_t *rdev;
		err = snd_virmidi_new(umidi->card, *port_idx, &rmidi);
@@ a few lines later
			snd_device_free(umidi->card, rmidi);
			return err;
		}
-		umidi->out_endpoints[ep]->ports[out_port].rmidi = rmidi;
+		umidi->in_endpoints[ep]->ports[c].rmidi = rmidi;
	}
	if (out)
		++out_port;


This will not create virmidi ports for output only ports, but it should
actually work for the rest. :)

I think I'll be able to submit a patch for storing rmidi independently of
the input/output structures tomorrow.


Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
