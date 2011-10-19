From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [alsa-devel] [PATCH v6 2/2] ASoC: da7210: Add support for ALC and
 Noise suppression
Date: Wed, 19 Oct 2011 17:43:38 +0100
Message-ID: <CABS+qY0FnFk4gomSAvgRiwrVr+WVvqe-pTbicf2pLDcJkN4JZw@mail.gmail.com>
References: <1319014477.7230.53.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319014477.7230.53.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 19 October 2011 09:54, Ashish Chavan <ashish.chavan@kpitcummins.com>=
 wrote:
> This patch adds controls to set following ALC parameters,
> =C2=A0- Max gain, Min gain, Noise gain, Attack rate, Release rate and=
 delay
>
> It also adds a switch to enable/disable noise suppression.
>
> As per DA7210 data sheet, ALC and noise suppression can be enabled
> only if certain conditions are met. This condition checks are handled
> by simply using "_EXT" version of controls to capture change events.
>
> Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> ---
> Changes since v5:
> - Changed error code from -EPERM to EINVAL
> - Used bit fields instead of magic numbers
>
> Changes since v1:
> - Reading from register instead of cache
> - Made debug message more specific about error
> - Changed "Gain" to "Volume" in names of ALC controls
> ---
> =C2=A0sound/soc/codecs/da7210.c | =C2=A0110 +++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 110 insertions(+), 0 deletions(-)
>

Acked-by: Liam Girdwood <lrg@ti.com>

Thanks

Liam
