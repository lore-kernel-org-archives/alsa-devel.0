From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode to
	psp
Date: Thu, 5 Mar 2009 17:01:15 +0100
Message-ID: <74d0deb30903050801j53c39896q77cae76931029142@mail.gmail.com>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
	<74d0deb30903041256u8eeea03n5500cd59afadd86e@mail.gmail.com>
	<20090304230301.GA20915@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id A5E231037F1
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 17:01:16 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so2517871ywa.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 08:01:15 -0800 (PST)
In-Reply-To: <20090304230301.GA20915@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 5, 2009 at 12:03 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Hi Philipp,
>
> On Wed, Mar 04, 2009 at 09:56:01PM +0100, pHilipp Zabel wrote:
>> > diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
>> > index 45fb600..97f11d6 100644
>> > --- a/sound/soc/pxa/pxa-ssp.c
>> > +++ b/sound/soc/pxa/pxa-ssp.c
>> > @@ -319,6 +319,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_d=
ai *cpu_dai,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> > =A0 =A0 =A0 =A0case PXA_SSP_CLK_EXT:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->sysclk =3D freq;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(&priv->dev, 4);
>>
>> Shouldn't this be somehow set by set_dai_clkdiv instead?
>
> This is actually a very common case - MCLK is BCLK*4, so I put it here.
> We could still move it to some more configurable place if it turns out
> we need to configure it per board.
>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_NF:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_FSRT;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_IF:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP |=
 SSPSP_FSRT;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_IB_IF:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sspsp |=3D SSPSP_SFRMP;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> Removal of SSPSP_FSRT from NB/IB selection seems to be correct from the =
docs.
>
> SSPSP_FSRT has a totally different meaning according to the PXA3xx docs,
> but I'll have a look at the PXA2x specs - maybe we need a special case
> here. Unfortunately, I'm not able to quote from PXA3x specs here due to
> NDA restrictions.
>
>> Can you check if IB could be properly handled by setting SCMODE(1)?
>
> Can't follow that - what are you referring to here?
>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
>> > @@ -652,33 +649,39 @@ static int pxa_ssp_hw_params(struct snd_pcm_subs=
tream *substream,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> > =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S24_LE:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize=
(8));
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) =
for 24 bit stereo */
>>
>> This is still dubious ...
>> S24_LE is 24-bit sound LSB-aligned in 32-bit frames, so DataSize
>> should be 32 here.
>
> I didn't test that, and I didn't change it either - I just removed the
> comment, as we're not running in network mode anymore.
>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> > =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S32_LE:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize=
(16));
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) =
for 32 bit stereo */
>>
>> How is it possible to send 64bit in one frame otherwise?
>
> We're not running in network mode anymore - things are different now :)
>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (priv->dai_fmt & SND_SOC_DAIFMT_F=
RAME_FORMAT_MASK) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_FF_I2S_32:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* These values are all =
found out by trying and
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* failing a lot. PXA'=
s SSP is all black magic and
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* does not work like =
described in any datasheet.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDT=
H(32);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMDLY=
(32 * 2);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_EDMYSTO=
P(3);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP=
(3);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTRT=
(1);
>>
>> Wha?! Amazing. And this really works?
>> How the hell can this result in 16 bits of data followed by 16 bits of
>> zeroes, twice :)
>
> Don't ask :) If we could explain in detail what these registers mean,
> I'd rather make them macro values, but unfortunately, the comment is
> correct ...
>
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Cleared when the DAI =
format is set */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDT=
H(width);
>>
>> Not good for DSP_A/B.
>
> This is the SND_SOC_DAIFMT_I2S case, so DSP modes will be unaffected.
>
> Could you try the patches on your board?

Done. They don't interfere with my setup.

regards
Philipp
