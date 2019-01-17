From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 5/5] ASoC: imx-sgtl5000: lower log level for
 potential probe deferral cases
Date: Thu, 17 Jan 2019 12:00:37 +0200
Message-ID: <CAEnQRZCWb2G0Y93YhQZcdFWLwifN7gJAiGpZD8ve3ytSbsgzQQ@mail.gmail.com>
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-5-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-5-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 11:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
