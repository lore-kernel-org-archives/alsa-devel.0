From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: enable speaker output for Compaq
	6530s/6531s
Date: Wed, 19 Aug 2009 16:27:52 +0800
Message-ID: <20090819082752.GA5908@localhost>
References: <20090816085317.GA23959@localhost> <s5hvdkoi04w.wl%tiwai@suse.de>
	<20090816110110.GA32187@localhost> <s5h4os7vsy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9108724431
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 10:27:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4os7vsy1.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 17, 2009 at 02:46:14PM +0800, Takashi Iwai wrote:
> At Sun, 16 Aug 2009 19:01:10 +0800,
> Wu Fengguang wrote:
> > 
> > On Sun, Aug 16, 2009 at 05:22:23PM +0800, Takashi Iwai wrote:
> > > At Sun, 16 Aug 2009 16:53:17 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > There are 3 causes to the silence of Compaq 6530s' internal speaker:
> > > > - HP pin 0x11 always return 0xffff,ffff (pin_presence=1),
> > > >   which automutes the speaker at module loading time.
> > > 
> > > This is odd.  Is the sense-trigger issued before reading the pin sense?
> > 
> > Sorry, what do you mean?  The facts I explored are:
> > - ad1884a_hp_automute() will be explicitly called by ad1884a_hp_init()
> > - ad1884a_hp_unsol_event() is never called on plug events
> > - I tried manually execute AC_VERB_SET_PIN_SENSE then read pin sense,
> >   it takes effect on the impedance, but pin_presence still remains 1.
> 
> The fact that it returns only -1 sounds rather like a hardware issue.
> Or, at least, reading a wrong place or so.

It may well be a hardware issue. But note that SET_PIN_SENSE could change
the return value of GET_PIN_SENSE, except for the highest pin_presence bit:

        root@hp /home/wfg# hda-verb /dev/snd/hwC0D0 0x16 GET_PIN_SENSE 0            
        nid = 0x16, verb = 0xf09, param = 0x0
        value = 0x7fffffff
        root@hp /home/wfg# hda-verb /dev/snd/hwC0D0 0x16 GET_PIN_SENSE 0
        nid = 0x16, verb = 0xf09, param = 0x0
        value = 0x7fffffff
        root@hp /home/wfg# hda-verb /dev/snd/hwC0D0 0x16 SET_PIN_SENSE 0
        nid = 0x16, verb = 0x709, param = 0x0
        value = 0x0
        root@hp /home/wfg# hda-verb /dev/snd/hwC0D0 0x16 GET_PIN_SENSE 0
        nid = 0x16, verb = 0xf09, param = 0x0
        value = 0xcd00
        root@hp /home/wfg# hda-verb /dev/snd/hwC0D0 0x16 GET_PIN_SENSE 0
        nid = 0x16, verb = 0xf09, param = 0x0
        value = 0xcd00

> > > > - HP pin 0x11 won't emit unsol events on jack plug/unplug,
> > > >   so the speaker have no chance to be unmuted.
> > > 
> > > Can it be fixed with enable_msi=1 option?
> > 
> > Not yet, will try it.
> > 
> > > > - pin 0x1c must be set to PIN_OUT mode to make the speaker work
> > > >   this is the most weird part - line-in pin 0x1c and speaker pin 0x16
> > > >   seem to be unrelated.
> > > 
> > > Hm, sounds strange.
> > 
> > Yes. Note that the 6530s I have is a test box. Another 6531s which
> > is bought directly from market don't have this bug.
> > 
> > > > Fix the problems by
> > > > - add "Speaker" and "Headphone" mixers to allow hand tuning by user
> > > 
> > > It's a bit buggy because the auto-mute feature can turn on/off these
> > > silently.  If any, these controls have to be notified at changing the
> > > state via plugging.
> > 
> > OK. Are there code examples for doing this? Thank you!
> 
> Basically you need to call snd_ctl_notify() to control elements which
> h/w values are changed.  In that way, the mixer app can be notified and
> update the values appropriately.
> 
> However, I think adding these control unconditionally to the existing
> model is no right solution.  The laptop model is designed for the device
> where the HP jack detection works properly.  If the device isn't such one,
> the model itself isn't applicable.
> 
> So, it's better to create either another model without jack detection,
> or add a check for hint strings, at least.
> In either case, you can create two controls, Headphone and Speaker,
> which access the h/w normally without master control.  Then a master
> control will be automatically created as vmaster.

Thanks for the tips! However I'm now wondering the value of doing this:
it may well be an early stage hardware bug and may no longer exist in
the market.. I'm quite content on enabling 6531s and assume the patch
will work alike for 6530s in the market :)

Thanks,
Fengguang

> > > > - add the 0x1c PIN_OUT quirk
> > > > 
> > > > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > > > ---
> > > >  sound/pci/hda/patch_analog.c |    8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > --- sound-2.6.orig/sound/pci/hda/patch_analog.c	2009-08-05 09:40:13.000000000 +0800
> > > > +++ sound-2.6/sound/pci/hda/patch_analog.c	2009-08-16 16:49:39.000000000 +0800
> > > > @@ -3717,6 +3717,8 @@ static struct snd_kcontrol_new ad1884a_l
> > > >  	HDA_CODEC_VOLUME("Master Playback Volume", 0x21, 0x0, HDA_OUTPUT),
> > > >  	HDA_CODEC_MUTE("Master Playback Switch", 0x21, 0x0, HDA_OUTPUT),
> > > >  	HDA_CODEC_MUTE("Dock Playback Switch", 0x12, 0x0, HDA_OUTPUT),
> > > > +	HDA_CODEC_MUTE("Headphone Playback Switch", 0x11, 0x0, HDA_OUTPUT),
> > > > +	HDA_CODEC_MUTE("Speaker Playback Switch", 0x16, 0x0, HDA_OUTPUT),
> > > >  	HDA_CODEC_VOLUME("PCM Playback Volume", 0x20, 0x5, HDA_INPUT),
> > > >  	HDA_CODEC_MUTE("PCM Playback Switch", 0x20, 0x5, HDA_INPUT),
> > > >  	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x00, HDA_INPUT),
> > > > @@ -3837,8 +3839,10 @@ static struct hda_verb ad1884a_laptop_ve
> > > >  	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
> > > >  	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
> > > >  	/* Port-F pin */
> > > > -	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
> > > > +	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> > > >  	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
> > > > +	/* required for compaq 6530s speaker output */
> > > > +	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> > > >  	/* Port-C pin - internal mic-in */
> > > >  	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
> > > >  	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0x7002}, /* raise mic as default */
> > > > @@ -4003,6 +4007,8 @@ static struct snd_pci_quirk ad1884a_cfg_
> > > >  	SND_PCI_QUIRK(0x103c, 0x3030, "HP", AD1884A_MOBILE),
> > > >  	SND_PCI_QUIRK(0x103c, 0x3037, "HP 2230s", AD1884A_LAPTOP),
> > > >  	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
> > > > +	SND_PCI_QUIRK(0x103c, 0x30e8, "HP Compaq 6530s", AD1884A_LAPTOP),
> > > > +	SND_PCI_QUIRK(0x103c, 0x30e9, "HP Compaq 6531s", AD1884A_LAPTOP),
> > > >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x3070, "HP", AD1884A_MOBILE),
> > > >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30d0, "HP laptop", AD1884A_LAPTOP),
> > > >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30e0, "HP laptop", AD1884A_LAPTOP),
> > > > 
> > 
