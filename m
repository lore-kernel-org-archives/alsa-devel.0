From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
 while	changing clock
Date: Wed, 01 Apr 2009 16:06:05 +0200
Message-ID: <49D374CD.20401@emlix.com>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id DE49C243E4
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 16:06:05 +0200 (CEST)
In-Reply-To: <20090401121032.GA21294@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/01/2009 02:10 PM, Mark Brown wrote:
> On Wed, Apr 01, 2009 at 12:56:55PM +0200, Daniel Gl=F6ckner wrote:
> =

>> +static int aic3x_trigger(struct snd_pcm_substream *substream, int cmd,
>> +                        struct snd_soc_dai *codec_dai)
>> +{
>> +       struct snd_soc_codec *codec =3D codec_dai->codec;
>> +       struct aic3x_priv *aic3x =3D codec->private_data;
>> +
>> +       switch (cmd) {
>> +       case SNDRV_PCM_TRIGGER_START:
>> +       case SNDRV_PCM_TRIGGER_RESUME:
>> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +               aic3x->running[substream->stream] =3D 1;
>> +               break;
> =

> Hrm, does the chip support asymmetric configurations for playback and
> capture?

No, why do you ask?

>> +/*
>> + * Enables or disables the left/right ADC/DAC according to new.
>> + * Bits in new:
>> + *	0 left ADC
>> + *	1 right ADC
>> + *	2 left DAC
>> + *	4 right DAC
>> + * A set bit enables the component.
>> + * Returns the previous state of those components encoded in the same w=
ay.
>> + */
> =

> Is this really required?  I can't see it being a good idea to bounce the
> power of the DAC or ADC while they are live since that will impact the
> audio stream noticably.  It looks like it'd be better to do a check
> which refuses to do the reconfiguration when it's not possible.

Powering off is required in case the stream has been closed previously but =
the
close_delayed_work has not yet been run. That was the case where I observed=
 the
problems this patch tries to fix.

> It's especially suspicious since the power of the DAC and ADC is managed
> via DAPM; the only current user should be safe since it saves then
> restores the state but it does raise alarm bells.

How about making it a function that always disables the four components and
referring to snd_soc_dapm_sync to restore the state?

In this version of the patch I removed the line that restores the state when
setting the sampling rate failed in-between. Is it safe to assume that DAPM=
 will
not enable the ADC/DAC on other occasions before a valid sampling rate has =
been
configured? One could reorder aic3x_hw_params to detect the error before the
first registers are written..

>>  	case SND_SOC_BIAS_OFF:
>> -		/* force all power off */
>> -		reg =3D aic3x_read_reg_cache(codec, LINE1L_2_LADC_CTRL);
>> -		aic3x_write(codec, LINE1L_2_LADC_CTRL, reg & ~LADC_PWR_ON);
> =

> This should be split into a separate patch; it's a separate change.

Ok

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner
