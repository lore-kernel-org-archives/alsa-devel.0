From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 3 Oct 2010 00:06:11 +0100
Message-ID: <20101002230610.GA21181@sirena.org.uk>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B0B2424447
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 01:06:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100930162123.21348.86482.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 05:21:32PM +0100, Alan Cox wrote:

> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> [Merged together and tweaked for -next]
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Having things as a series does make things easier for review, reducing
reviewer fatigue if nothing else.  I've given this a bit of a once over
below but not a deep dive - splitting the series would really help with
reviewability.

> +TODO
> +----
> +
> +Get the memrar driver cleaned up and upstream (dependancy blocking SST)
> +Get the jack header entries accepted

See below; I think this needs to be changed to rework the current code
to use the existing facilities.

> +Review the printks and kill off any left over ST_ERR: messages
> +Review the misc device ioctls for 32/64bit safety and sanity
> +Review the misc device ioctls for size safety depending on config and decide
> +	if space/unused areas should be left
> +
> +Anything the sound folks turn up on full review

The big thing I can see is that as I've commented when reviewing earlier
versions of these patches this code really does need to be reworked to
use the standard embedded audio framework under sound/soc rather than
providing its own implementation of the same concepts.  It is clear from
the code that this is a pretty much standard embedded audio hardware
design with the primary digital logic in the CPU and a separate mixed
signal chip providing the ADCs, DACs and other analogue components
streaming audio via standard I2S/PCM style interfaces.  This is a design
that is already well supported by the ASoC code.

Where there are gaps that need fixing in what's there at present
(and there are some) we should work on those at a generic level and
share the effort rather than developing a bunch of vendor-specific
driver stacks.

