From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add driver for Analog Devices ADAU1701
 SigmaDSP
Date: Wed, 9 Mar 2011 10:12:21 +0000
Message-ID: <20110309101221.GC6923@opensource.wolfsonmicro.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTinmbJWAoFPPT9aNrJQ+E+eb-3a1F_cV-d2J3YGj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64FFA245A1
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 11:12:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinmbJWAoFPPT9aNrJQ+E+eb-3a1F_cV-d2J3YGj@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <cliffcai.sh@gmail.com>
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2011 at 03:04:03PM +0800, Cliff Cai wrote:
> On Mon, Mar 7, 2011 at 7:41 PM, Mark Brown
> > On Mon, Mar 07, 2011 at 09:11:42AM +0800, cliff.cai@analog.com wrote:

> > It loooks like the register length is hard coded in every location that
> > the register is referenced. ?This doesn't seem ideal - it'd be much
> > nicer to have the register I/O functions work this out without the
> > callers needing to.

> I'm afraid it's not easy to do so.

What's the issue?  I'd expect something like a lookup table or switch
statement going from register to register length - I'd be surprised if
it were any more complicated than getting all the callers right.

> >> +static int adau1701_pcm_prepare(struct snd_pcm_substream *substream,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_s=
oc_dai *dai)
> >> +{
> >> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;
> >> + =A0 =A0 int reg =3D 0;

> >> + =A0 =A0 reg =3D SEROCTL_MASTER | SEROCTL_OBF16 | SEROCTL_OLF1024;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_SEROCTL, 2, reg);

> >> + =A0 =A0 return 0;
> >> +}

> > This looks like some of it is DAI format and word length configuration?

> no,it makes the processor work in master mode.and output bit clock and
> frame clock.

This controls the CODEC, not the CPU?  Master/slave should be controlled
by set_dai_fmt() rather than being hard coded.

> >> +static void adau1701_shutdown(struct snd_pcm_substream *substream,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_d=
ai *dai)
> >> +{
> >> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;

> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_SEROCTL, 2, 0);
> >> +}

> > I suspect this isn't going to work for simultaneous playback and capture
> > - it's not clear what the code does but I'd guess it will stop things
> > completely.

> this SigmaDSP doesn't support duplex operation,it can choose either
> ADCs or serial port as input source.

The driver should be enforcing this constraint, then.

> >> +static int adau1701_set_bias_level(struct snd_soc_codec *codec,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum snd_=
soc_bias_level level)
> >> +{
> >> + =A0 =A0 u16 reg;
> >> + =A0 =A0 switch (level) {
> >> + =A0 =A0 case SND_SOC_BIAS_ON:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D adau1701_read_register(codec, ADAU17=
01_AUXNPOW, 2);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(AUXNPOW_AAPD | AUXNPOW_D0PD | AUX=
NPOW_D1PD | =A0AUXNPOW_D2PD |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AUXNPOW_D3PD | AUXNPOW_VB=
PD | AUXNPOW_VRPD);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXN=
POW, 2, reg);

> > You were also updating some of the same register bits in the mute
> > function. =A0This looks buggy.

> the processor has no switchs to mute or unmute ADCS/DACs,only thing we
> can do is turning them off or on.

If mute can't be implemented don't implement it.  Right now the code is
clearly not going to do what's expected as you've got two different bits
of code trying to control the same thing - at least one set of register
updates isn't going to do anything?

> >> + =A0 =A0 ret =3D adau1701_setprogram(codec);
> >> + =A0 =A0 if (ret < 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Loading program data failed=
\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> >> + =A0 =A0 }
> >> + =A0 =A0 reg =3D DSPCTRL_DAM | DSPCTRL_ADM;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPCTRL, 2, reg);
> >> + =A0 =A0 reg =3D 0x08;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPRES, 1, reg);

> > Should these DSP configuations things be part of downloading firmware?

> these configurations above loading firmware mainly used to avoid pops/cli=
cks
> and cleanup some registers in the DSP core.

Right, but is this something that's always useful when loading firmware
(in which case the firmware load should just wrap it up so it always
happens)?

> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXNPOW, 2, 0);
> >> + =A0 =A0 reg =3D AUXADCE_AAEN;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_AUXADCE, 2, reg);
> >> + =A0 =A0 reg =3D DACSET_DACEN;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DACSET, 2, reg);
> >> + =A0 =A0 reg =3D DSPCTRL_DAM | DSPCTRL_ADM | DSPCTRL_CR;
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_DSPCTRL, 2, reg);
> >> + =A0 =A0 /* Power-up the oscillator */
> >> + =A0 =A0 adau1701_write_register(codec, ADAU1701_OSCIPOW, 2, 0);

> > This looks like it's all power management which I'd expect to see
> > handled in either the bias management functions or ideally DAPM. =A0It
> > also appears that the oscillator is an optional feature so it should be
> > used conditionally.

> the processor can receive MCLK either from external clock source or
> crystal oscillator,
> currently we use the on board crystal,and it can't be turned
> off,otherwise the whole chip will be in an unpredicted status,
> only output clocks can be disabled.

That's specific to your board design, though.  Another board design
might use a different clocking setup.
