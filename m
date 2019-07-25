From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 09/10] ASoC: fsl_sai: Add support for SAI new version
Date: Thu, 25 Jul 2019 09:06:28 +0300
Message-ID: <CAEnQRZC+5OWwBJfifjeD_8zD3z9efdNMb4Ey0P1Ka+y63v-XNA@mail.gmail.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-10-daniel.baluta@nxp.com>
 <20190724233212.GD6859@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724233212.GD6859@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Viorel Suman <viorel.suman@nxp.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 2:32 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:32PM +0300, Daniel Baluta wrote:
> > New IP version introduces Version ID and Parameter registers
> > and optionally added Timestamp feature.
> >
> > VERID and PARAM registers are placed at the top of registers
> > address space and some registers are shifted according to
> > the following table:
> >
> > Tx/Rx data registers and Tx/Rx FIFO registers keep their
> > addresses, all other registers are shifted by 8.
>
> Feels like Lucas's approach is neater. I saw that Register TMR
> at 0x60 is exceptional during your previous discussion. So can
> we apply an offset-cancellation for it exceptionally? I haven't
> checked all the registers so this would look okay to me as well
> if there are more than just Register TMR.

It is not just TMR exceptional. There are like half of the registers.
Thus: half of the registers need to be shifted and half of them
need to stay the same as in previous version of SAI.

I'm not seeing yet a neater approach. Lucas idea would somehow
work if regmap will allow some sort of translation function applied
over registers before being accessed.

Maybe Mark has some clues here?

thanks,
daniel.
