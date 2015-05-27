From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Wed, 27 May 2015 10:54:40 +0200
Message-ID: <20150527085440.GA4445@dellaz>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FFA0265990
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 10:54:45 +0200 (CEST)
Received: by wizo1 with SMTP id o1so13457137wiz.1
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 01:54:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5h7fruecx4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2015 at 08:45:43AM +0200, Takashi Iwai wrote:
> At Sat, 23 May 2015 18:32:51 +0200,
> Michele Curti wrote:
> > 
> > On Thu, May 21, 2015 at 04:52:32PM +0200, Michele Curti wrote:
> > > Hi all,
> > > I'm going to *try* to "write" a driver for the sound card on my new laptop,
> > > an asus x205ta.
> > > 
> > > To be fair I have almost no experience but I'm hoping that all the code is
> > > already present and it only needs some adaptations.
> > > 
> > > The cpu is a intel bay trail z3735f, the sound card is a realtek rt5648 that
> > > has the same product Id of the rt5645 (0x6308).
> > > 
> > > I see in kernel sources:
> > >  - the codec driver
> > > 	sound/soc/codecs/rt5645.c
> > >  - a baytrail board that uses the rt5640
> > > 	sound/soc/intel/boards/byt-rt5640.c
> > >  - a braswell board that uses the rt5645
> > > 	sound/soc/intel/boards/cht_bsw_rt5645.c
> > > 
> > > What do you think?  Is it feasible, given a good amount of free-time? :p
> > > 
> > > Thanks,
> > > Michele
> > 
> > 
> > So I started.. :)
> > At the end of the email there is the patch.
> > 
> > 
> > What I did:
> >   - copied the board file byt-rt5640.c to byt-rt5645.c
> >   - find&replace 5640->5645 in byt-rt5645.c
> >   - added acpi device id to detect the sound card
> >   - added kernel config SND_SOC_INTEL_BYT_RT5645_MACH to select the driver
> > 
> > 
> > Nothing works.
> > 
> > But at least the right modules are loaded it seems..  Here the output of 
> > "lsmod | grep snd":
> > snd_soc_sst_baytrail_pcm    24576  0 
> > snd_soc_sst_ipc        16384  1 snd_soc_sst_baytrail_pcm
> > snd_soc_sst_dsp        36864  2 snd_soc_sst_baytrail_pcm,snd_soc_sst_ipc
> > snd_soc_sst_byt_rt5645_mach    16384  0 
> > snd_soc_rt5645         94208  0 
> > regmap_i2c             16384  1 snd_soc_rt5645
> > snd_soc_rl6231         16384  1 snd_soc_rt5645
> > snd_soc_core          159744  3 snd_soc_rt5645,snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5645_mach
> > snd_compress           20480  1 snd_soc_core
> > dw_dmac_core           28672  2 dw_dmac,snd_soc_sst_dsp
> > snd_pcm                90112  3 snd_soc_rt5645,snd_soc_core,snd_soc_sst_baytrail_pcm
> > snd_timer              28672  1 snd_pcm
> > snd                    57344  4 snd_soc_core,snd_timer,snd_pcm,snd_compress
> > soundcore              16384  1 snd
> > snd_soc_sst_acpi       16384  0 
> > 
> > 
> > And dmesg tells me: 
> > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> > [  +0.088989] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.062539] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.021995] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.001828] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.016646] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
> > [  +0.002541] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.004755] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
> > [  +0.003586] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.002844] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.001705] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.011199] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
> > [  +0.018094] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.067913] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
> > [  +0.004378] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.000145] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.000980] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
> > [  +0.000949] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.020845] (NULL device *): ipc: error DSP boot timeout
> > [  +0.213465] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.036706] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +0.008144] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > [  +1.811435] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
> > [  +0.014526] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
> > [  +0.092535] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
> > [  +0.000011] brcmfmac: brcmf_add_if: ignore IF event
> > 
> > 
> > For now I'm at a standstill and I don't understand a lot of things...
> > I will read the code.. :)
> > 
> > Regards,
> > Michele
> > 
> > Signed-off-by: Michele Curti <michele.curti@gmail.com>
> 
> Keyon, could you take a look?
> 
> 
> Takashi

Thank you!  In that patch I did a typo:

> > index 0000000..5bdb56e
> > --- /dev/null
> > +++ b/sound/soc/intel/boards/byt-rt5645.c
> > @@ -0,0 +1,222 @@
> > +/*
[snip]
> > +
> > +static struct snd_soc_dai_link byt_rt5645_dais[] = {
> > +	{
> > +		.name = "Baytrail Audio",
> > +		.stream_name = "Audio",
> > +		.cpu_dai_name = "baytrail-pcm-audio",
> > +		.codec_dai_name = "rt5645-aif1",
> > +		.codec_name = "i2c-10EC56458:00",

here.  This must be "i2c-10EC5648:00", but errors remain the same...

The error
> > [  +0.020845] (NULL device *): ipc: error DSP boot timeout
made me think that I chose the wrong platform/machine because:
- it is stange that device is NULL
- it is strange that dsp doesn't work after loading the firmware.

So instead of adapting the boards/byt-rt5640.c I tried to adapt
boards/bytcr_rt5640.c that uses
  .cpu_dai_name = "ssp2-port",
  .platform_name = "sst-mfld-platform",

I got a "dummy sound card" but no hardware sound card..

I remember that the errors
> > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
remain.  Now I don't have access to the laptop, so I cannot post the new 
errors that showed up, but if you want me to make some experiments, I'll 
do :)

Thanks,
Michele

PS: for the dumb things that I write, forgive me :p
