From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 2/4] ASoC: rt5670: check if asrc is useable
Date: Fri, 14 Nov 2014 11:38:51 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701021F56@RTITMBSV03.realtek.com.tw>
References: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
 <1415793273-7844-2-git-send-email-bardliao@realtek.com>
 <5463B82E.7070303@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C1DDE2604E7
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 12:39:00 +0100 (CET)
In-Reply-To: <5463B82E.7070303@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Thursday, November 13, 2014 3:43 AM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com;
> alsa-devel@alsa-project.org; Flove; Oder Chiou; mengdong.lin@intel.com;
> yao.jin@intel.com
> Subject: Re: [PATCH 2/4] ASoC: rt5670: check if asrc is useable
> 
> On 11/12/2014 12:54 PM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > To use ASRC, the sysclk should be faster than 384 times sample rate of
> > I2S1.
> >
> > Signed-off-by: Bard Liao <bardliao@realtek.com>
> > ---
> >   sound/soc/codecs/rt5670.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
> > index 85dc210..898b17f 100644
> > --- a/sound/soc/codecs/rt5670.c
> > +++ b/sound/soc/codecs/rt5670.c
> > @@ -575,6 +575,17 @@ static int is_using_asrc(struct
> > snd_soc_dapm_widget *source,
> >
> >   }
> >
> > +static int can_use_asrc(struct snd_soc_dapm_widget *source,
> > +			 struct snd_soc_dapm_widget *sink) {
> > +	struct rt5670_priv *rt5670 =
> > +snd_soc_codec_get_drvdata(source->codec);
> 
> Can you start using snd_soc_dapm_to_codec(source->dapm) instead of
> source->codec? The codec field will eventually be removed.
> 
> Bonus points for fixing up the existing w->codec users in rt drivers.

Sure, I will resend the patch. Another question is that the patch is one
of 4 patches series. Should I resend all of them?

Thanks.

> 
> Thanks,
> - Lars
> 
> 
> ------Please consider the environment before printing this e-mail.
