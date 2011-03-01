From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2 1/4] ASoC: Add TI tlv320aic32x4 codec
	support.
Date: Tue, 1 Mar 2011 15:36:13 +0100
Message-ID: <AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-2-git-send-email-javier.martin@vista-silicon.com>
	<20110301142231.GH9662@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 733A5103854
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 15:36:16 +0100 (CET)
Received: by iym7 with SMTP id 7so4367522iym.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2011 06:36:15 -0800 (PST)
In-Reply-To: <20110301142231.GH9662@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, b32542@freescale.com
List-Id: alsa-devel@alsa-project.org

Thank you for your fast response.

On 1 March 2011 15:22, Mark Brown <broonie@opensource.wolfsonmicro.com> wro=
te:
> On Tue, Mar 01, 2011 at 03:02:05PM +0100, Javier Martin wrote:
>
>> + =A0 =A0 SOC_DOUBLE_R_TLV("ADC Level Volume", AIC32X4_LADCVOL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AIC32X4_RADCVOL, 0, 0x28, 0, t=
lv_step_0_5),
>> + =A0 =A0 SOC_DOUBLE_R_TLV("PGA Gain Level Volume", AIC32X4_LMICPGAVOL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AIC32X4_RMICPGAVOL, 0, 0x5f, 0=
, tlv_step_0_5),
>
> I suspect you don't want to have Gain and Level in there.
>
>> + =A0 =A0 SOC_SINGLE("AGC Left Enable Switch", AIC32X4_LAGC1, 7, 1, 0),
>> + =A0 =A0 SOC_SINGLE("AGC Right Enable Switch", AIC32X4_RAGC1, 7, 1, 0),
>
> A switch is obviously an enable.
>

Yes, let me fix that in a following version.

>> +static const struct aic32x4_configs aic32x4_reg_init[] =3D {
>
> As I said in reply to your previous posting this looks like it shouldn't
> be here. =A0A few things jump out as suspicious but not everything you're
> doing is clear:
>
>> + =A0 =A0 {AIC32X4_LDOCTL, AIC32X4_LDOCTLEN},
>
> This looks like it should be dynamically managed at runtime, either via
> DAPM or in the bias level functions.
>
>> + =A0 =A0 {AIC32X4_CMMODE, AIC32X4_LDOIN_18_36 | AIC32X4_LDOIN2HP},
>> + =A0 =A0 {AIC32X4_CLKMUX, AIC32X4_PLLCLKIN},
>> + =A0 =A0 {AIC32X4_IFACE3, AIC32X4_DACMOD2BCLK},
>> + =A0 =A0 {AIC32X4_DACSETUP,
>> + =A0 =A0 =A0AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN | AIC32X4_SSTEP2WCLK},
>> + =A0 =A0 {AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K},
>> + =A0 =A0 {AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K},
>
> These look like platform configuration.
>
>> + =A0 =A0 {AIC32X4_LMICPGAVOL, 0x00},
>> + =A0 =A0 {AIC32X4_RMICPGAVOL, 0x00},
>
> These look like volume controls which should be exposed to users.
>
>> + =A0 =A0 /* Unmute ADC left and right channels */
>> + =A0 =A0 {AIC32X4_ADCFGA, 0x00},
>
> This looks like it should be user visible.
>
>> + =A0 =A0 /* MICBIAS =3D 2.075V(CM=3D0.75V) generated from LDOIN */
>> + =A0 =A0 {AIC32X4_MICBIAS, 0x68},
>
> This should be configured by the platform.
>

Ok, let me organize all this stuff for better understanding. By the
way, when you said it should be configured by platform are you
referring to machine driver or to board specific code? Can you please
point me to a codec driver which uses a similar approach?

Thank you.

-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
