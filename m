From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH][ALSA] usbmidi support for Access Music synths.
Date: Thu, 11 Feb 2010 09:46:36 +0100
Message-ID: <4B73C3EC.2040606@ladisch.de>
References: <4B726306.8070506@gmail.com> <4B7274BA.3040801@ladisch.de> <4B73B96A.9040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B73B96A.9040006@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastien Alaiwan <sebastien.alaiwan@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Sebastien Alaiwan wrote:
> Clemens Ladisch wrote:
>> Please run the checkpatch script on your patch.
> 
> Done!
> I did not know such a tool did exist, thank you for pointing this out. Is there
> a document I could read about such rules of thumb?

Documentation/CodingStyle
Documentation/SubmitChecklist
Documentation/SubmittingDrivers
Documentation/SubmittingPatches

>> Does this device use more than one endpoint per direction?  If not, this
>> could be done with QUIRK_MIDI_FIXED_ENDPOINT.
> 
> There's only one endpoint per direction, but there are two cables per endpoint:
> endpoint 0x05, cable 0 : physical MIDI output port of the device.
> endpoint 0x05, cable 1 : synth (output: send note-on, etc...)
> endpoint 0x85, cable 0 : physical MIDI input port of the device.
> endpoint 0x85, cable 1 : synth (input: recv sysex, controller changes)
> 
> Please correct me if I'm wrong, but it seems QUIRK_MIDI_FIXED_ENDPOINT would not
> do the job, otherwise where do I signal the number of cables?

With the bits in the out/in_cables fields.

> +	u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 }; /* "midi send" enable */

This should be static const.

> @@ -1407,6 +1407,9 @@ static struct port_info {
>  	EXTERNAL_PORT(0x086a, 0x0001, 8, "%s Broadcast"),
>  	EXTERNAL_PORT(0x086a, 0x0002, 8, "%s Broadcast"),
>  	EXTERNAL_PORT(0x086a, 0x0003, 4, "%s Broadcast"),
> +	/* Access Music Virus TI */
> +	EXTERNAL_PORT(0x133e, 0x0815, 0, "%s MIDI"),
> +	CONTROL_PORT(0x133e, 0x0815, 1, "%s Control"),

According to your description, this is not a control port but should be
called "Synth".  There is no helper macro for a generic MIDI port; use
something like this:

PORT_INFO(0x133e, 0x0815, 1, "%s Synth", numberofvoices,
          SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
          SNDRV_SEQ_PORT_TYPE_MIDI_GM |
          SNDRV_SEQ_PORT_TYPE_HARDWARE |
          SNDRV_SEQ_PORT_TYPE_SYNTHESIZER),

and add flags for any other supported MIDI standards.

> +	/* VirusTI Desktop */
> +	USB_DEVICE_VENDOR_SPEC(0x133e, 0x0815),
> +	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
> +		.data = &(const struct snd_usb_audio_quirk[]) {
> +			{
> +				/* "Virus TI MIDI" and "Virus TI Synth" */
> +				.ifnum = 3,
> +				.type = QUIRK_MIDI_ACCESSMUSIC,
> +			},
> +			{
> +				.ifnum = -1
> +			}
> +		}
> +	}
> +},

For only one interface, you don't need to use QUIRK_COMPOSITE; see the
entry for the UM-880.


Regards,
Clemens
