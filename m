From: Anish Kumar <Anish.Kumar@maximintegrated.com>
Subject: Re: [PATCH 1/3] ASoC: max98090: read micbias from
 device property
Date: Wed, 27 May 2015 14:35:40 -0700
Message-ID: <B03A893ADFE80748942D13AFAF28451924E7176368@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maximintegrated.com (antispam01.maximintegrated.com
 [205.153.101.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FE69260431
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 23:35:46 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "srinivas.sripathi@intel.com" <srinivas.sripathi@intel.com>, "praveen.k.jain@intel.com" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "denny.iriawan@intel.com" <denny.iriawan@intel.com>, "sathyanarayana.nujella@intel.com" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> From: "Fang, Yang A" <yang.a.fang@intel.com>
>
> This patch reads max98090 micbias from acpi or dt
>
> Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> ---
> =A0sound/soc/codecs/max98090.c | =A0 =A09 ++++++++-
> =A01 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index c230626..27df17e 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2419,6 +2419,8 @@ static int max98090_probe(struct snd_soc_codec *cod=
ec)
> =A0 =A0 =A0 =A0 struct max98090_cdata *cdata;
> =A0 =A0 =A0 =A0 enum max98090_type devtype;
> =A0 =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned int micbias;
>
> =A0 =A0 =A0 =A0 dev_dbg(codec->dev, "max98090_probe\n");
>
> @@ -2503,8 +2505,13 @@ static int max98090_probe(struct snd_soc_codec *co=
dec)
> =A0 =A0 =A0 =A0 snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M98090_VCM_MODE_MASK);
>
> + =A0 =A0 =A0 err =3D device_property_read_u32(codec->dev, "max,micbias",=
 &micbias);

      =A0 =A0 =A0 if (err || micbias < M98090_MBVSEL_2V2 || micbias > M9809=
0_MBVSEL_2V8)
   =A0 =A0 =A0 =A0 =A0 =A0 =A0 micbias =3D M98090_MBVSEL_2V8;
Just stick sanity as well.
