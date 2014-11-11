From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Add ASRC support
Date: Tue, 11 Nov 2014 03:32:33 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701020280@RTITMBSV03.realtek.com.tw>
References: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
 <545DD1BC.9000208@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A1F261AD0
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 04:32:36 +0100 (CET)
In-Reply-To: <545DD1BC.9000208@metafoo.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Saturday, November 08, 2014 4:18 PM
> To: Bard Liao; broonie@kernel.org; lgirdwood@gmail.com
> Cc: Oder Chiou; alsa-devel@alsa-project.org; Flove
> Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rt5645: Add ASRC support
> 
> On 10/31/2014 08:37 AM, bardliao@realtek.com wrote:
> > diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> > index bc442f4..3131e91 100644
> > --- a/sound/soc/codecs/rt5645.c
> > +++ b/sound/soc/codecs/rt5645.c
> > @@ -443,6 +443,65 @@ static
> SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
> >   				RT5645_TDM_CTRL_1, 8,
> >   				rt5645_tdm_adc_data_select);
> >
> > +static int rt5645_clk_sel_put(struct snd_kcontrol *kcontrol,
> > +		struct snd_ctl_elem_value *ucontrol) {
> > [...]
>  > +}
> 
> This function seems to be completely unused.

Just sent a patch to remove it.

Thanks.

> 
> 
> 
> ------Please consider the environment before printing this e-mail.
