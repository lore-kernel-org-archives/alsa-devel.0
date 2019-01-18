From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/5] ASoC: imx-sgtl5000: lower log level
 for potential probe deferral cases
Date: Fri, 18 Jan 2019 08:41:52 -0200
Message-ID: <CAOMZO5CFM9Ryo14+M7GR3TFFj=7PypL0kwGactge7x05KKmeOA@mail.gmail.com>
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118090656.14201-2-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
