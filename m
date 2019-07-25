From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/6] ASoC: codec2codec: run callbacks in order
Date: Thu, 25 Jul 2019 15:21:40 +0200
Message-ID: <1jlfwmxna3.fsf@starbuckisacylon.baylibre.com>
References: <20190724162405.6574-1-jbrunet@baylibre.com> <20190724162405.6574-2-jbrunet@baylibre.com> <20190725130016.GC4213@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725130016.GC4213@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu 25 Jul 2019 at 14:00, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 24, 2019 at 06:24:00PM +0200, Jerome Brunet wrote:
>> When handling dai_link events on codec to codec links, run all .startup()
>> callbacks on sinks and sources before running any .hw_params(). Same goes
>> for hw_free() and shutdown(). This is closer to the behavior of regular
>> dai links
>
> This looks good but needs rebasing against -next due to Morimoto-san's
> recent DAI changes:
>
>   CC      sound/soc/soc-dapm.o
> sound/soc/soc-dapm.c: In function =E2=80=98snd_soc_dai_link_event=E2=80=
=99:
> sound/soc/soc-dapm.c:3857:10: error: implicit declaration of function =E2=
=80=98soc_dai_hw_params=E2=80=99; did you mean =E2=80=98snd_soc_dai_hw_para=
ms=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>     ret =3D soc_dai_hw_params(&substream, params, source);
>           ^~~~~~~~~~~~~~~~~
>           snd_soc_dai_hw_params

I did rebase against next and saw Morimoto-san's patchset. I must have
messed up when formatting the patches, sorry about that. I'll resend.
