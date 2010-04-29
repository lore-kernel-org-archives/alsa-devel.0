From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv2 1/2] ASoC: TWL4030: AIF/APLL fix in DAPM
	domain
Date: Thu, 29 Apr 2010 09:46:07 +0300
Message-ID: <201004290946.07847.peter.ujfalusi@nokia.com>
References: <1272459015-22789-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272459015-22789-2-git-send-email-peter.ujfalusi@nokia.com>
	<20100428131235.GH31400@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E2C724390
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 08:46:29 +0200 (CEST)
In-Reply-To: <20100428131235.GH31400@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wednesday 28 April 2010 16:12:35 ext Mark Brown wrote:
> On Wed, Apr 28, 2010 at 03:50:14PM +0300, Peter Ujfalusi wrote:
> > +	if (enable && twl4030->apll_enabled =3D=3D 1)
> > =

> >  		/* Enable PLL */
> >  		status =3D twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
> > =

> > -	else
> > +	else if (!enable && twl4030->apll_enabled =3D=3D 0)
> =

> This logic looks funny, especially the test for !enable in the second
> case (which should always be true).  I think the intention here is to
> look for "apll_enabled has done an interesting transition (0->1 or
> 1->0)" - it'd probably be clearer to look for that directly.

Yeah, I have not bothered to change this from Liam's patch, but yes. It doe=
s =

look funny.
Probably something like this would be nicer:
if (enable) {
	twl4030->apll_enabled++;
	if (twl4030->apll_enabled =3D=3D 1)
		status =3D twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
} else {
	twl4030->apll_enabled--;
	if (!twl4030->apll_enabled)
		status =3D twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
}

After taking a deeper look, the aif does not need any refcounting, since DA=
PM =

already takes care of that.
So I will simplify that as well.

> =

> > +	/* AIF and APLL clocks for running DAIs (including loopback) */
> > +	SND_SOC_DAPM_OUTPUT("AIF DAC"),
> > +	SND_SOC_DAPM_INPUT("AIF ADC"),
> > +	SND_SOC_DAPM_OUTPUT("APLL"),
> =

> The use of INPUT and OUTPUT widgets here looks really odd - I'd at least
> except the AIF widgets to be actual AIF widgets.

I agree.
These supposed to be 'virtual' outputs, and input.
Is it helps, if I name them as:
SND_SOC_DAPM_OUTPUT("Virtual HiFi OUT"),
SND_SOC_DAPM_INPUT("Virtual HiFi IN"),
SND_SOC_DAPM_OUTPUT("Virtual Voice OUT"),

These are needed to enable the AIF, and/or APLL whenever they are needed by =

DAPM.

I'm switching the AIF/APLL within the DAPM (with DAPM_SUPPLY).
The problem is that if we don't have complete DAPM route (in playback or in =

capture), than DAPM will not enable the AIF/APLL. If the twl is master, tha=
n it =

means that the clocks will not run on the serial bus. This means that no da=
ta is =

going to be sent or received on the host side -> broken audio.

With these in place, I can make sure that we have complete route all the ti=
me, =

so AIF/APLL is enabled.

I know that other codecs (like the tlv320dac33) is enabling the AIF in =

pcm_prepare, or in other places, but with twl4030 those will not work in al=
l =

cases:
If I use pcm_prepare for this, than I have a problem with the digital loopb=
ack, =

since that also needs the AIF/APLL enabled.
If I use the DAPM's set_bias_level, than I have two problems:
1. The analog loopback does not need the AIF/APLL enabled, so I have to han=
dle =

that differently.
2. When there is no complete DAPM route, the codec will not change to BIAS_=
ON, =

so I still end up with dead interface.

The only solution so far is to introduce these virtual outputs/input, and h=
andle =

the AIF/APLL within DAPM.

As a note: I'm already looking at the AIF widget usage, but I'm not sure ho=
w it =

supposed to be mapped in twl4030 case.
TWL has basically 4 channel interface:
Playback
AIF		Stereo mode	TDM mode
SDRL2	Left (1)		Ch 1
SDRL1	---			Ch 2
SDRR2	Right (2)		Ch 3
SDRR1	---			Ch 4

Capture
AIF		Stereo mode	TDM mode
ATXL1	Left (1)		Ch 1
AVTXL2	---			Ch 2
ATXR1	Right (2)		Ch 3
AVTXR2	---			Ch 4

How to map these with the AIF interface in Stereo and TDM (4 channel mode) =
in a =

consistent way?

I will rename the DAPM_OUTPUT and DAPM_INPUT widgets to the "Virtual *" =

convention, which I think sounds better also.


-- =

P=E9ter
