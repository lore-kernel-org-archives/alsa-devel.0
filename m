From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] MIDI driver for Behringer BCD2000 USB
	device
Date: Wed, 05 Feb 2014 11:54:05 +0100
Message-ID: <52F2184D.9060209@zonque.org>
References: <1391284482-7577-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F94B2625F7
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 11:54:12 +0100 (CET)
In-Reply-To: <1391284482-7577-1-git-send-email-dev@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mario,

Thanks for your contribution! I'll comment inline.

On 02/01/2014 08:54 PM, Mario Kicherer wrote:
> diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
> new file mode 100644
> index 0000000..100c39f
> --- /dev/null
> +++ b/sound/usb/bcd2000/bcd2000.c

> +#ifdef CONFIG_USB_DEBUG
> +#define DEBUG	1
> +#else
> +#define DEBUG	0
> +#endif

Please use the define directly instead of introducing a new one.

> +MODULE_DEVICE_TABLE (usb, id_table);
> +MODULE_AUTHOR("Mario Kicherer, dev@kicherer.org");
> +MODULE_DESCRIPTION("Behringer BCD2000 driver");
> +MODULE_LICENSE("GPL");

You can move those lines to the very end of the file, which is slightly
more common.

> +static int debug = 0;
> +module_param(debug, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(debug, "enable debug output (default: 0)");
> +
> +static unsigned char set_led_prefix[] = {0x03, 0x00};
> +
> +static unsigned char bcd2000_init_sequence[] = {
> +	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
> +	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
> +	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
> +	0x18, 0xfa, 0x11, 0xff};

Your patch has a huge number of style issues, which
scripts/checkpatch.pl will point you to. I got:

total: 743 errors, 96 warnings, 656 lines checked

Can you fix them up an resend please?

> +struct bcd2000 {
> +	struct usb_device *dev;
> +	struct snd_card *card;
> +	struct usb_interface *intf;
> +	int card_index;
> +	struct snd_pcm *pcm;
> +	struct list_head midi_list;
> +	spinlock_t lock;
> +	struct mutex mutex;
> +	
> +	int midi_out_active;
> +	struct snd_rawmidi *rmidi;
> +	struct snd_rawmidi_substream *midi_receive_substream;
> +	struct snd_rawmidi_substream *midi_out_substream;
> +	
> +	unsigned char midi_in_buf[BUFSIZE];
> +	unsigned char midi_out_buf[BUFSIZE];
> +	
> +	unsigned char midi_cmd_buf[3];
> +	unsigned char midi_cmd_offset;
> +	
> +	struct urb * midi_out_urb;
> +	struct urb * midi_in_urb;
> +};
> +
> +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
> +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
> +static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
> +
> +static DEFINE_MUTEX(devices_mutex);
> +static unsigned int devices_used;
> +static struct usb_driver bcd2000_driver;
> +

...

> +static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream, int up)
> +{
> +	struct bcd2000 *bcd2k = substream->rmidi->private_data;
> +	
> +	if (!bcd2k)
> +		return;
> +	
> +	bcd2k->midi_receive_substream = up ? substream : NULL;
> +}
> +
> +static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
> +					const unsigned char *buf, int len)
> +{
> +	unsigned char length, cmd, buf_offset, tocopy;
> +	int ret;
> +	
> +	if (!bcd2k->midi_receive_substream)
> +		return;
> +	
> +	if (DEBUG || debug) {
> +		printk(KERN_DEBUG PREFIX "received (%d bytes): ", len);
> +		for (ret=0; ret < len; ret++) {
> +			printk("%x ", buf[ret]);
> +		}
> +		printk("\n");
> +	}

We have kernel functions in lib/hexdump.c for this.

> +	
> +	if (len < 2)
> +		return;
> +	
> +	/*
> +	 * The BCD2000 sends MIDI commands with 2 or 3 bytes length. In case of
> +	 * 2 bytes, the command is the same as before.
> +	 *
> +	 * Packet structure: mm nn oo (pp)
> +	 *	mm: payload length
> +	 *	nn: MIDI command or note
> +	 *	oo: note or velocity
> +	 *	pp: velocity
> +	 */
> +	
> +	length = buf[0];
> +	
> +	/* ignore packets without payload, should not happen */
> +	if (length == 0)
> +		return;
> +	
> +	/*
> +	 * The MIDI packets the BCD2000 sends can be arbitrarily truncated or
> +	 * concatenated. Therefore, this loop accumulates the bytes from the
> +	 * input buffer until a full valid MIDI packet is in the MIDI command
> +	 * buffer "midi_cmd_buf".
> +	 */
> +	
> +	buf_offset = 1;
> +	while (buf_offset <= length) {
> +		cmd = buf[buf_offset];
> +		
> +		if (bcd2k->midi_cmd_offset == 0 && cmd != 0x90 && cmd != 0xb0) {
> +			/*
> +			 * this is a 2-byte midi packet -> reuse command byte from
> +			 * last midi packet
> +			 */
> +			bcd2k->midi_cmd_offset = 1;
> +		}
> +		
> +		/* determine the number of bytes we want to copy this time */
> +		tocopy = min( 3 - bcd2k->midi_cmd_offset, length - (buf_offset - 1));
> +		
> +		if (tocopy > 0) {

tocopy is unsigned char, so this check is always true, and the copy
routine can overflow in case bcd2k->midi_cmd_offset < 3.

> +			memcpy(&bcd2k->midi_cmd_buf[bcd2k->midi_cmd_offset],
> +				&buf[buf_offset], tocopy);
> +		} else
> +			printk(KERN_ERR PREFIX "error parsing\n");
> +		
> +		bcd2k->midi_cmd_offset += tocopy;
> +		buf_offset += tocopy;
> +		
> +		/* is our MIDI packet complete? */
> +		if (bcd2k->midi_cmd_offset == 3) {
> +			if (DEBUG || debug) {
> +				printk(KERN_DEBUG PREFIX "send midi packet (%d bytes): ",
> +						bcd2k->midi_cmd_offset);
> +				for (ret=0;ret< bcd2k->midi_cmd_offset;ret++) {
> +					printk("%x ", bcd2k->midi_cmd_buf[ret]);
> +				}
> +				printk("\n");
> +			}

See above.

> +static void bcd2000_midi_send(struct bcd2000 *bcd2k,
> +				struct snd_rawmidi_substream *substream)
> +{
> +	int len, ret;
> +	
> +	/* copy the "set LED" command bytes */
> +	memcpy(bcd2k->midi_out_buf, set_led_prefix, sizeof(set_led_prefix));

Add a BUILD_BUG_ON() here to make sure sizeof(set_led_prefix) is never
bigger than you static buffer.

> +	if (DEBUG || debug) {
> +		printk(KERN_DEBUG PREFIX "sending: ");
> +		for (ret=0;ret< 3 + len;ret++) {
> +			printk("%x ", bcd2k->midi_out_buf[ret]);
> +		}
> +		printk("\n");
> +	}

See above.

> +	/* send packet to the BCD2000 */
> +	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_ATOMIC);
> +	if (ret < 0) {
> +		printk(KERN_ERR PREFIX
> +			   "bcd2000_midi_send(%p): usb_submit_urb() failed,"
> +			   "ret=%d, len=%d: ", substream, ret, len);
> +		switch (ret) {
> +			case -ENOMEM: printk("ENOMEM\n"); break;
> +			case -ENODEV: printk("ENODEV\n"); break;
> +			case -ENXIO: printk("ENXIO\n"); break;
> +			case -EINVAL: printk("EINVAL\n"); break;
> +			case -EAGAIN: printk("EAGAIN\n"); break;
> +			case -EFBIG: printk("EFBIG\n"); break;
> +			case -EPIPE: printk("EPIPE\n"); break;
> +			case -EMSGSIZE: printk("EMSGSIZE\n"); break;
> +			default: printk("\n");

That you'll fix when following the checkpatch.pl complaints :)

> +	bcd2k->midi_out_active = 0;
> +	if (urb->status != 0) {
> +		printk(KERN_ERR PREFIX "urb status: %d\n", urb->status);

Try to avoid printk() and use snd_printk() or dev_err() instead.

...

> +/*
> + * general part
> + */
> +
> +static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
> +						struct usb_interface *interface)
> +{
> +	unsigned int i;
> +	struct usb_interface *intf;
> +	
> +// 	mutex_lock(&ua->mutex);
> +// 	free_stream_urbs(&ua->capture);
> +// 	free_stream_urbs(&ua->playback);
> +// 	mutex_unlock(&ua->mutex);
> +// 	free_stream_buffers(ua, &ua->capture);
> +// 	free_stream_buffers(ua, &ua->playback);

Please, no dead code. Remove those lines entirely if you don't need them.

> +	for (i = 0; i < 1; ++i) {

Why do you need a loop if it only runs once!?

> +		mutex_lock(&bcd2k->mutex);
> +		intf = bcd2k->intf;
> +		bcd2k->intf = NULL;
> +		mutex_unlock(&bcd2k->mutex);
> +		if (intf) {
> +			usb_set_intfdata(intf, NULL);
> +			if (intf != interface)
> +				usb_driver_release_interface(&bcd2000_driver,
> +								intf);
> +		}
> +	}
> +}
> +
> +static void bcd2000_card_free(struct snd_card *card)
> +{
> +// 	struct bcd2000 *bcd2k = card->private_data;
> +// 	mutex_destroy(&ua->mutex);

Remove dead code.

> +}
> +
> +static int bcd2000_probe(struct usb_interface *interface, const struct usb_device_id *usb_id)
> +{
> +	struct snd_card *card;
> +	struct bcd2000 * bcd2k;
> +	unsigned int card_index;
> +	char usb_path[32];
> +	int err;
> +	
> +	
> +	mutex_lock(&devices_mutex);
> +	
> +	for (card_index = 0; card_index < SNDRV_CARDS; ++card_index)
> +		if (enable[card_index] && !(devices_used & (1 << card_index)))
> +			break;
> +	if (card_index >= SNDRV_CARDS) {
> +		mutex_unlock(&devices_mutex);
> +		return -ENOENT;
> +	}
> +	err = snd_card_create(index[card_index], id[card_index], THIS_MODULE,
> +					sizeof(*bcd2k), &card);
> +	if (err < 0) {
> +		mutex_unlock(&devices_mutex);
> +		return err;
> +	}
> +	card->private_free = bcd2000_card_free;
> +	bcd2k = card->private_data;
> +	bcd2k->dev = interface_to_usbdev(interface);
> +	bcd2k->card = card;
> +	bcd2k->card_index = card_index;
> +	INIT_LIST_HEAD(&bcd2k->midi_list);
> +	spin_lock_init(&bcd2k->lock);
> +	mutex_init(&bcd2k->mutex);
> +	
> +// 	INIT_LIST_HEAD(&bcd2k->ready_playback_urbs);
> +// 	tasklet_init(&bcd2k->playback_tasklet,
> +// 				playback_tasklet, (unsigned long)bcd2k);
> +// 	init_waitqueue_head(&bcd2k->alsa_capture_wait);
> +// 	init_waitqueue_head(&bcd2k->rate_feedback_wait);
> +// 	init_waitqueue_head(&bcd2k->alsa_playback_wait);

Dito.

> +	bcd2k->intf = interface;
> +	
> +	snd_card_set_dev(card, &interface->dev);
> +	
> +	strcpy(card->driver, DEVICE_NAME);
> +	strcpy(card->shortname, DEVICE_SHORTNAME);
> +	usb_make_path(bcd2k->dev, usb_path, sizeof(usb_path));
> +	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
> +		    DEVICE_NAME ", at %s, %s speed",
> +				usb_path,
> +				bcd2k->dev->speed == USB_SPEED_HIGH ? "high" : "full");
> +	
> +	printk(KERN_INFO PREFIX "%s", bcd2k->card->longname);
> +	
> +// 	err = alloc_stream_buffers(bcd2k, &bcd2k->capture);
> +// 	if (err < 0)
> +// 		goto probe_error;
> +// 	err = alloc_stream_buffers(bcd2k, &bcd2k->playback);
> +// 	if (err < 0)
> +// 		goto probe_error;
> +// 	
> +// 	err = alloc_stream_urbs(bcd2k, &bcd2k->capture, capture_urb_complete);
> +// 	if (err < 0)
> +// 		goto probe_error;
> +// 	err = alloc_stream_urbs(bcd2k, &bcd2k->playback, playback_urb_complete);
> +// 	if (err < 0)
> +// 		goto probe_error;
> +// 	
> +// 	err = snd_pcm_new(card, "bcd2000", 0, 1, 1, &bcd2k->pcm);
> +// 	if (err < 0)
> +// 		goto probe_error;
> +// 	bcd2k->pcm->private_data = bcd2k;
> +// 	strcpy(bcd2k->pcm->name, "bcd2000");
> +// 	snd_pcm_set_ops(bcd2k->pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_pcm_ops);
> +// 	snd_pcm_set_ops(bcd2k->pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_pcm_ops);
> +	
> +// 	err = snd_usbmidi_create(card, bcd2k->intf,
> +// 						&bcd2k->midi_list, &midi_quirk);
> +// 	if (err < 0)
> +// 		goto probe_error;

Dito.

I'll do another review once those issues are addressed.


Thanks,
Daniel
