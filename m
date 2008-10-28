From: "Wu, Fengguang" <fengguang.wu@intel.com>
Subject: Re: [ANNOUNCE] patch for INTEL HDMI codec
Date: Tue, 28 Oct 2008 17:50:16 +0800
Message-ID: <1225187418.71863.24941@de>
References: <1225181260.867710.21503@de> <s5hvdvd5c17.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 5069B2432C
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 10:50:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvdvd5c17.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2008 at 02:01:08AM -0700, Takashi Iwai wrote:
> At Tue, 28 Oct 2008 16:07:39 +0800,
> Wu Fengguang wrote:
> > 
> > Hello,
> > 
> > We have recently enabled sound output for Intel HDMI codecs,
> > and would like to share the good news and some early code :-)
> 
> Great!
> 
> > The audio enabling code includes both ALSA and X.Org patches.
> > Attached is one single patch against today's sound-2.6 tree.
> > It contains very basic code for handling
> >         - audio infoframe
> >         - ELD(E-EDID Like Data)
> >         - unsolicited response
> > 
> > The patch is full enough to produce stereo sound via HDMI.
> > But it still lacks features and contains many 'defined but unused' staffs.
> 
> Yeah I see.
> 
> > It was tested OK on ASUS P5E-VM board and HP 2230s notebook.
> > It _should_ also work on Intel DG45ID board.
> 
> Does the ALSA patch work alone without changes in x.org side?

- P5E-VM:   works in console, ALSA patch is enough
- HP 2230s: needs intel video driver to produce sound at all

- DG45ID:   (if I remember it right)
  - produces noise in console since booting(this is why I call
    hdmi_disable_output() in intel_hdmi_init(), will comment this case)
  - sound OK both with vesa/intel video drivers

> > Takashi, I can prepare a trimmed-down patch series, in doing so I'd like
> > to know if you are interested in the basic DIP/ELD/UNSOL routines?
> 
> Yes.  I wanted to write it by myself, but forgot for long time since
> I have no HDMI hardware for testing :)
> Good to see someone finally adding it!

Yeah, hardware is critical.
To do this work, we collected several HDMI boxes and monitors :-)

> > Or should I only submit bare code comparable to the current patch_atihdmi.c?
> 
> If the codec is supposed to be (almost) compatible, it'd be a good
> idea.  Otherwise (if you are uncertain), we can keep it separated as
> your original patch.  I don't mind much about it.

OK. The main logic for ati/nv/intel HDMI codecs should be the same,
except some possible quirks.  One fact is, we migrated SiI1392 HDMI
support from patch_atihdmi.c to patch_intelhdmi.c to make it work for
our P5E-VM board.

> And, maybe we'll need to move EDID handling to the common place,
> anyway.

Yes. But what if the intel driver evolve/expand fast enough to be the
one real driver for HDMI/Display Port codecs? ;-)

> 
> > 
> > PS: the patch can now produce the following ELD information:
> > 
> > [10340.656719] eldv = 1, pinp = 1
> > [10340.660711] ELD buffer size  is 64
> > [10340.660716] ELD baseline len is 10*4
> > [10340.660720] vendor block len is 20
> > [10340.660724] ELD version      is CEA-861D or below
> > [10340.660728] CEA-EDID version is CEA-861-B, C or D
> > [10340.660732] manufacture name is 0x4544
> > [10340.660736] product code     is 0xa02c
> > [10340.660740] port id          is 0x0
> > [10340.660743] HDCP support     is 0
> > [10340.660747] AI support       is 0
> > [10340.660751] SAD count        is 0
> > [10340.660754] audio sync delay is 0
> > [10340.660758] connection type  is HDMI
> > [10340.660763] speaker allocations:
> > [10340.660766] monitor name     is DELL 2408WFP
> 
> Looks good.

I think those kernel messages would be valuable informations for both
developers and end users. Such information are also good candidates
for sysfs(or procfs) exports, I guess.

