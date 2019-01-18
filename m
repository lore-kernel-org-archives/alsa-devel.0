From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
Date: Fri, 18 Jan 2019 08:41:25 -0200
Message-ID: <CAOMZO5AmnKP1XMjEi5UKW-cOpD=f5uqJD=+KhFMyydHCnmSsSg@mail.gmail.com>
References: <20190118090656.14201-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000io  clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks for the re-ordering:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
