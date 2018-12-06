From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Use of_node_name_eq for node name
        comparisons
Date: Thu, 6 Dec 2018 01:30:48 +0000
Message-ID: <875zw7jvr1.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205195050.4759-33-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
Content-Language: en-US
Content-ID: <FFD6A0F1D3827746B1DACBD7F8675846@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org


Hi Rob

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> and "sai", so there's not any reason to use strstr and of_node_name_eq
> can be used instead.

I guess this patch is for FSL ?

> ---
>  sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
>  sound/soc/generic/simple-scu-card.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

But, this patch is including simple-scu-card.
Is this miss ?


Best regards
---
Kuninori Morimoto
