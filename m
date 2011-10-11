From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] ASoC: Convert Goni to data based DAPM init
Date: Tue, 11 Oct 2011 15:10:29 +0900
Message-ID: <CAH9JG2XLFefcA6gbHHJTm=TjNtdgiVOikknnS6Czb6RXAtfd0w@mail.gmail.com>
References: <1318071733-4197-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 44A652437C
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 08:10:32 +0200 (CEST)
Received: by qyk33 with SMTP id 33so6411077qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 23:10:30 -0700 (PDT)
In-Reply-To: <1318071733-4197-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Sat, Oct 8, 2011 at 8:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0sound/soc/samsung/goni_wm8994.c | =A0 13 +++++--------
> =A01 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8=
994.c
> index dcaf656..60ed59b 100644
> --- a/sound/soc/samsung/goni_wm8994.c
> +++ b/sound/soc/samsung/goni_wm8994.c
> @@ -100,14 +100,6 @@ static int goni_wm8994_init(struct snd_soc_pcm_runti=
me *rtd)
> =A0 =A0 =A0 =A0struct snd_soc_dapm_context *dapm =3D &codec->dapm;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 /* add goni specific widgets */
> - =A0 =A0 =A0 snd_soc_dapm_new_controls(dapm, goni_dapm_widgets,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(goni_dapm_widget=
s));
> -
> - =A0 =A0 =A0 /* set up goni specific audio routes */
> - =A0 =A0 =A0 snd_soc_dapm_add_routes(dapm, goni_dapm_routes,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(goni_dapm_routes=
));
> -
> =A0 =A0 =A0 =A0/* set endpoints to not connected */
> =A0 =A0 =A0 =A0snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
> =A0 =A0 =A0 =A0snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
> @@ -256,6 +248,11 @@ static struct snd_soc_card goni =3D {
> =A0 =A0 =A0 =A0.name =3D "goni",
> =A0 =A0 =A0 =A0.dai_link =3D goni_dai,
> =A0 =A0 =A0 =A0.num_links =3D ARRAY_SIZE(goni_dai),
> +
> + =A0 =A0 =A0 .dapm_widgets =3D goni_dapm_widgets,
> + =A0 =A0 =A0 .num_dapm_widgets =3D ARRAY_SIZE(goni_dapm_widgets),
> + =A0 =A0 =A0 .dapm_routes =3D goni_dapm_routes,
> + =A0 =A0 =A0 .num_dapm_routes =3D ARRAY_SIZE(goni_dapm_routes),
> =A0};
>
> =A0static int __init goni_init(void)
> --
> 1.7.6.3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
