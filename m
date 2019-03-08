From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
Date: Fri, 8 Mar 2019 18:27:06 +0200
Message-ID: <CAEnQRZAZ-8JYjJ0KRzbObYm_p7bfTacv5L2QoDXNmVsWbTjLNg@mail.gmail.com>
References: <20190308160933.29899-1-daniel.baluta@nxp.com> <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 8, 2019 at 6:16 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Fri, Mar 8, 2019 at 1:09 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Write initial words into SAI FIFO to reduce the underrun
> > error.
>
> Please provide a better explanation.

Hi Fabio,

Fair enough, will try to provide a better description in v2
that will also address your questions below.

>
> Why does performing these writes help?
>
> Also, the commit message says "reduce", so it seems this is a
> workaround instead of a proper fix?
