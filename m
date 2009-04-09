From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: change the DSP_B
	mode to DSP_A mode
Date: Thu, 9 Apr 2009 13:33:43 +0300
Message-ID: <200904091333.43869.peter.ujfalusi@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090409130014.52b9319d.jarkko.nikula@nokia.com>
	<200904091316.56108.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C5313243F2
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 12:34:02 +0200 (CEST)
In-Reply-To: <200904091316.56108.peter.ujfalusi@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "arunks@mistralsolutions.com" <arunks@mistralsolutions.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thursday 09 April 2009 13:16:55 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Thursday 09 April 2009 13:00:14 Nikula Jarkko (Nokia-D/Helsinki) wrote:
> > On Thu, 9 Apr 2009 11:34:41 +0200
> >
> > "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:
> > > -	case SND_SOC_DAIFMT_DSP_B:
> > > +	case SND_SOC_DAIFMT_DSP_A:
> > >  		/* 0-bit data delay */
> > >  		regs->rcr2      |=3D RDATDLY(0);
> > >  		regs->xcr2      |=3D XDATDLY(0);
> > > --
> >
> > Are you absolutely sure on this? According to WM9713, it's the DSP_A
> > where MSB is valid after 1 bit clock period of the FS.
>
> I think this is correct. The data is going to be valid exactly the same
> way, as the WM9713 data sheet describes.
>
> As for the DSP_B mode: I think it can be implemented like this:
> Invert the frame sync polarity, Then:
> 	case SND_SOC_DAIFMT_DSP_B:
> 		regs->srgr2	|=3D FPER(wlen * channels - 1);
> 		regs->srgr1	|=3D FWID(0); /* FS pulse width is 1 */
> 		break;
>
> So the MSB will be in the correct place.

BTW: I have draw it to paper the following to verified these:
1) how mcbsp would operate with the osk5912 config (as it was):
	snd_soc_dai_set_fmt(codec_dai,
		SND_SOC_DAIFMT_DSP_B |
		SND_SOC_DAIFMT_NB_IF |
		SND_SOC_DAIFMT_CBM_CFM);

Than after the change:
2) how mcbsp would operate with the osk5912 config (my proposal):
        err =3D snd_soc_dai_set_fmt(codec_dai,
	snd_soc_dai_set_fmt(codec_dai,
		SND_SOC_DAIFMT_DSP_A |
		SND_SOC_DAIFMT_IB_IF |
		SND_SOC_DAIFMT_CBM_CFM);

3) how mcbsp would operate with the omap3beagle 4 channel mode:
	fmt =3D	SND_SOC_DAIFMT_DSP_A |
			SND_SOC_DAIFMT_IB_NF |
			SND_SOC_DAIFMT_CBM_CFM;

Than I compared these drawings to the pictures in the data sheets =

(tlv320aic32, twl4030):
1) Does not match at all
2) 100% match
3) 100% match

I think if the osk5912 wants to use the codec with DSP_B mode it should hav=
e:
	snd_soc_dai_set_fmt(codec_dai,
		SND_SOC_DAIFMT_DSP_B |
		SND_SOC_DAIFMT_NB_IF |
		SND_SOC_DAIFMT_CBM_CFM);

Than in omap-mcbsp:
 	case SND_SOC_DAIFMT_DSP_B:
 		regs->srgr2	|=3D FPER(wlen * channels - 1);
 		regs->srgr1	|=3D FWID(0); /* FS pulse width is 1 */
 		break;

Than it would have been correct, I think. Probably I should send the DSP_B =

support also in the series?

-- =

P=E9ter