> 
> > --- /dev/null
> > +++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
> (snip)
> > +struct ELD_fixed_fields {
> > +	__u8 rsv_0		:3;
> > +	__u8 ELD_ver		:5;
> 
> We should avoid bitfields if it's used for communication with the
> hardware in general for portability reason.  Simply take it as bytes,
> and use normal bit shift ops.

This structure is for communication with intel's video driver.
ie. intel video driver reuses that struct for filling the ELD buffer,
so I think it should be OK.

> 
> Also, no reason to use "__" prefix there.

OK.

> > +static void hdmi_debug_slot_mapping(struct hda_codec *codec)
> > +{
> > +#ifdef CONFIG_SND_DEBUG
> 
> I'd use CONFIG_SND_DEBUG_VERBOSE here.  Most distros turn on
> CONFIG_SND_DEBUG=y, and this will be annoying.

Will use it - it wasn't only because I cannot find the _VERBOSE
version at the time ;-)

> > +	int i;
> > +	int slot;
> > +
> > +	for (i = 0; i < 8; i++) {
> > +		slot = snd_hda_codec_read(codec, CVT_NID, 0,
> > +						AC_VERB_GET_HDMI_CHAN_SLOT, i);
> > +		printk(KERN_DEBUG "ASP channel %d => slot %d\n",
> > +				slot >> 4, slot & 0x7);
> > +	}
> > +#endif
> > +}
> > +static void hdmi_debug_present_sense(struct hda_codec *codec)
> > +{
> > +#ifdef CONFIG_SND_DEBUG
> 
> Ditto.
> 
> > +static int hdmi_get_eldd(struct hda_codec *codec, char **eldd)
> > +{
> > +	int i;
> > +	int size;
> > +	char *buf;
> > +
> > +	i = hdmi_present_sense(codec) & AC_PINSENSE_ELDV;
> > +	if (!i)
> > +		return 0;
> > +
> > +	size = snd_hda_codec_read(codec, PIN_NID, 0, AC_VERB_GET_HDMI_DIP_SIZE,
> > +						     AC_DIPSIZE_ELD_BUF);
> > +	if (size == 0) {
> > +		/* wfg: workaround for ASUS P5E-VM HDMI board */
> > +		snd_printk(KERN_INFO "ELD buf size is 0, force 64\n");
> > +		size = 64;
> > +	}
> > +	if (size < sizeof(struct ELD_fixed_fields)) {
> > +		snd_printk(KERN_WARNING "Invalid ELD buf size %d\n", size);
> > +		return 0;
> > +	}
> > +	WARN_ON(size > PAGE_SIZE);
> 
> Better to check more explicity and show the value in the error
> message, and restrict the size.

Good idea!

> > +static void hdmi_parse_short_audio_desc(struct ELD_SAD *a)
> > +{
> > +	};
> 
> Unnecessary semicolon.

Good catch, fixed.

> > --- sound-2.6.orig/sound/pci/hda/hda_intel.c
> > +++ sound-2.6/sound/pci/hda/hda_intel.c
> > @@ -1196,7 +1196,7 @@ static unsigned int azx_max_codecs[AZX_N
> >   * report wrongly the non-existing 4th slot availability
> >   */
> >  static unsigned int azx_default_codecs[AZX_NUM_DRIVERS] __devinitdata = {
> > -	[AZX_DRIVER_ICH] = 3,
> > +	[AZX_DRIVER_ICH] = 4,
> >  	[AZX_DRIVER_ATI] = 3,
> 
> Well, this change should be done in a separate patch.

OK, it's a temp solution - I read about the same patch from you in
latest linux-2.6 tree :-)

> I guess your hardware has the HDMI code on the 4th slot, and the audio
> codec on other?

It's required for DG45ID, however I no longer have access to it now :-(

> This number 3 was basically to avoid lock-up by a wrong detection on
> some hardwares such as thinkpad X60 with some old BIOS.  I remember
> there were others, too.
> 
> I guess, however, this workaround is no longer necessary because we
> clear the slot bits beforehand properly.  If any, a user can add
> probe_mask option manually, and we can put it in the blacklist.
> 
> So, I'd say, let's remove this azx_default_codecs[] stuff completely
> now.

Agreed, I wondered why probe_mask and max limits exist side by side...

Thank you,
Fengguang
