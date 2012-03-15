From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v7] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Thu, 15 Mar 2012 13:51:07 +0900
Message-ID: <CANKRQnhxAW-tXB3jbwctWRRTZJLrmPUfS2DfRXug=inQVW5OZw@mail.gmail.com>
References: <20120308114704.GH3638@opensource.wolfsonmicro.com>
	<1331275026-31651-1-git-send-email-tomoya.rohm@gmail.com>
	<20120314143941.GS3133@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f50.google.com (mail-pz0-f50.google.com
	[209.85.210.50]) by alsa0.perex.cz (Postfix) with ESMTP id B8A2624509
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 05:51:08 +0100 (CET)
Received: by dakn40 with SMTP id n40so4269096dak.9
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 21:51:07 -0700 (PDT)
In-Reply-To: <20120314143941.GS3133@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, yong.y.wang@intel.com, linux-kernel@vger.kernel.org, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2012 at 11:39 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 09, 2012 at 03:37:06PM +0900, Tomoya MORINAGA wrote:
>> + =A0 =A0 /* SAI configuration */
>> + =A0 =A0 if (priv->channels =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_SAI_TRANS_C=
TL, mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ML26124_SAI_NO=
_DELAY | ML26124_SAI_FRAME_SYNC);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_SAI_RCV_CTL=
, mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ML26124_SAI_NO=
_DELAY | ML26124_SAI_FRAME_SYNC);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_SAI_TRANS_C=
TL, mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ML2612=
4_SAI_NO_DELAY);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_SAI_RCV_CTL=
, mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ML2612=
4_SAI_NO_DELAY);
>> + =A0 =A0 }
>
> What happens if the system switches between 1 channel mode and
> multi-channel mode at runtime? =A0It looks like _SYNC will never be
> cleared.

Sorry,  'priv->channels =3D=3D 1' means for telephone codec.
However, we don't support this function.
So, I'll delete these lines.

>> +static int ml26124_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int clk_id, unsigned int freq, int dir)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
>> + =A0 =A0 struct ml26124_priv *priv =3D snd_soc_codec_get_drvdata(codec);
>> +
>> + =A0 =A0 switch (clk_id) {
>> + =A0 =A0 case ML26124_USE_PLL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_CLK_CTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)=
 | BIT(1), 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case ML26124_USE_MCLKI_256FS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_CLK_CTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)=
 | BIT(1), 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case ML26124_USE_MCLKI_512FS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_CLK_CTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)=
 | BIT(1), 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case ML26124_USE_MCLKI_1024FS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_CLK_CTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)=
 | BIT(1), 3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Why not just specify the MCLK rate and then calculate the division based
> on the sample rate?

OK, I'll do like your saying.

>
>> + =A0 =A0 case SND_SOC_BIAS_STANDBY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* VMID ON */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ml26124_update_bits(codec, ML26124_PW_REF_PW_M=
NG,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ML2612=
4_VMID, ML26124_VMID);
>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(500);
>
> This will sleep for 500ms when powering down which probably isn't what's
> desired...

I'll Move into "if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_OFF)" condit=
ion.

thanks.
-- =

ROHM Co., Ltd.
tomoya
