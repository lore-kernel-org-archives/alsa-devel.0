From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: How to apply a SOC_DAPM_MUX if two there are two
 different input register for left and right channel?
Date: Thu, 7 Sep 2017 13:22:04 +0100
Message-ID: <20170907122204.x7glq3fkmw3f4zrr@localhost.localdomain>
References: <3ec804f6-847c-2cb2-5851-c1666614e77e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4F9266AE1
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 14:22:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3ec804f6-847c-2cb2-5851-c1666614e77e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr =?iso-8859-1?Q?M=FCller?= <sanj3k@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 06, 2017 at 03:35:36PM +0200, Oleksandr M=FCller wrote:
> Hello guys,
> =

> I have some trouble I want to implement a mux within the mixer application
> for the VIN source of my adc. Taking a look into the datasheet of the
> TI-PCM1863 adc I get the information that the VIN left register is at the
> 0x06 and the VIN right register is at the 0x07 address. Right now my code
> would look like this and here comes the problem it seems that there is on=
ly
> a SOC_ENUM_SINGLE_DECL or a SOC_ENUM_DOUBLE_DECL but no
> SOC_ENUM_DOUBLE_R_DECL because the DOUBLE_DECL only allows shiftl and shi=
ftr
> as the input parameters but I would need a regl regr parameter. Is the on=
ly
> option to duplicate the code and define a VIN_L_MUX and a VIN_R_MUX?
> =

> static const char * const pcm1863_adc_vin_src[] =3D {
>         "VIN1", "VIN2", "VIN3", "VIN4"
> };
> =

> static SOC_ENUM_SINGLE_DECL(
>         pcm1863_adc_vin_enum, PCM1863_ADC1_INPUT_SEL_L,
>         PCM1863_SEL_L_SHIFT, pcm1863_vin_src);
> =

> static const struct snd_kcontrol_new pcm1863_adc_vin_mux =3D
>         SOC_DAPM_ENUM("ADC VIN Source", pcm1863_adc_vin_enum);
> =

> static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] =3D {
>         [...]
>         SND_SOC_DAPM_MUX("ADC VIN Mux", SND_SOC_NOPM, 0, 0,
>                                 &pcm1863_adc_vin_mux),
> };

Currently yes ASoC does not have support for Stereo muxes that
have a different register for both the left and right channel.
Your two options are add single muxes as you suggest or extend
the framework to support what you require. I would probably
suggest that it seems like something I can see existing in other
devices so extending the framework to support it is probably the
better option.

Thanks,
Charles
