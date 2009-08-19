From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: enable speaker output for
	Compaq	6530s/6531s
Date: Wed, 19 Aug 2009 15:56:59 +0800
Message-ID: <20090819075659.GA15149@localhost>
References: <20090816085317.GA23959@localhost> <s5hvdkoi04w.wl%tiwai@suse.de>
	<20090816110110.GA32187@localhost>
	<s5h4os7vsy1.wl%tiwai@suse.de> <s5hd46thbqw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9272B24418
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 09:57:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd46thbqw.wl%tiwai@suse.de>
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

On Tue, Aug 18, 2009 at 02:33:43PM +0800, Takashi Iwai wrote:
> At Mon, 17 Aug 2009 08:46:14 +0200,
> I wrote:
> > 
> > At Sun, 16 Aug 2009 19:01:10 +0800,
> > Wu Fengguang wrote:
> > > 
> > > On Sun, Aug 16, 2009 at 05:22:23PM +0800, Takashi Iwai wrote:
> > > > At Sun, 16 Aug 2009 16:53:17 +0800,
> > > > Wu Fengguang wrote:
> > > > > 
> > > > > There are 3 causes to the silence of Compaq 6530s' internal speaker:
> > > > > - HP pin 0x11 always return 0xffff,ffff (pin_presence=1),
> > > > >   which automutes the speaker at module loading time.
> > > > 
> > > > This is odd.  Is the sense-trigger issued before reading the pin sense?
> > > 
> > > Sorry, what do you mean?  The facts I explored are:
> > > - ad1884a_hp_automute() will be explicitly called by ad1884a_hp_init()
> > > - ad1884a_hp_unsol_event() is never called on plug events
> > > - I tried manually execute AC_VERB_SET_PIN_SENSE then read pin sense,
> > >   it takes effect on the impedance, but pin_presence still remains 1.
> > 
> > The fact that it returns only -1 sounds rather like a hardware issue.
> > Or, at least, reading a wrong place or so.
> 
> BTW, could you give alsa-info.sh output on both machines?

I'm now testing 6531s. All verbs/states seem OK.

With vanilla kernel, on HP plug/unplug, these verbs are executed:

[  311.351460] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0xa080
[  311.353061] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0x9080
[  311.354500] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_EAPD_BTLENABLE:0x0

[  323.060534] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0xa000
[  323.062030] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0x9000
[  323.063499] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_EAPD_BTLENABLE:0x2

This is all write commands since boot.

