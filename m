From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
Date: Thu, 17 Jan 2019 10:04:38 -0200
Message-ID: <CAOMZO5AWvp0ALPF=Aq3rBWKe0qYNqU7cjZKDNVpFCoUsWXaOPQ@mail.gmail.com>
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-4-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

On Thu, Jan 17, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks good.

I would suggest making this patch the first one of the series, since
it is a bug fix and could potentially be applied to stable.

Thanks
