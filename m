From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] Add M2Tech hiFace USB-SPDIF driver
Date: Tue, 12 Feb 2013 13:35:21 +0100
Message-ID: <20130212133521.39628e4aef556560b8b14dd8@studenti.unina.it>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <5118B186.1020801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F0952650D3
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 13:35:26 +0100 (CET)
In-Reply-To: <5118B186.1020801@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Feb 2013 09:53:26 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Antonio Ospite wrote:
> > I also noticed that many drivers under sound/usb/ have text in the Kconfig
> > entry stating "Say Y here to include support for ..." but I only see "[N/m/?]"
> > as options when I run "make oldconfig" maybe because of some dependency, I am
> > not sure, should such text be removed in order to avoid confusion?
> 
> It allows only "m" for "module" because some dependencies already
> are modules.
>

Right, but should the sentence about "Say Y..." be removed here and in
the other drivers? It's not alway true and it may sound a little off
when "Y" is not actually available; not a big deal anyway, I noticed it
and I just wanted to mention it.

> > +++ b/sound/usb/Kconfig
> > +...
> > +	  M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
> > +	  Interface, see http://www.m2tech.biz/hiface.html
> 
> This sentence is not necessary for someone to decide whether to enable
> this Kconfig option, so it doesn't belong here.
>

OK, I'll put that in the commit message only.

> > +++ b/sound/usb/hiface/chip.c
> > ...
> > +MODULE_SUPPORTED_DEVICE("{{HiFace, Evo}}");
> 
> MODULE_SUPPORTED_DEVICE isn't actually used at the moment, but if you
> use it, you should include all supported devices.  Or is this a name
> for the entire family?
> 
> (But I guess the name is "Evo", not " Evo".)
>

OK, I'll list all supported devices following the format used in
sound/usb/caiaq/device.c, which AFAICS is "{Manufacturer, Device Name}"
for each entry, that is still with a leading space before the device
name, or is that wrong in your opinion?

> > +	if (quirk && quirk->device_name)
> > +		strcpy(card->shortname, quirk->device_name);
> > +	else
> > +		strcpy(card->shortname, "M2Tech generic audio");
> 
> Don't the devices have their name in the device descriptor?
>

It looks like the iProduct field is not reliable enough, different
devices could have the same value there.

> > +	sprintf(card->longname, "%s at %d:%d", card->shortname,
> > +			device->bus->busnum, device->devnum);
> 
> It is common to use usb_make_path() to show where the device is
> connected, but this is more or less meaningless either way.  :)
>

:) right, I'll use usb_make_path(), tho; thanks.
 
> > +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> 
> If you pass sizeof(*chip) as the fourth parameter to snd_card_create(),
> it will be allocated and freed automatically together with the card
> (as card->private_data) so that you don't need to create a separate
> device.
>

OK, during development I had some other cleanups done in
hiface_dev_free(), that's why I started using the explicit
mechanism; then hiface_dev_free() was later simplified to just call
kfree(), so now I can use the implicit mechanism, thanks for pointing
that out.

> > +static int hiface_chip_probe(struct usb_interface *intf,
> > +			     const struct usb_device_id *usb_id)
> > +...
> > +	pr_info("Probe " DRIVER_NAME " driver.\n");
> 
> This doesn't belong into the finished driver.
>

OK. I can downgrade it to pr_debug().

> > +static struct usb_device_id device_table[] = {
> 
> This can be made const.
>

OK.

> > +++ b/sound/usb/hiface/pcm.c
> > +#define PCM_MAX_PACKET_SIZE 4096
> 
> Why "MAX" when the packets are never smaller?
>

I will change the name PCM_MAX_PACKET_SIZE to PCM_PACKET_SIZE and while
at it I will also change MAX_BUFSIZE to PCM_BUFFER_SIZE.

> > +static struct snd_pcm_hw_constraint_list constraints_rates = {
> 
> This should be const.
>

OK, this can be const indeed when using the new logic about constraints
that you explain below.

> > +static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
> > +{
> > +	u8 rate_value[] = { 0x43, 0x4b, 0x42, 0x4a, 0x40, 0x48, 0x58, 0x68 };
> 
> static const
>

I will put it outside of the function body too, using symbolic
constants in order to make it more readable.

> > +	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0),
> > +				0xb0,
> > +				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> > +				rate_value[rt->rate], 0, NULL, 0, 100);
> 
> You must not do DMA from either the stack or from static module data, so
> you have to copy this byte into kmalloc'ed memory (like snd_usb_ctl_msg()
> does).
>