[   11.243798] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   11.244874] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   11.246217] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   11.247184] ALSA sound/pci/hda/hda_intel.c:2394: chipset global capabilities = 0x4401
[   11.279839] ALSA sound/pci/hda/hda_intel.c:873: codec_mask = 0x3
[   11.281091] ALSA sound/pci/hda/hda_intel.c:1304: codec #0 probed OK
[   11.282234] ALSA sound/pci/hda/hda_intel.c:1304: codec #1 probed OK
[   11.299858] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x3:SET_POWER_STATE:0x0
[   11.301361] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x4:SET_POWER_STATE:0x0
[   11.302848] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x8:SET_POWER_STATE:0x0
[   11.304304] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x9:SET_POWER_STATE:0x0
[   11.305758] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x12:SET_POWER_STATE:0x0
[   11.307217] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x13:SET_POWER_STATE:0x0
[   11.308775] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_POWER_STATE:0x0
[   11.310260] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x19:SET_POWER_STATE:0x0
[   11.954768] ALSA sound/pci/hda/hda_codec.c:3281: hda_codec: model 'laptop' is selected for config 103c:30e0 (HP laptop)
[   12.017172] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x3:SET_AMP_GAIN_MUTE:0x27
[   12.019392] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x4:SET_AMP_GAIN_MUTE:0x27
[   12.021766] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x7:SET_AMP_GAIN_MUTE:0x7080
[   12.024142] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x7:SET_AMP_GAIN_MUTE:0x7100
[   12.026398] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x11:SET_PIN_WIDGET_CONTROL:0xc0
[   12.028750] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x11:SET_AMP_GAIN_MUTE:0xb080
[   12.031047] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xa:SET_AMP_GAIN_MUTE:0x7080
[   12.033076] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xa:SET_AMP_GAIN_MUTE:0x7100
[   12.034587] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x12:SET_PIN_WIDGET_CONTROL:0xc0
[   12.036157] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x12:SET_AMP_GAIN_MUTE:0xb080
[   12.037703] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x1e:SET_AMP_GAIN_MUTE:0x7080
[   12.039265] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x1e:SET_AMP_GAIN_MUTE:0x7100
[   12.040821] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x13:SET_PIN_WIDGET_CONTROL:0xc0
[   12.042376] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x13:SET_AMP_GAIN_MUTE:0xb080
[   12.043902] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_PIN_WIDGET_CONTROL:0x24
[   12.045507] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_AMP_GAIN_MUTE:0x7000
[   12.047057] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x15:SET_PIN_WIDGET_CONTROL:0x20
[   12.048711] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x15:SET_AMP_GAIN_MUTE:0x7000
[   12.050234] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x1c:SET_PIN_WIDGET_CONTROL:0x24
[   12.051812] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x1c:SET_AMP_GAIN_MUTE:0xb080
[   12.053357] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x25:SET_AMP_GAIN_MUTE:0xb000
[   12.054908] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_PIN_WIDGET_CONTROL:0x20
[   12.056519] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0xb080
[   12.058049] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7080
[   12.059563] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7180
[   12.061172] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7280
[   12.062736] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7380
[   12.064309] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7400
[   12.065826] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7580
[   12.067348] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x21:SET_AMP_GAIN_MUTE:0xb080
[   12.068897] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_CONNECT_SEL:0x0
[   12.070368] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_AMP_GAIN_MUTE:0xb080
[   12.071942] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_CONNECT_SEL:0x0
[   12.073394] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_AMP_GAIN_MUTE:0xb080
[   12.074870] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x1b:SET_AMP_GAIN_MUTE:0xb027
[   12.076407] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x11:SET_AMP_GAIN_MUTE:0xb000
[   12.077972] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xb:SET_AMP_GAIN_MUTE:0x7080
[   12.079526] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xb:SET_AMP_GAIN_MUTE:0x7100
[   12.081052] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_PIN_WIDGET_CONTROL:0xc0
[   12.082602] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0xb080
[   12.084134] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x15:SET_PIN_WIDGET_CONTROL:0x24
[   12.085740] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_AMP_GAIN_MUTE:0x7002
[   12.087297] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x15:SET_AMP_GAIN_MUTE:0x7002
[   12.088849] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x7480
[   12.090354] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x11:SET_UNSOLICITED_ENABLE:0xb7
[   12.091922] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_UNSOLICITED_ENABLE:0xb6
[   12.093644] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0xa000
[   12.095273] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_AMP_GAIN_MUTE:0x9000
[   12.096823] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x16:SET_EAPD_BTLENABLE:0x2
[   12.098419] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_CONNECT_SEL:0x1

[   18.518177] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x21:SET_AMP_GAIN_MUTE:0xa09f
[   18.520576] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x21:SET_AMP_GAIN_MUTE:0x909f
[   18.522905] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x21:SET_AMP_GAIN_MUTE:0xa01f
[   18.525366] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x21:SET_AMP_GAIN_MUTE:0x901f
[   18.527958] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x6597
[   18.530303] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x5597
[   18.532640] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x6517
[   18.534929] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x5517
[   18.537008] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x6097
[   18.538647] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x5097
[   18.540193] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x6017
[   18.541739] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x20:SET_AMP_GAIN_MUTE:0x5017
[   18.543736] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_AMP_GAIN_MUTE:0x6000
[   18.545333] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x14:SET_AMP_GAIN_MUTE:0x5000
[   18.547385] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_AMP_GAIN_MUTE:0xa0ab
[   18.549002] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_AMP_GAIN_MUTE:0x90ab
[   18.550529] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_AMP_GAIN_MUTE:0xa02b
[   18.552110] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xc:SET_AMP_GAIN_MUTE:0x902b
[   18.553791] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_AMP_GAIN_MUTE:0xa0a9
[   18.555376] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_AMP_GAIN_MUTE:0x90a9
[   18.556977] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_AMP_GAIN_MUTE:0xa029
[   18.558523] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0xd:SET_AMP_GAIN_MUTE:0x9029
[   18.560221] ALSA sound/pci/hda/hda_codec.c:443: hda-codec: write cmd 0x0:0:0x10:SET_AMP_GAIN_MUTE:0xa083

Thanks,
Fengguang
