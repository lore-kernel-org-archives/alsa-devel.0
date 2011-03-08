From: Christian Glindkamp <christian.glindkamp@taskit.de>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Tue, 8 Mar 2011 10:51:49 +0100
Message-ID: <20110308095149.GA6623@taskit.de>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<20110307151536.GG1829@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B5C924544
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 10:55:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110307151536.GG1829@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 2011-03-07 15:15, Mark Brown wrote:
> On Mon, Mar 07, 2011 at 01:45:13PM +0100, Christian Glindkamp wrote:
> > +static int max9850_set_bias_level(struct snd_soc_codec *codec,
> > +				  enum snd_soc_bias_level level)
> > +{
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +		break;
> > +	case SND_SOC_BIAS_PREPARE:
> > +		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN,
> > +				MAX9850_SHDN);
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN, 0);
> > +		break;
> > +	case SND_SOC_BIAS_OFF:
> > +		break;
> 
> This pattern looks awfully like you should set idle_bias_off for the
> CODEC and then move the code blocks down one power level - _SHDN sounds
> like a general power down for the device which fits better with the _OFF
> state.
> 
> Or use DAPM like Dimitris suggested.

I've done so, because it seemed that after the first use, the codec is
hold in standby (when not entering suspend) for the whole time. So I
thought by moving shutdown to standby might save some milliamps. But I
think I will go the DAPM route.

> > +	/* enable slew-rate control */
> > +	snd_soc_update_bits(codec, MAX9850_VOLUME, 0x40, 0x40);
> > +	/* set slew-rate 125ms */
> > +	snd_soc_update_bits(codec, MAX9850_CHARGE_PUMP, 0xff, 0xc0);
> 
> If this is for the charge pump this is fine but the _VOLUME makes it
> sound like this should perhaps be user visibile?

These bits control, whether the volume is set immediately or smoothly
slewn between levels. I don't see a real reason a user would want to
change it.

> 
> > +static int max9850_remove(struct snd_soc_codec *codec)
> > +{
> > +	return 0;
> > +}
> 
> Just delete this if not required, all ASoC functions should be optional.

Will do this, even though Dimitris suggested setting the bias level to
off, because it would still be a nop.
