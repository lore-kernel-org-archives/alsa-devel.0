From: Matthias Koenig <list@phasorlab.de>
Subject: Re: Re: [PATCH] alsa-driver: Support for ESI Miditerminal 4140 (#2)
Date: Wed, 26 Apr 2006 00:08:53 +0200
Message-ID: <87fyk1l34a.fsf@zebra.localdomain>
References: <87fyk1mztd.fsf@zebra.localdomain> <s5h7j5dzlp4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:
> At Tue, 25 Apr 2006 17:37:18 +0200,
> Matthias Koenig wrote:
>> +static int mts64_device_init(struct parport *p)
>
> You can add __devinit since this is called only from probe function.

Ok

>
>> +{
>> +	int i;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);	
>> +	mts64_write_command(p, MTS64_CMD_RESET);
>> +	local_irq_restore(flags);
>
> Do we need irq_save/restore here?
> I see no possible races around this function.

Hmm, probably you're right.
I'm wondering if we need disabling of interrupts (incl. kernel preemption) 
at all at these places.

>
>
>> +static int mts64_probe(struct parport *p)
>> +{
>> +	unsigned char c;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	mts64_smpte_stop(p);
>> +	mts64_write_command(p, MTS64_CMD_PROBE);
>> +	local_irq_restore(flags);
>
> Ditto.  It's also __devinit function.

Ok

>
>
>> +static int snd_mts64_ctl_smpte_switch_put(struct snd_kcontrol* kctl,
>> +					  struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct mts64 *mts = snd_kcontrol_chip(kctl);
>> +	int changed = 0;
>> +	unsigned long flags;
>> +
>> +	if (mts->smpte_switch == uctl->value.integer.value[0])
>> +		return changed;
>> +
>> +	changed = 1;
>> +	mts->smpte_switch = uctl->value.integer.value[0];
>> +	if (mts->smpte_switch) {
>> +		spin_lock_irqsave(mts->lock, flags);
>
> You need no irqsave in get/put callbacks.  Just use
> spin_lock_irq()/spin_unlock_irq().

Ok

>
>> +static int __devinit snd_mts64_ctl_create(struct snd_card *card, 
>> +					  struct mts64 *mts) 
>> +{
>> +	int err;
>> +
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_switch, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_switch\n");
>> +		return err;
>> +	}
>> +
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_time_hours, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_time_hours\n");
>> +		return err;
>> +	}
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_time_minutes, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_time_minutes\n");
>> +		return err;
>> +	}
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_time_seconds, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_time_seconds\n");
>> +		return err;
>> +	}
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_time_frames, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_time_frames\n");
>> +		return err;
>> +	}
>> +
>> +	err = snd_ctl_add(card, 
>> +			  snd_ctl_new1(&mts64_ctl_smpte_fps, mts));
>> +	if (err < 0) {
>> +		snd_printk("Cannot create control: smpte_fps\n");
>> +		return err;
>> +	}
>
> I myself prefer initializations using a loop and an array.  It'd be
> more simpler.

Agreed, looks nicer.