Well, your remark is valid for when the "void *data" argument of
usb_control_msg() is used, but I am just using the "value" argument here
which is a single u16 value, not a buffer address. So I think I can
leave this part as is, can't I? The value will be eventually copied into
a usb_ctrlrequest. snd_snd_usb_ctl_msg() dos not touch the "value"
argument either.

> > +void memcpy_swahw32(u8 *dest, u8 *src, unsigned int n)
> 
> static
>

Right, thanks.

> > +static int hiface_pcm_playback(struct pcm_substream *sub,
> > +		struct pcm_urb *urb)
> > +{
> > +	/* XXX Can an invalid format make it to here?
> 
> No.
>

So I can remove the check, thanks, or would it be OK to make it a
WARN_ON or a BUG_ON?

> > +static void hiface_pcm_out_urb_handler(struct urb *usb_urb)
> > +{
> > +	if (usb_urb->status || rt->panic || rt->stream_state == STREAM_STOPPING)
> > +		return;
> 
> In some error cases, you might consider stopping the stream.
>

You mean I should check explicitly for some values of usb_urb->status
and stop the stream if they happen? Like you do in
sound/usb/misc/ua101.c::capture_urb_complete()?

In the other cases this is not needed:

  * if rt->panic is true, then hiface_pcm_abort() has been called
    already which will stop the usb stream too;
  * if rt->stream_state == STREAM_STOPPING then hiface_pcm_stream_stop()
    has been called already.

> > +		ret = hiface_pcm_playback(sub, out_urb);
> > +		if (ret < 0) {
> > +			spin_unlock_irqrestore(&sub->lock, flags);
> > +			goto out_fail;
> > +		}
> > +...
> > +out_fail:
> > +	usb_submit_urb(&out_urb->instance, GFP_ATOMIC);
> 
> Same here.
>

If I remove the check for format in hiface_pcm_playback() then this
label would go away too and this won't be an error path anymore, but
maybe you meant that I need to check the return value of usb_submit_urb
() and stop the stream when the latter fails?

> > +static int hiface_pcm_open(struct snd_pcm_substream *alsa_sub)
> > +{
> > +		/* XXX can we avoid setting hw.rates below?
> 
> You must set hw.rates to all the rates supported by this particular
> device.
> 
> The KNOT flag overrides all others flags and requires a separate
> constraints to describe the valid rates.

I now see how this works in
sound/core/pcm_native.c::snd_pcm_hw_constraints_complete():
when KNOT or CONTINUOUS are specified the constraint on the rates is not
applied.

> You could either
> 
> for 192 kHz devices: set the 44100...192000 flags and install no
>                      constraint, while
> for 384 kHz devices: set the KNOT flag and install the 44.1...384 rate
>                      constraint;
>

I like this one better (default behavior + particular case).

> or, alternatively,
> 
> for 192 kHz devices: set the KNOT flag and install a 44.1...192 rate
>                      constraint, while
> for 384 kHz devices: set the KNOT flag and install a 44.1...384 rate
>                      constraint.
> 
> > +		 * Maybe the 6fire driver was setting alsa_rt->hw.rates in
> > +		 * order to have the playback stream and the capture stream
> > +		 * use the same rate?
> 
> Yes.
>

Either way I do not need to restrict alsa_rt->hw.rates to the
_single_value_ in use in my case, as you specified above; I will just
set it so it contains _all_ the rates supported by the device.

> > +		constraints_rates.count = ARRAY_SIZE(rates);
> 
> This does not work if contraints_rates is shared by two different
> devices.  Use two snd_pcm_hw_constraint_list instances.
>

I didn't consider this case indeed.

> > +void hiface_pcm_abort(struct hiface_chip *chip)
> > +{
> > +			snd_pcm_stop(rt->playback.instance,
> > +					SNDRV_PCM_STATE_XRUN);
> 
> This requres locking the stream with something like
> snd_pcm_stream_lock_irq().
> 

OK, but would you mind elaborating a little more why this is needed?

I do not see other drivers doing that, and BTW I see also that some
other drivers not calling snd_pcm_stop() at all, e.g. it is commented in
sound/usb/endpoint.c::snd_complete_urb().

Thanks for the review Clemens, it's appreciated.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
