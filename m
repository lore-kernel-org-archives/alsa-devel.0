From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH v2 01/10] ASoC: upd9976: Add Renesas
	uPD9976 codec driver
Date: Sat, 7 May 2011 22:21:12 +0800
Message-ID: <20110507142112.GC13216@qtel.sh.intel.com>
References: <20110506125437.GJ23729@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E378B24431
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 16:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110506125437.GJ23729@opensource.wolfsonmicro.com>
	<20110506125308.GI23729@opensource.wolfsonmicro.com>
	<20110506110730.GG23729@opensource.wolfsonmicro.com>
	<20110506101726.GF23729@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 06:17:27PM +0800, Mark Brown wrote:
> On Fri, May 06, 2011 at 01:46:03PM +0800, Lu Guanqun wrote:
> 
> > +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> > +					unsigned int reg)
> > +{
> > +	u8 value = 0;
> > +	int ret;
> > +
> > +	ret = intel_scu_ipc_ioread8(reg, &value);
> > +	if (ret)
> > +		dev_err(codec->dev,
> > +			"upd9976 read of 0x%x failed, error: %d\n", reg, ret);
> > +	return value;
> > +}
> 
> Please factor this stuff out.

OK. Patch sent in another thread. Please give some comments whether it's
the right way to achieve this.

> 
> > +/*
> > + * Mixing Volume: from -25 dB to 6 dB in 1 dB steps.
> > + */
> > +static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
> > +
> > +/*
> > + * Audio DAC Volume: From -84 dB to 10.5 dB in 0.75 steps.
> > + */
> > +static DECLARE_TLV_DB_SCALE(adac_tlv, -8400, 75, 0);
> > +static const struct snd_kcontrol_new upd9976_snd_controls[] = {
> 
> Use of blank lines here is really odd.

I don't see a blank line between upd9976_snd_controls and Master Volume.
Do you mean the blank line between the above comment and
DECLARE_TLV_DB_SCALE line?  I'll remove these blank lines.

> > +	SOC_DOUBLE_R_TLV("Master Volume",
> > +			 UPD9976_AUDIOLVOL, UPD9976_AUDIORVOL,
> > +			 0, 0x7f, 1, adac_tlv),
> > +	SOC_DOUBLE_R_TLV("PCM Volume",
> > +			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
> > +			 0, 0x1f, 1, mixer_tlv),
> 
> PCM would usually be a digital audio stream but this is a control for a
> mixer.

OK. I'll change it back to "Headphone Speaker Mixer Volume".

> 
> > +static struct snd_soc_dai_driver upd9976_dais[] = {
> > +{
> > +	.name = "upd9976-audio",
> 
> Previous issue with naming still applies.

Will change it to upd9976-hifi, thanks for your suggestion.

> 
> > +	case SND_SOC_BIAS_PREPARE:
> > +		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
> > +			snd_soc_update_bits(codec, UPD9976_VAUDIOCNT,
> > +					    0x27, 0x27);
> > +			snd_soc_update_bits(codec, UPD9976_VREFPLL,
> > +					    0x35, 0x35);
> > +		}
> > +		break;
> > +
> > +	case SND_SOC_BIAS_STANDBY:
> > +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x25);
> > +		snd_soc_write(codec, UPD9976_VREFPLL, 0x10);
> > +		break;
> > +
> > +	case SND_SOC_BIAS_OFF:
> > +		snd_soc_write(codec, UPD9976_VREFPLL, 0);
> > +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x24);
> > +		break;
> 
> This is all very magic and lots of what's going on (especially with
> VAUDIOCNT) looks like it's actually trying to fiddle with bitmasks.

I'll define some bitmasks so that these magic number will go away, and
others can grasp the idea what's going on...

Generally, it's used to disable/enable power save mode, power on/off
audio rail... etc.

On Fri, May 06, 2011 at 07:07:31PM +0800, Mark Brown wrote:
> On Fri, May 06, 2011 at 01:46:24PM +0800, Lu Guanqun wrote:
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> 
> As previously mentioned please merge these trivial feature patches into
> the original driver unless there's some purpose in splitting them out.
> In this case it looks like the split is the cause of one of the review
> issues in the earlier post.

No problem. I'll make them about three pathes, one for codec driver, one
for platform driver, one for machine driver.

On Fri, May 06, 2011 at 08:53:11PM +0800, Mark Brown wrote:
> On Fri, May 06, 2011 at 01:46:34PM +0800, Lu Guanqun wrote:
> 
> > +	if (interrupt_status & 0x1 && value == 0x1)
> > +		status |= SND_JACK_HEADSET;
> > +
> > +	if (interrupt_status & 0x2 && value == 0x2)
> > +		status |= SND_JACK_HEADPHONE;
> > +
> > +	if (interrupt_status & 0x4)
> > +		status |= SND_JACK_HEADSET | SND_JACK_BTN_0;
> > +
> > +	if (interrupt_status & 0x8)
> > +		status |= SND_JACK_HEADSET | SND_JACK_BTN_1;
> 
> It's very strange that you do a mix of checks with and without the == -
> it doesn't matter either way but it'd be clearer to be consistent.

OK. Let me make the code more clear.
how about this?

+       if (interrupt_status & 0x1) {
+               if (snd_soc_read(codec, UPD9976_SAUXINT) == 0x1)
+                       status |= SND_JACK_HEADSET;
+       }
+
+       if (interrupt_status & 0x2) {
+               if (snd_soc_read(codec, UPD9976_SAUXINT) == 0x2)
+                       status |= SND_JACK_HEADPHONE;
+       }
+
+       if (interrupt_status & 0x4)
+               status |= SND_JACK_HEADSET | SND_JACK_BTN_0;
+
+       if (interrupt_status & 0x8)
+               status |= SND_JACK_HEADSET | SND_JACK_BTN_1;


> 
> > +	if (upd9976->irq < 0 || !upd9976->irq_mem)
> > +		return 0;
> 
> It'd seem better to have this condition the other way around so if you
> need to add more conditional stuff things will be clearer.

changing it to `if (upd9976->ira >= 0 && !upd9976->irq_mem) is logically
ok, but it introduces more indentation for a large block of code...

On Fri, May 06, 2011 at 08:54:40PM +0800, Mark Brown wrote:
> On Fri, May 06, 2011 at 01:46:49PM +0800, Lu Guanqun wrote:
> 
> > +	/* DMIC configuration: mono output to PCM2 */
> > +	snd_soc_update_bits(codec, UPD9976_MICCTRL, BIT(1)|BIT(0), 0x1);
> > +
> > +	/* Set MIC2 to pseudo-differential */
> > +	snd_soc_update_bits(codec, UPD9976_MICSELVOL, BIT(4), BIT(4));
> > +
> 
> These look like regular routing controls to me...  If they do need to be
> set with magic writes they should be platform data but things like
> pseudo differential inputs are normally just represented as two single
> ended inputs for which userspace just happens to choose a path that
> looks differential.

The above DMIC output might fit routing control in some way, but I think
the MIC2 configuration is hardware specific, this is not related to
routing quite much. Let me check whether it's easy to be implemented as
a routing control or platform data...

-- 
guanqun
