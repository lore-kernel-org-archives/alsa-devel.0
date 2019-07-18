From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Thu, 18 Jul 2019 22:22:54 +0300
Message-ID: <CAEnQRZDk-O9B2iyjO=cnmqff6praf-SqNFsR=SM2Et-5Xxui5Q@mail.gmail.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <9ebe242b-ceac-6064-5b8b-698068fa11f0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DE1FF800D2
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 21:23:07 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id p17so29846120wrf.11
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 12:23:07 -0700 (PDT)
In-Reply-To: <9ebe242b-ceac-6064-5b8b-698068fa11f0@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Angus Ainslie <angus@akkea.ca>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 18, 2019 at 10:12 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2019-07-17 12:56, Lucas Stach wrote:
> >   static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
> >       .use_imx_pcm = false,
> > +     .has_version_registers = false,
> >       .fifo_depth = 32,
> >   };
> >
> >   static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
> >       .use_imx_pcm = true,
> > +     .has_version_registers = false,
> >       .fifo_depth = 32,
> >   };
> >
> > +static const struct fsl_sai_soc_data fsl_sai_imx8m_data = {
> > +     .use_imx_pcm = true,
> > +     .has_version_registers = true,
> > +     .fifo_depth = 128,
> > +};
> > +
> >   static const struct of_device_id fsl_sai_ids[] = {
> >       { .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
> >       { .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
> >       { .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> > +     { .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8m_data },
> >       { /* sentinel */ }
> >   };
>

Hi Czarek,

> These datas are populating quite rapidly. If you're planning for adding
> more (and/ or appending additional fields), declaring helper macro could
> prove useful.

There would be definitely more fields inside *_data structures. Anyhow,
not sure what do you mean by declaring a helper macro.

Can you provide an example and how would that be helpful?

thanks,
Daniel.
