From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 06/10] ASoC: dt-bindings: Document dl_mask
	property
Date: Thu, 25 Jul 2019 09:08:18 +0300
Message-ID: <CAEnQRZDt7b54YAu7w6vbGi9=OXk6rRv2k2y0tjL_GN4j1m3XdA@mail.gmail.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-7-daniel.baluta@nxp.com>
 <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C40CF800E8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 08:08:30 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id x1so34345505wrr.9
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 23:08:30 -0700 (PDT)
In-Reply-To: <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, linuxppc-dev@lists.ozlabs.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 2:14 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:29PM +0300, Daniel Baluta wrote:
> > SAI supports up to 8 data lines. This property let the user
> > configure how many data lines should be used per transfer
> > direction (Tx/Rx).
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 2e726b983845..59f4d965a5fb 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -49,6 +49,11 @@ Optional properties:
>
> > +  - fsl,dl_mask              : list of two integers (bitmask, first for RX, second
>
> Not quite in favor of the naming here; And this patch should
> be sent to the devicetree maillist and add DT maintainers --
> they would give some good naming advice.
>
> From my point of view, I feel, since data lines are enabled
> consecutively, probably it'd be clear just to have something
> like "fsl,num-datalines = <2 2>", corresponding to "dl_mask
> = <0x3 0x3>". I believe there're examples in the existing DT
> bindings, so let's see how others suggest.
>

Your suggestion looks good to me. Anyhow, after reading again the
documentation it seems that datalines are not always required to
be consecutive.

The need to be consecutive only when FIFO combine mode is enabled.
Will fix the documentation in the next version.
