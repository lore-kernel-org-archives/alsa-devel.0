From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Add M2Tech hiFace USB-SPDIF driver
Date: Mon, 11 Feb 2013 09:53:26 +0100
Message-ID: <5118B186.1020801@ladisch.de>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 7BE5E260317
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 09:53:30 +0100 (CET)
In-Reply-To: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Antonio Ospite wrote:
> I also noticed that many drivers under sound/usb/ have text in the Kconfig
> entry stating "Say Y here to include support for ..." but I only see "[N/m/?]"
> as options when I run "make oldconfig" maybe because of some dependency, I am
> not sure, should such text be removed in order to avoid confusion?

It allows only "m" for "module" because some dependencies already
are modules.

> +++ b/sound/usb/Kconfig
> +...
> +	  M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
> +	  Interface, see http://www.m2tech.biz/hiface.html

This sentence is not necessary for someone to decide whether to enable
this Kconfig option, so it doesn't belong here.

> +++ b/sound/usb/hiface/chip.c
> ...
> +MODULE_SUPPORTED_DEVICE("{{HiFace, Evo}}");

MODULE_SUPPORTED_DEVICE isn't actually used at the moment, but if you
use it, you should include all supported devices.  Or is this a name
for the entire family?

(But I guess the name is "Evo", not " Evo".)

> +	if (quirk && quirk->device_name)
> +		strcpy(card->shortname, quirk->device_name);
> +	else
> +		strcpy(card->shortname, "M2Tech generic audio");

Don't the devices have their name in the device descriptor?

> +	sprintf(card->longname, "%s at %d:%d", card->shortname,
> +			device->bus->busnum, device->devnum);

It is common to use usb_make_path() to show where the device is
connected, but this is more or less meaningless either way.  :)

> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);

If you pass sizeof(*chip) as the fourth parameter to snd_card_create(),
it will be allocated and freed automatically together with the card
(as card->private_data) so that you don't need to create a separate
device.

> +static int hiface_chip_probe(struct usb_interface *intf,
> +			     const struct usb_device_id *usb_id)
> +...
> +	pr_info("Probe " DRIVER_NAME " driver.\n");

This doesn't belong into the finished driver.

> +static struct usb_device_id device_table[] = {

This can be made const.

> +++ b/sound/usb/hiface/pcm.c
> +#define PCM_MAX_PACKET_SIZE 4096

Why "MAX" when the packets are never smaller?

> +static struct snd_pcm_hw_constraint_list constraints_rates = {

This should be const.

> +static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
> +{
> +	u8 rate_value[] = { 0x43, 0x4b, 0x42, 0x4a, 0x40, 0x48, 0x58, 0x68 };

static const

> +	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0),
> +				0xb0,
> +				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> +				rate_value[rt->rate], 0, NULL, 0, 100);

You must not do DMA from either the stack or from static module data, so
you have to copy this byte into kmalloc'ed memory (like snd_usb_ctl_msg()
does).

> +void memcpy_swahw32(u8 *dest, u8 *src, unsigned int n)

static

> +static int hiface_pcm_playback(struct pcm_substream *sub,
> +		struct pcm_urb *urb)
> +{
> +	/* XXX Can an invalid format make it to here?

No.

> +static void hiface_pcm_out_urb_handler(struct urb *usb_urb)
> +{
> +	if (usb_urb->status || rt->panic || rt->stream_state == STREAM_STOPPING)
> +		return;

In some error cases, you might consider stopping the stream.

> +		ret = hiface_pcm_playback(sub, out_urb);
> +		if (ret < 0) {
> +			spin_unlock_irqrestore(&sub->lock, flags);
> +			goto out_fail;
> +		}
> +...
> +out_fail:
> +	usb_submit_urb(&out_urb->instance, GFP_ATOMIC);

Same here.

> +static int hiface_pcm_open(struct snd_pcm_substream *alsa_sub)
> +{
> +		/* XXX can we avoid setting hw.rates below?

You must set hw.rates to all the rates supported by this particular
device.

The KNOT flag overrides all others flags and requires a separate
constraints to describe the valid rates.

You could either

for 192 kHz devices: set the 44100...192000 flags and install no
                     constraint, while
for 384 kHz devices: set the KNOT flag and install the 44.1...384 rate
                     constraint;

or, alternatively,

for 192 kHz devices: set the KNOT flag and install a 44.1...192 rate
                     constraint, while
for 384 kHz devices: set the KNOT flag and install a 44.1...384 rate
                     constraint.

> +		 * Maybe the 6fire driver was setting alsa_rt->hw.rates in
> +		 * order to have the playback stream and the capture stream
> +		 * use the same rate?

Yes.

> +		constraints_rates.count = ARRAY_SIZE(rates);

This does not work if contraints_rates is shared by two different
devices.  Use two snd_pcm_hw_constraint_list instances.

> +void hiface_pcm_abort(struct hiface_chip *chip)
> +{
> +			snd_pcm_stop(rt->playback.instance,
> +					SNDRV_PCM_STATE_XRUN);

This requres locking the stream with something like
snd_pcm_stream_lock_irq().


Regards,
Clemens
