From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
 "Capture Volume" inverted
Date: Thu, 26 Apr 2012 15:49:02 +0200
Message-ID: <1335448142.20000.40.camel@mars>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1CC10BAEA
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 15:49:06 +0200 (CEST)
Received: by lban1 with SMTP id n1so908093lba.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 06:49:06 -0700 (PDT)
In-Reply-To: <20120426112726.GF3207@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 12:27 +0100, Mark Brown wrote:
> On Wed, Apr 25, 2012 at 10:07:49PM +0200, Christoph Fritz wrote:
> 
> > # amixer sset "Mic Select Source" 'Mic 2'
> > Simple mixer control 'Mic Select Source',0
> >   Capabilities: enum
> >   Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
> >   Item0: 'Mic 1'
> 
> Nothing springing to mind here, can you see logging for the register
> writes?

I added some printks into ac97_write() "sound/soc/codecs/wm9712.c" and
when I do for example change "Item: Mic Boost [dB gain: 20.00] " I get
this:

 write  eh 8000  [6808]
 write  eh 8000  [6888]

but when I try to change "Mic Select Source" or "Item: Differential
Source", nothing happens here.

And in "sound/soc/codecs/wm9712.c":

static const struct soc_enum wm9712_enum[] = {
SOC_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9712_alc_select),
SOC_ENUM_SINGLE(AC97_VIDEO, 12, 4, wm9712_alc_mux),
SOC_ENUM_SINGLE(AC97_AUX, 9, 4, wm9712_out3_src),
SOC_ENUM_SINGLE(AC97_AUX, 8, 2, wm9712_spk_src),
SOC_ENUM_SINGLE(AC97_REC_SEL, 12, 4, wm9712_rec_adc),
SOC_ENUM_SINGLE(AC97_MASTER_TONE, 15, 2, wm9712_base),
SOC_ENUM_DOUBLE(AC97_REC_GAIN, 14, 6, 2, wm9712_rec_gain),
SOC_ENUM_SINGLE(AC97_MIC, 5, 4, wm9712_mic),
SOC_ENUM_SINGLE(AC97_REC_SEL, 8, 8, wm9712_rec_sel),
SOC_ENUM_SINGLE(AC97_REC_SEL, 0, 8, wm9712_rec_sel),
SOC_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9712_ng_type),
SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel),
};

Why is wm9712_enum[0] never used?

Is "SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel)," correct? Because of
the ">> 1" shift in ac97_write() ?


Thanks,
 -- Christoph


> 
> > When I tested arecord for line-in, the "Capture Slide" in alsamixer
was
> > wrongly inverted.
> > in sound/soc/codecs/wm9712.c:
> >        SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 1),
> > should get:
> >        SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 0),
> > If you want I can send a patch in.
> 
> Yes, please.  In general this is always a good thing to do if you spot
> an error in the code.
> 
> > Since patch "ASoC: Sync initial widget state with hardware"
> > (commitid: b66a70d5e9929f3b0df5a7177bba75652d2f4c3e) the mic capture
doesn't
> > work. The MICBIAS bit from the "Power Management" Register are alway
1 (disabled).
> > So that the captering works the active status must be set to 1, at
the right time.
> > That this works the stream name must be set.
> 
> This analysis seems a bit confused - how does changing the initial
state
> affect the dynamic changes at runtime?
> 
> >  #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
> > -{  .id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift =
wshift, \
> > +{  .id = snd_soc_dapm_micbias, .name = wname, .sname = \
> > +   "Mic Bias HiFi Capture", .reg = wreg, .shift = wshift, \
> 
> This isn't right, the mic bias clearly shouldn't be associated with a
> stream as you can do capture without microphone (eg, from a line
input)
> and you can have a bypass path with no capture.