>
>> +static void snd_mts64_rawmidi_input_trigger(struct snd_rawmidi_substream *substream,
>> +					    int up)
>> +{
>> +	struct mts64 *mts = substream->rmidi->private_data;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(mts->lock, flags);	
>> +	if (up) {
>> +		mts->mode[substream->number] |= MTS64_MODE_INPUT_TRIGGERED;
>> +	} else {
>> +		mts->mode[substream->number] &= ~MTS64_MODE_INPUT_TRIGGERED;
>> +	}
>
> Remove braces here.

Ok

>
>> +static int __devinit snd_mts64_rawmidi_create(struct snd_card *card, 
>> +					      struct mts64 *chip, 
>> +					      struct snd_rawmidi **rrmidi)
>> +{
> (snip)
>> +	/* controls */
>> +	snd_mts64_ctl_create(card, chip);
>
> Should return an error (and free the created rmidi).

Ok

>
>> +static void mts64_interrupt(int irq, void *private, struct pt_regs *r)
>> +{
>> +	struct mts64 *mts = ((struct snd_card*)private)->private_data;
>> +	unsigned short ret;
>> +	unsigned char status, data;
>> +	struct snd_rawmidi_substream *substream;
>> +
>> +	spin_lock(mts->lock);
>> +	ret = mts64_read(mts->pardev->port);
>> +	data = ret & 0x00ff;
>> +	status = ret >> 8;
>> +
>> +	if (status & MTS64_STAT_PORT) {
>> +		mts->current_midi_input_port = mts64_map_midi_input(data);
>> +	} else {
>> +		substream = mts->midi_input_substream[mts->current_midi_input_port];
>> +		if (mts->mode[substream->number] & MTS64_MODE_INPUT_TRIGGERED)
>> +			snd_rawmidi_receive(substream, &data, 1);
>> +	}
>
> You should check the value of mts->current_midi_input_port.  It could
> be -1 until status is updated, and can be out of the array range.

Yes, I assumed that before some Midi data is sent, the device tells on which port.
Right, this should be checked, one never knows. If the initial interrupt gets lost 
we're doomed.

>
>> +static int __devinit mts64_probe_port(struct parport *p)
>> +{
>> +	struct pardevice *pardev;
>> +	int res;
>> +
>> +	pardev = parport_register_device(p, DRIVER_NAME,
>> +					 NULL, NULL, NULL,
>> +					 0, NULL);
>> +	if (!pardev)
>> +		goto __err;
>> +	
>> +	if (parport_claim(pardev))
>> +		goto __err1;
>> +
>> +	res = mts64_probe(p);
>> +
>> +	parport_release(pardev);
>> +	parport_unregister_device(pardev);
>> +
>> +	return res;
>> +	
>> +__err1:
>> +	parport_unregister_device(pardev);
>> +__err:
>> +	return 0;
>
> No error?

0 in this context means no device is present.
Maybe I should change this to conform with the usual conventions
and return 0 for success, -ENODEV for no device and -EIO for error
on pardevice registering.

>
>> +static int __devinit snd_mts64_probe(struct platform_device *pdev)
>> +{
>> +	struct pardevice *pardev;
>> +	struct parport *p;
>> +	int dev = pdev->id;
>> +	struct snd_card *card = NULL;
>> +	struct mts64 *mts = NULL;
>> +	struct snd_rawmidi *rmidi = NULL;
>> +	int err;
>> +	unsigned long flags;
>> +
>> +	p = platform_get_drvdata(pdev);
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	if (dev >= SNDRV_CARDS) {
>> +		return -ENODEV;
>> +	}
>> +	if (!enable[dev]) {
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (!mts64_probe_port(p)) {
>> +		return -ENODEV;
>> +	}
>
> Remove braces around the above three if's.

Ok

>
>> +	/* init device */
>> +	local_irq_save(flags);
>> +	mts64_device_init(p);
>> +	local_irq_restore(flags);
>
> Remove irq_save/restore.  mts64_device_init() sleeps.

Yes, this is evidently wrong.

>
>> +
>> +	platform_set_drvdata(pdev, card);
>> +
>> +	/* At this point card will be usable */
>> +	if ((err = snd_card_register(card)) < 0) {
>> +		snd_printk("Cannot register card\n");
>> +		goto __err_release;
>> +	}
>> +
>> +	snd_printk("ESI Miditerminal 4140 on 0x%lx\n", p->base);
>> +	return 0;
>> +
>> +__err_release:
>> +	parport_release(pardev);
>> +	mts->pardev_claimed = 0;
>> +__err_free_device:
>> +	parport_unregister_device(pardev);
>
> These can be card->private_free callback so that a single
> snd_card_free() call does all without messy labels.

Ok, this would cleanup the code a lot.
Btw, I can't rember reading about private_free for cards in 
"Writing an ALSA Driver", this should be added.

>
>> +__err_free_card:
>> +	snd_card_free(card);
>> +__err:
>> +	return err;
>> +
>> +}
>> +
>> +static int snd_mts64_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_card *card = platform_get_drvdata(pdev);
>> +	struct mts64 *mts = card->private_data;
>> +	struct pardevice *pardev = mts->pardev;
>> +
>> +	if (card) {
>> +		snd_card_free(card);
>> +		snd_mts64_free(mts);
>> +	}
>> +	if (pardev) {
>> +		if (mts->pardev_claimed)
>> +			parport_release(pardev);
>> +		parport_unregister_device(pardev);
>> +	}
>
> snd_mts64_free() and release of pardev stuff should be in
> card->private_free callback.  It will make the code simpler.

Ok

So, let's proceed next week, since the next days I'm in 
Karlsruhe at LAC :-)

Regards,
Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
