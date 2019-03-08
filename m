From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
Date: Fri, 8 Mar 2019 13:16:04 -0300
Message-ID: <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
References: <20190308160933.29899-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308160933.29899-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Fri, Mar 8, 2019 at 1:09 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Write initial words into SAI FIFO to reduce the underrun
> error.

Please provide a better explanation.

Why does performing these writes help?

Also, the commit message says "reduce", so it seems this is a
workaround instead of a proper fix?
