From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] Add master mode, tmd and right-j mode support
Date: Tue, 20 Jan 2015 23:15:54 -0200
Message-ID: <CAOMZO5DcpSsRi4UE8gCjT+w=OueB1pWtQPYphgeEsMNZ_EvK5w@mail.gmail.com>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Timur Tabi <timur@tabi.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo.Lee@gmail.com, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Zidan,

On Tue, Jan 20, 2015 at 10:21 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> Add sai master mode support.
> Add tdm slots support.
> Add Right-J mode support.
>
> Zidan Wang (3):
>   SoC: fsl_sai: add sai master mode support
>   ASoC: fsl_sai: Add support for tdm slots operation
>   ASoC: fsl_sai: Add support for Right-J mode
>
>  sound/soc/fsl/fsl_sai.c | 164 ++++++++++++++++++++++++++++++++++++++++++++----
>  sound/soc/fsl/fsl_sai.h |  13 +++-
>  2 files changed, 164 insertions(+), 13 deletions(-)

Not related to your series, but do you have a patch for imx6sx-sdb.dts
that adds sai support?

In the FSL version they use 'fsl,sdma-event-remap' property to specify
the SAI sdma channels, but this is not present in mainline? How are
you dealing with it?
