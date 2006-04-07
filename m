From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: driver for Native Instruments' audio devices
Date: Fri, 07 Apr 2006 11:24:32 +0200
Message-ID: <20060407092432.GB4670@turing.informatik.uni-halle.de>
References: <2C67C334-1C47-497E-87CB-974D1853F3FF@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <2C67C334-1C47-497E-87CB-974D1853F3FF@caiaq.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> here's my first shot of a driver for the new audio devices produced
> by Native Instruments such as RigKontrol2 and Kore controller.
> 
> The patchset should cleanly apply to the current CVS. I also tried to
> keep to the coding style as close as possible ;)

You should have tried to use the coding style to be used for kernel code
and not the style of existing ALSA code ...   ;-)

> +++ alsa-kernel/usb/Kconfig
> +config SND_USB_CAIAQ
> +	tristate "caiaq/NativeInstruments USB audio devices"
> +	depends on SND && USB && (X86 || PPC || ALPHA)

Is there a reason why it shouldn't work on other architectures?

> +++ alsa-kernel/usb/caiaq/caiaq-audio.c
> ...
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/interrupt.h>
> +#include <linux/usb.h>
> +#include <sound/driver.h>

Please put <sound/driver.h> at the top because it contains compatibility
workaround for older kernels.

> +#define MAX(a,b) (((a)>(b))?(a):(b))

Please use the kernel's max().

> +static struct snd_pcm_hardware snd_usb_caiaq_pcm_hardware = {
> +	.info 		= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER),
 
This line is longer than 80 characters.  Do as I say, not as I do.  ;)

> +	.buffer_bytes_max = 32768,
> +	.period_bytes_min = 4096,
> +	.period_bytes_max = 32768,

Is there any reason for these limits?

It should be possible to have a one second buffer, and periods of about
one millisecond.

> +static void stream_start(void *d)
> ...
> +		ret = usb_submit_urb(dev->data_urbs_in[i], GFP_KERNEL);
> +		if (ret < 0)
> +			log("unable to trigger initial read #%d! (ret = %d)\n", i, ret);

You should abort with an error if the submit fails.

> +static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *substream,
> ...
> +		case SNDRV_PCM_TRIGGER_START:
> +		case SNDRV_PCM_TRIGGER_RESUME:
> ...
> +		case SNDRV_PCM_TRIGGER_STOP:
> +		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:

I guess you wanted to implement PAUSE_RELEASE instead of RESUME.

I'm not sure that implementing pausing in this way is correct -- killing
the URBs will throw away some data instead of stopping at the current
position.

What happens when both playback and capture streams are used?

> +snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *substream)
> +...
> +	if (dev->pcm_sub_playback)
> +		return bytes_to_frames(dev->pcm_sub_playback->runtime, dev->audio_out_buf_pos);
> +	if (dev->pcm_sub_capture)
> +		return bytes_to_frames(dev->pcm_sub_capture->runtime, dev->audio_in_buf_pos);

Shouldn't there be a pointer callback for each direction?

> +static void free_urbs(struct urb **urbs)
> +...
> +	if (urbs[i]->transfer_buffer) {
> +		kfree(urbs[i]->transfer_buffer);
> +		urbs[i]->transfer_buffer = NULL;
> +	}

You don't need to check for NULL before calling kfree(), and it isn't
necessary to clear the pointer afterwards.

> +	urbs[i] = NULL;

Ditto.

> +int __devinit snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
> +...
> +	ret = snd_pcm_new(dev->chip.card, dev->product_name, 0, 
> +			dev->n_streams, dev->n_streams, &pcm);

I think additional streams should be made available as separate PCM
devices and not as substreams, because those streams would be
independent of each other.

Are there any devices with more than one stream?

> +++ alsa-kernel/usb/caiaq/caiaq-device.c
> ...
> +MODULE_SUPPORTED_DEVICE("{{NI(0x17cc), (0x1969)(0x4711) }}");

Please put the real name in there.

> +static void usb_ep1_command_reply_dispatch (struct urb* urb, struct pt_regs *regs)
> +...
> +	if (urb->status != 0)
> +		return;

This will abort all MIDI input processing whenever an error occurs.
This function should at least try to resubmit the URB (probably after a
short pause to avoid error floods when unplugging; see usbmidi.c).

> +static int send_command (struct snd_usb_caiaqdev *dev,
> ...
> +	char tmp[EP1_BUFSIZE];
> +	ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, 1),
> +			   tmp, len+1, &actual_len, 200);

On some architectures, it is not possible to do DMA from the stack.

> +	sprintf(card->longname, "%s %s (USB ID %04x/%04x, serial %s)", 

The USB vendor/product IDs aren't very useful here because they're
available in other files.  Please consider using usb_make_path().

> +++ alsa-kernel/usb/caiaq/caiaq-device.h
> +struct snd_usb_caiaqdev {
> +	struct urb *ep1_in_urb;
> +	struct urb *midi_out_urb;
> +	struct urb **data_urbs_in;
> +	struct urb **data_urbs_out;
> +
> +	struct snd_usb_caiaq_cb_info *data_cb_info;
> +	
> +	unsigned char *ep1_in_buf;
> +	unsigned char *midi_out_buf;

The size of all these variables is known; none of them needs to be
allocated dynamically.

> +++ alsa-kernel/usb/caiaq/caiaq-midi.c
> +int __devinit snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *device)
> +	ret = snd_rawmidi_new(device->chip.card, device->product_name, 0,
> +					device->spec.num_midi_out,
> +					device->spec.num_midi_in,
> +					&rmidi);

Are there devices with more than one MIDI port?

> +	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;

INFO_DUPLEX only makes sense when both _OUTPUT and _INPUT are set.

> +void snd_usb_caiaq_midi_output_done(struct urb* urb, struct pt_regs *regs)

This function doesn't continue sending when there are more than
EP1_BUFSIZE-3 bytes of MIDI data to be sent.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
