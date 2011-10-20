From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [alsa-devel] [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Thu, 20 Oct 2011 18:10:41 +0100
Message-ID: <CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
References: <1319121769.24621.130.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319121769.24621.130.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20 October 2011 15:42, Ashish Chavan <ashish.chavan@kpitcummins.com>=
 wrote:
> DA7210 has three line outputs. OUT1 Left, OUT1 Right and OUT2 (mono).
> This patch adds support for gain controls for these three line outs.
> It also adds support for overall DAC gain control.
>
> Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> ---
> Changes since v1:
> - Removed explicit setting of default gains
> - Renamed "DAC Playback" to "Digital Playback"
> ---
> =C2=A0sound/soc/codecs/da7210.c | =C2=A0 42 +++++++++++++++++++++++++=
+++++++++++++++++
> =C2=A01 files changed, 42 insertions(+), 0 deletions(-)
>

>
> + =C2=A0 =C2=A0 =C2=A0 /* Enable Line out amplifiers */
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, DA7210_OUT1_L, DA7210_OUT=
1_L_EN);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, DA7210_OUT1_R, DA7210_OUT=
1_R_EN);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_=
EN |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
> +

Any reason for not using DAPM here ? Otherwise they are always on
making your chip burn mW.....

Thanks

Liam