> +static struct pci_driver driver = {
> +	.name = SST_DRV_NAME,
> +	.id_table = intel_sst_ids,
> +	.probe = intel_sst_probe,
> +	.remove = __devexit_p(intel_sst_remove),
> +#ifdef CONFIG_PM
> +	.suspend = intel_sst_suspend,
> +	.resume = intel_sst_resume,
> +#endif

Standard approach is to #define the functions to NULL in the ifdef for
the function.

> +struct snd_pmic_ops {
> +	int card_status;
> +	int master_mute;
> +	int num_channel;

This abstraction for the mixed signal chip is the key bit that should be
factored out to work within ASoC - at a very high level the model is
that the mixed signal chips are represented by the CODEC drivers, the
CPU drivers contain almost all the rest of the code here (pretty much
as-is, the abstractions are very thin for the CPU) and you have a
machine driver that specified how all these are glued together on a
particular system (so for you this would be the bit that parses the BIOS
data).

> +	/* round it up to the page bondary  */
> +	/*mem_area = (void *)((((unsigned long)sst_drv_ctx->mmap_mem)
> +				+ PAGE_SIZE - 1) & PAGE_MASK);*/
> +	mem_area = (void *) PAGE_ALIGN((unsigned int) sst_drv_ctx->mmap_mem);

Looks like you should just be loosing the commented code here?

> +	switch (_IOC_NR(cmd)) {
> +	case _IOC_NR(SNDRV_SST_STREAM_PAUSE):
> +		pr_debug("sst: IOCTL_PAUSE recieved for %d!\n", str_id);
> +		if (minor != STREAM_MODULE) {
> +			retval = -EBADRQC;
> +			break;
> +		}
> +		retval = sst_pause_stream(str_id);
> +		break;

I believe these are ioctl()s for the offloaded DSP engine rather than
for the PCM data ALSA handles?  It would be nice to name them in a way
that makes this more obvious, obviously there's substantial overlap with
the standard ALSA operations and triggers which raises eyebrows for
someone coming at this from an ALSA context.

To be honest all this stuff looks sufficiently generic that it might be
worth considering factoring out an abstraction which can be used by
other offload engines - having a standard kernel API for them would be a
real win.  That's just a nice to have, though.

> +		/*sst_print_get_vol_info(str_id, &get_vol);*/

Better to have stuff like this be vdbg() or otherwise provide a
conditional compilation/enable method rather than just have commented
out code.

> +/* SST numbers */
> +#define SST_BLOCK_TIMEOUT	5000
> +#define TARGET_DEV_BLOCK_TIMEOUT	5000

Some of this stuff could do with namespacing, even if this file isn't
used anywhere else there may be collisions with other headers code using
it needs to pull in.

> +void sst_mad_send_jack_report(struct snd_jack *jack,
> +				int buttonpressevent , int status)
> +{
> +
> +	if (!jack) {
> +		pr_debug("sst: MAD error jack empty\n");

The jack API will happily eat reports on null jacks, though obviously
you may still wish to warn anyway.

> +	} else {
> +		pr_debug("sst: MAD send jack report for = %d!!!\n", status);
> +		pr_debug("sst: MAD send jack report %d\n", jack->type);
> +		snd_jack_report(jack, status);

Seems like you might want to add trace to the jack code for this...

> +		/*button pressed and released */
> +		if (buttonpressevent)
> +			snd_jack_report(jack, 0);

This looks very suspicious.  You'll report an everything off status for
the jack if a button press was involved which means that not only will
the button press be reported as having ended but any jack presence
indications will also be reported as gone which I suspect is not what's
meant.  If this is safe the code should have comments explaining why.

> +	if (jack_event_flag)
> +		sst_mad_send_jack_report(jack, buttonpressflag, present);

I'm not convinced that headset detection will work in general here, it
looks like each independant event is reported by itself but no effort is
made to maintain the status for things like jack presence which should
be persistent.  Similar issues seem to apply for the other mixed signal
vendors.

When you move to ASoC the ASoC jack detection helpers allow code in the
driver to be written like this (since it's common for jacks in embedded
systems to be detected by multiple unrelated subsystems).

> +void sst_mad_jackdetection_mx(u8 intsts, struct snd_intelmad *intelmaddata)
> +{

Obviously each of these should be part of the ASoC CODEC driver for the
mixed signal chip.

> +	if (is_aava() && jack) {
> +		if (present) {
> +			pr_debug("sst: Jack... YES\n");
> +			scard_ops->set_output_dev(STEREO_HEADPHONE);

is_aava()?

> +/*
> +Mask bits
> +*/
> +#define MASK0 0x01	/* 0000 0001 */
> +#define MASK1 0x02	/* 0000 0010 */
> +#define MASK2 0x04	/* 0000 0100 */
> +#define MASK3 0x08	/* 0000 1000 */
> +#define MASK4 0x10	/* 0001 0000 */
> +#define MASK5 0x20	/* 0010 0000 */
> +#define MASK6 0x40	/* 0100 0000 */
> +#define MASK7 0x80	/* 1000 0000 */
> +/*
> +value bits
> +*/
> +#define VALUE0	0x01	/* 0000 0001 */
> +#define VALUE1	0x02	/* 0000 0010 */
> +#define VALUE2	0x04	/* 0000 0100 */
> +#define VALUE3	0x08	/* 0000 1000 */
> +#define VALUE4	0x10	/* 0001 0000 */
> +#define VALUE5	0x20	/* 0010 0000 */
> +#define VALUE6	0x40	/* 0100 0000 */
> +#define VALUE7	0x80	/* 1000 0000 */

This doesn't look like driver specific stuff, really...

> +#define MAX_VOL_PMIC_VENDOR0    0x3f /* max vol in dB for stereo & voice DAC */
> +#define MIN_VOL_PMIC_VENDOR0    0 /* min vol in dB for stereo & voice DAC */
> +/* Head phone volume control  */
> +#define MAX_HP_VOL_PMIC_VENDOR1    6 /* max volume in dB for HP */
> +#define MIN_HP_VOL_PMIC_VENDOR1    (-84) /* min volume in dB for HP */

You're using much more parsable names for your mixed signal vendors
elsewhere (and several of them have done press releases and whatnot so
there's no issue with disclosure there), doing something more legible
than vendorN wouldn't hurt.

> +/* These want adding to jack.h as enum entries once approved */

> +#define SND_JACK_HS_SHORT_PRESS 	(SND_JACK_HEADSET | 0x0020)
> +#define	SND_JACK_HS_LONG_PRESS		(SND_JACK_HEADSET | 0x0040)

We already have defines for buttons, and I don't see any need to force
the buttons to be associated with headsets.  Someone could easily
provide button detection on a microphone only jack, or some other
combination accessory.  If you do need to define new types you'd also
need to add appropriate stuff to the input layer and make sure the
lookups in jack.c are joined up so we can actually send something up via
the input layer (as things stand your buttons will be ignored).

The way I'd do this is to just say the two different lengths are buttons
zero and one and let user space assign whatever semantics it desires to
those.  It did look like at least one of your mixed signal chips didn't
implement long/short distincton in hardware; for that one you can just
implement a single button.  Any generic userspace is going to need to
cope with that anyway.
