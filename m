From: Yang Fang <yang.a.fang@intel.com>
Subject: Re: [PATCH 1/3] ASoC: max98090: read micbias from
 device property
Date: Wed, 27 May 2015 16:40:41 -0700
Message-ID: <20150527234041.GA61746@mocha>
References: <B03A893ADFE80748942D13AFAF28451924E7176368@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB54260444
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 01:41:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B03A893ADFE80748942D13AFAF28451924E7176368@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <Anish.Kumar@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "srinivas.sripathi@intel.com" <srinivas.sripathi@intel.com>, "praveen.k.jain@intel.com" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "denny.iriawan@intel.com" <denny.iriawan@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "sathyanarayana.nujella@intel.com" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2015 at 02:35:40PM -0700, Anish Kumar wrote:
> > From: "Fang, Yang A" <yang.a.fang@intel.com>
> >
> > This patch reads max98090 micbias from acpi or dt
> >
> > Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> > ---
> > =A0sound/soc/codecs/max98090.c | =A0 =A09 ++++++++-
> > =A01 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> > index c230626..27df17e 100644
> > --- a/sound/soc/codecs/max98090.c
> > +++ b/sound/soc/codecs/max98090.c
> > @@ -2419,6 +2419,8 @@ static int max98090_probe(struct snd_soc_codec *c=
odec)
> > =A0 =A0 =A0 =A0 struct max98090_cdata *cdata;
> > =A0 =A0 =A0 =A0 enum max98090_type devtype;
> > =A0 =A0 =A0 =A0 int ret =3D 0;
> > + =A0 =A0 =A0 int err;
> > + =A0 =A0 =A0 unsigned int micbias;
> >
> > =A0 =A0 =A0 =A0 dev_dbg(codec->dev, "max98090_probe\n");
> >
> > @@ -2503,8 +2505,13 @@ static int max98090_probe(struct snd_soc_codec *=
codec)
> > =A0 =A0 =A0 =A0 snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M98090_VCM_MODE_MASK);
> >
> > + =A0 =A0 =A0 err =3D device_property_read_u32(codec->dev, "max,micbias=
", &micbias);
> =

>       =A0 =A0 =A0 if (err || micbias < M98090_MBVSEL_2V2 || micbias > M98=
090_MBVSEL_2V8)
>    =A0 =A0 =A0 =A0 =A0 =A0 =A0 micbias =3D M98090_MBVSEL_2V8;
> Just stick sanity as well.
thanks.will include in v2. waiting for more comments
