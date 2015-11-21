From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 1/4] sound: codecs: pcm1792a: clean
 function exit
Date: Sat, 21 Nov 2015 17:33:46 +0100
Message-ID: <20151121163336.GA27666@panicking>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
 <1448014157-36526-2-git-send-email-raphael.poggi@avalun.com>
 <CAOf5uwmx95te=gHg5FnmNx+xOcpmGfnfzdgbnF8m8sms028PKQ@mail.gmail.com>
 <CACqcpZACQiBkyj=a765rKjGi7Ft_MS4+t_0F90dQXGxecRm92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AB1C8260442
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 17:34:06 +0100 (CET)
Received: by padhx2 with SMTP id hx2so147174972pad.1
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 08:34:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACqcpZACQiBkyj=a765rKjGi7Ft_MS4+t_0F90dQXGxecRm92Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Rapha=EBl?= Poggi <poggi.raph@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Sat, Nov 21, 2015 at 05:16:53PM +0100, Rapha=EBl Poggi wrote:
> Hi,
> =

> I know that almost all the codec do as before, but what is the goal of
> using an extra condition when we can avoid it ?
> =


If you use top posting I can not follow. I said that I'm agree on the
first one chage and I suggest to do the same for the next one.

Michael

> Raphael
> =

> 2015-11-21 10:31 GMT+01:00 Michael Trimarchi <michael@amarulasolutions.co=
m>:
> > Hi
> >
> > On Fri, Nov 20, 2015 at 11:09 AM, Raphael Poggi <poggi.raph@gmail.com> =
wrote:
> >> From: Raphael Poggi <poggi.raph@gmail.com>
> >>
> >> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
> >> ---
> >>  sound/soc/codecs/pcm1792a.c | 14 ++++----------
> >>  1 file changed, 4 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
> >> index 08bb486..cf42b24 100644
> >> --- a/sound/soc/codecs/pcm1792a.c
> >> +++ b/sound/soc/codecs/pcm1792a.c
> >> @@ -91,14 +91,9 @@ static int pcm1792a_digital_mute(struct snd_soc_dai=
 *dai, int mute)
> >>  {
> >>         struct snd_soc_codec *codec =3D dai->codec;
> >>         struct pcm1792a_private *priv =3D snd_soc_codec_get_drvdata(co=
dec);
> >> -       int ret;
> >>
> >> -       ret =3D regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
> >> +       return regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
> >>                                  PCM1792A_MUTE_MASK, !!mute);
> >> -       if (ret < 0)
> >> -               return ret;
> >> -
> >
> > Ok, I have seen that almost all the codecs use return regmap_upda...
> >
> >> -       return 0;
> >>  }
> >>
> >>  static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
> >> @@ -107,7 +102,8 @@ static int pcm1792a_hw_params(struct snd_pcm_subst=
ream *substream,
> >>  {
> >>         struct snd_soc_codec *codec =3D dai->codec;
> >>         struct pcm1792a_private *priv =3D snd_soc_codec_get_drvdata(co=
dec);
> >> -       int val =3D 0, ret;
> >> +       int val =3D 0;
> >> +       int ret =3D 0;
> >>
> >>         priv->rate =3D params_rate(params);
> >>
> >> @@ -147,10 +143,8 @@ static int pcm1792a_hw_params(struct snd_pcm_subs=
tream *substream,
> >>
> >>         ret =3D regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
> >>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD_ENA=
BLE, val);
> >> -       if (ret < 0)
> >> -               return ret;
> >>
> >
> > Please do the same as before
> >
> > Michael
> >
> >
> >> -       return 0;
> >> +       return ret;
> >>  }
> >>
> >>  static const struct snd_soc_dai_ops pcm1792a_dai_ops =3D {
> >> --
> >> 2.1.0
> >>
> >> _______________________________________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> >
> >
> > --
> > | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> > | COO  -  Founder                                      Cruquiuskade 47 |
> > | +31(0)851119172                                 Amsterdam 1018 AM NL |
> > |                  [`as] http://www.amarulasolutions.com               |
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- =

| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
