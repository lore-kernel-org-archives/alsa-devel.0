From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: mark some registers precious
Date: Wed, 23 Dec 2015 11:12:47 -0200
Message-ID: <CAOMZO5BmhYX1k5NTLtQR0d-QMO_CWoBYpvsbHLsGPne=Zv1FfA@mail.gmail.com>
References: <56771034.5080702@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56771034.5080702@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 20, 2015 at 6:31 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Mark some registers precious since their
> reads have side effects (like clearing flags).
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
