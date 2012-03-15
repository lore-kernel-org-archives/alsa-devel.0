From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v6] sound/soc/lapis: add machine driver for ML7213 Carrier Board
Date: Thu, 15 Mar 2012 13:50:48 +0900
Message-ID: <CANKRQni-8w+2p6=ZisQ+GXhGpNmYhesKfTHfOjWGGrQrhvTFGA@mail.gmail.com>
References: <CANKRQngTNWMGswq3weD1s8O4irVEz+DCr1vzi2gnWaQcoq5SEw@mail.gmail.com>
	<1331275091-31700-1-git-send-email-tomoya.rohm@gmail.com>
	<20120314144524.GT3133@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120314144524.GT3133@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2012 at 11:45 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 09, 2012 at 03:38:11PM +0900, Tomoya MORINAGA wrote:
>
>> + =A0 =A0 /* set codec DAI configuration */
>> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SOC=
_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 /* set cpu DAI configuration */
>> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SOC=
_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
>
> This looks very broken, you're setting the two ends of the link to
> different configurations. =A0If this is needed it should be documente=
d why.
>
> Also, this should be set in the dai_link structure as data rather tha=
n
> set each time.

OK.
codec is slave, i2s controller is master.
So, I'll use SND_SOC_DAIFMT_CBS_CFM.

thanks.
--=20
ROHM Co., Ltd.
tomoya
