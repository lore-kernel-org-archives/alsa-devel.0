From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: fsl_spdif: don't print
 EPROBE_DEFER as error
Date: Thu, 17 Jan 2019 12:01:07 +0200
Message-ID: <CAEnQRZBAPbQjMTPPjb3DHCJ1psVXkZTErt_zD6CbmWFCJ=TdNg@mail.gmail.com>
References: <20190117090640.12972-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 11:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
