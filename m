From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 5/5] ASoC: imx-spdif: don't print
 EPROBE_DEFER as error
Date: Fri, 18 Jan 2019 08:43:10 -0200
Message-ID: <CAOMZO5BSxm2D3u7ns8G8EEi+jHG3EX+6Q52Sk-1cptJ0ATVL=Q@mail.gmail.com>
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-5-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118090656.14201-5-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Removing the goto would not be strictly necessary. However, if
> code gets added later, the cleanup in the EPROBE_DEFER case likely
> would get missed.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
