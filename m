From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/2=5D_ASoC=3A_omap-mcbsp=3A?=
 =?iso-8859-1?q?_Correct_the=09DSP=5FB_mode?=
Date: Tue, 14 Apr 2009 13:34:33 +0300
Message-ID: <200904141334.33497.peter.ujfalusi@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090414120221.f0e89499.jarkko.nikula@nokia.com>
	<20090414093133.GB12678@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AD25244CA
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 12:34:48 +0200 (CEST)
In-Reply-To: <20090414093133.GB12678@sirena.org.uk>
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
Cc: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 April 2009 12:31:33 ext Mark Brown wrote:
> On Tue, Apr 14, 2009 at 12:02:21PM +0300, Jarkko Nikula wrote:
> > The pairs must mach. It's clearly a bug if another end is have to set
> > different polarity than another. Those polarity defines are with
> > respect to the mode, not e.g. what's the McBSP default.
>
> Indeed.  However, the osk5912 board file that Peter pointed at as not
> needing any modifications for DSP_B already uses inverted frame clock
> for both CODEC and CPU.  In that case either both are wrong or it's just
> that the driver is limited in what it supports which is not a problem.

Well, I think the mcbsp module is quite - maybe too - flexible...
To have the DSP_B mode correctly (for the tvl320aic32 codec used in osk5912 =

board) the FS polarity has to be handled by the mcbsp as it has been invert=
ed. =

If we don't do this, there is no way to have the MSB at the correct place (=
it =

has to be available when the FS is high).

The DSP_A mode can use the FS polarity 'correctly' - as it is. Or we can al=
so =

consider to require to invert the FS polarity, than add 1 bit delay for DSP=
_A =

mode.

So:
a) The proposal in the series
DSP_B mode (the MSB is transmitted when the FS is high, the length for the =

pulse is 1):
	case SND_SOC_DAIFMT_DSP_B:
		regs->srgr2	|=3D FPER(wlen * channels - 1);
		regs->srgr1	|=3D FWID(0);
		break;

	case SND_SOC_DAIFMT_DSP_B:
		/* 0-bit data delay */
		regs->rcr2      |=3D RDATDLY(0);
		regs->xcr2      |=3D XDATDLY(0);
		break;

	case SND_SOC_DAIFMT_NB_IF:
		regs->pcr0	|=3D CLKXP | CLKRP;
		break;

DSP_A mode (the MSB is transmitted when the FS went low, the length for the =

pulse is still 1, but the FS stays low for (wlen * channels - 1) cycles):
	case SND_SOC_DAIFMT_DSP_A:
		regs->srgr2	|=3D FPER(wlen * channels - 1);
		regs->srgr1	|=3D FWID(wlen * channels - 2);
		break;

	case SND_SOC_DAIFMT_DSP_A:
		/* 0-bit data delay */
		regs->rcr2      |=3D RDATDLY(0);
		regs->xcr2      |=3D XDATDLY(0);
		break;

	case SND_SOC_DAIFMT_IB_IF:
		break;

b) twist in DSP_A mode.
The DSP_B mode is the same as it is in a)

DSP_A mode (the MSB is transmitted when the FS went low, the length for the =

pulse is still 1, but the FS stays low for (wlen * channels - 1) cycles):
	case SND_SOC_DAIFMT_DSP_A:
		regs->srgr2	|=3D FPER(wlen * channels - 1);
		regs->srgr1	|=3D FWID(0);
		break;

	case SND_SOC_DAIFMT_DSP_A:
		/* 0-bit data delay */
		regs->rcr2      |=3D RDATDLY(1);
		regs->xcr2      |=3D XDATDLY(1);
		break;

	case SND_SOC_DAIFMT_NB_IF:
		regs->pcr0	|=3D CLKXP | CLKRP;
		break;

Both a) and b) would be OK for the DSP_A mode...

c)
Remove the SND_SOC_DAIFMT_* (DSP_A, DSP_B, I2S and NB_NF, NB_IF, IB_NF, IB_=
IF) =

configuration from the omap_mcbsp_dai_set_dai_fmt, move it to the =

omap_mcbsp_dai_hw_params function and have something like these there:

switch (mcbsp_data->fmt &
			(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK)) {
case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF:
	...
	break;
case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF:
	...
	break;
case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_IF:
	...
	break;
case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF:
	...
	break;
case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_IF:
	...
	break;
case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF:
	...
	break;
...

}

and so on. I'm not sure if all of the combinations are valid, but it can be =

done like this also. It is another thing how actually the mcbsp would be =

configured for these modes - for DSP_B the FS polarity has to be inverted t=
o =

get the MSB in a correct place, but it would be correct from the =

snd_soc_dai_set_fmt point of view, or something........


-- =

P=E9ter
