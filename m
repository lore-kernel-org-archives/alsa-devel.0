From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Date: Wed, 23 Dec 2015 11:12:12 -0200
Message-ID: <CAOMZO5ASGih_=QZeOZYizxTrjRUehsXdJJNojC+MTULkXD8H0A@mail.gmail.com>
References: <56770FE1.4060202@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 20, 2015 at 6:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> SACNT register should be marked volatile since
> its WR and RD bits are cleared by SSI after
> completing the relevant operation.
> This unbreaks AC'97 register access.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
