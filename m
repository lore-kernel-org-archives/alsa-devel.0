From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Wed, 27 May 2015 19:41:56 +0100
Message-ID: <1432752116.8235.25.camel@loki>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de> <20150527085440.GA4445@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2823D26041F
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 20:42:02 +0200 (CEST)
In-Reply-To: <20150527085440.GA4445@dellaz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>, Bard Liao <bardliao@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

+ Bard for the codec issues.

On Wed, 2015-05-27 at 10:54 +0200, Michele Curti wrote:
> On Wed, May 27, 2015 at 08:45:43AM +0200, Takashi Iwai wrote:
> > At Sat, 23 May 2015 18:32:51 +0200,
> > Michele Curti wrote:
> > > 
> > > On Thu, May 21, 2015 at 04:52:32PM +0200, Michele Curti wrote:
> > > > Hi all,
> > > > I'm going to *try* to "write" a driver for the sound card on my new laptop,
> > > > an asus x205ta.
> > > > 
> > > > To be fair I have almost no experience but I'm hoping that all the code is
> > > > already present and it only needs some adaptations.
> > > > 

I'd expect most of the code to be present, but it's likely some
integration is required for differences to HW/BIOS compared to the
driver development platform.

> > > > The cpu is a intel bay trail z3735f, the sound card is a realtek rt5648 that
> > > > has the same product Id of the rt5645 (0x6308).
> > > > 
> > > > I see in kernel sources:
> > > >  - the codec driver
> > > > 	sound/soc/codecs/rt5645.c
> > > >  - a baytrail board that uses the rt5640
> > > > 	sound/soc/intel/boards/byt-rt5640.c
> > > >  - a braswell board that uses the rt5645
> > > > 	sound/soc/intel/boards/cht_bsw_rt5645.c
> > > > 
> > > > What do you think?  Is it feasible, given a good amount of free-time? :p
> > > > 
> > > > Thanks,
> > > > Michele
> > > 
> > > 
> > > So I started.. :)
> > > At the end of the email there is the patch.
> > > 
> > > 
> > > What I did:
> > >   - copied the board file byt-rt5640.c to byt-rt5645.c
> > >   - find&replace 5640->5645 in byt-rt5645.c
> > >   - added acpi device id to detect the sound card
> > >   - added kernel config SND_SOC_INTEL_BYT_RT5645_MACH to select the driver
> > > 
> > > 
> > > Nothing works.
> > > 
> > > But at least the right modules are loaded it seems..  Here the output of 
> > > "lsmod | grep snd":
> > > snd_soc_sst_baytrail_pcm    24576  0 
> > > snd_soc_sst_ipc        16384  1 snd_soc_sst_baytrail_pcm
> > > snd_soc_sst_dsp        36864  2 snd_soc_sst_baytrail_pcm,snd_soc_sst_ipc
> > > snd_soc_sst_byt_rt5645_mach    16384  0 
> > > snd_soc_rt5645         94208  0 
> > > regmap_i2c             16384  1 snd_soc_rt5645
> > > snd_soc_rl6231         16384  1 snd_soc_rt5645
> > > snd_soc_core          159744  3 snd_soc_rt5645,snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5645_mach
> > > snd_compress           20480  1 snd_soc_core
> > > dw_dmac_core           28672  2 dw_dmac,snd_soc_sst_dsp
> > > snd_pcm                90112  3 snd_soc_rt5645,snd_soc_core,snd_soc_sst_baytrail_pcm
> > > snd_timer              28672  1 snd_pcm
> > > snd                    57344  4 snd_soc_core,snd_timer,snd_pcm,snd_compress
> > > soundcore              16384  1 snd
> > > snd_soc_sst_acpi       16384  0 
> > > 

OK, this means the audio DSP and codec devices are present in the BIOS.

> > > 
> > > And dmesg tells me: 
> > > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio

Looks like the codec has no platform data and is failing to get a valid
IRQ number. Do you know what IRQ the code is actually requesting as it
could be bogus ?

> > > [  +0.088989] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.062539] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.021995] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.001828] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.016646] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
> > > [  +0.002541] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.004755] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
> > > [  +0.003586] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.002844] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.001705] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.011199] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
> > > [  +0.018094] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.067913] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
> > > [  +0.004378] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.000145] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.000980] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
> > > [  +0.000949] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.020845] (NULL device *): ipc: error DSP boot timeout

Ok, this means the ADSP FW has been loaded but has failed to boot for
some reason. Can you switch on driver dev_dbg() output.

> > > [  +0.213465] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.036706] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +0.008144] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > [  +1.811435] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
> > > [  +0.014526] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
> > > [  +0.092535] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
> > > [  +0.000011] brcmfmac: brcmf_add_if: ignore IF event
> > > 
> > > 
> > > For now I'm at a standstill and I don't understand a lot of things...
> > > I will read the code.. :)
> > > 
> > > Regards,
> > > Michele
> > > 
> > > Signed-off-by: Michele Curti <michele.curti@gmail.com>
> > 
> > Keyon, could you take a look?
> > 
> > 
> > Takashi
> 
> Thank you!  In that patch I did a typo:
> 
> > > index 0000000..5bdb56e
> > > --- /dev/null
> > > +++ b/sound/soc/intel/boards/byt-rt5645.c
> > > @@ -0,0 +1,222 @@
> > > +/*
> [snip]
> > > +
> > > +static struct snd_soc_dai_link byt_rt5645_dais[] = {
> > > +	{
> > > +		.name = "Baytrail Audio",
> > > +		.stream_name = "Audio",
> > > +		.cpu_dai_name = "baytrail-pcm-audio",
> > > +		.codec_dai_name = "rt5645-aif1",
> > > +		.codec_name = "i2c-10EC56458:00",
> 
> here.  This must be "i2c-10EC5648:00", but errors remain the same...
> 
> The error
> > > [  +0.020845] (NULL device *): ipc: error DSP boot timeout
> made me think that I chose the wrong platform/machine because:
> - it is stange that device is NULL
> - it is strange that dsp doesn't work after loading the firmware.
> 

The NULL device is just a bug in the code. The device should be set
prior to any driver messages. 

> So instead of adapting the boards/byt-rt5640.c I tried to adapt
> boards/bytcr_rt5640.c that uses
>   .cpu_dai_name = "ssp2-port",
>   .platform_name = "sst-mfld-platform",
> 
> I got a "dummy sound card" but no hardware sound card..

There are 2 BYT DSP driver upstream, they are for different HW
configurations. Can you stick with boards/byt-rt5640.c for the moment
until we can debug further.

> 
> I remember that the errors
> > > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> remain.  Now I don't have access to the laptop, so I cannot post the new 
> errors that showed up, but if you want me to make some experiments, I'll 
> do :)
> 

Ok, lets get the dev_dbg() output enabled for sst-baytrail*.c and we can
take it from there.

Thanks

Liam

> Thanks,
> Michele
> 
> PS: for the dumb things that I write, forgive me :p
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
