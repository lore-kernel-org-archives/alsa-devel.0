From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v3 0/4] ASoC: simple-card: multi DAI links extension
Date: Mon, 17 Mar 2014 03:49:56 +0000
Message-ID: <48a8fabe07e641c5a30640816555b955@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1394883134.git.moinejf@free.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: [PATCH v3 0/4] ASoC: simple-card: multi DAI links extension
> 
> This patch series extends the simple card driver to handle
> many DAI links as this exists in the Cubox audio subsystem.
> 
> -v3
> 	- remove 'Fix the reference count of device nodes'
> 		which is applied (Mark Brown)
> 	- new patch 'Simplify code'
> 	- dynamically allocate and use properties for all DAI links
> 		(Jyri Sarha and Li Xiubo)


This patch series looks good to me.

For this patch series:
Reviewed-by: Xiubo Li <Li.Xiubo@freescale.com>


Thanks,

--
Best Regards,
Xiubo


> - v2
> 	- change subject/comment about device node reference count
> 		(Mark Brown)
> 	- use a null size array instead of an implicit area for the DAI links
> 		(Li Xiubo)
> 	- update the reference count of the device node at end of probe
> 
> Jean-Francois Moine (4):
>   ASoC: simple-card: Simplify code
>   ASoC: simple-card: dynamically allocate the DAI link and properties
>   ASoC: simple-card: Handle many DAI links
>   ASoC: simple-card: Add DT documentation for multi-DAI links
> 
>  .../devicetree/bindings/sound/simple-card.txt      |  34 +++-
>  sound/soc/generic/simple-card.c                    | 181 +++++++++++++-------
> -
>  2 files changed, 145 insertions(+), 70 deletions(-)
> 
> --
> 1.9.0
> 
> 
