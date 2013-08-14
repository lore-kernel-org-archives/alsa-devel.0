From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 14 Aug 2013 10:09:12 +0800
Message-ID: <20130814020911.GA31651@MrMyself>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 44E9B261A0B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 04:23:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

   Thank you for the comments.

On Tue, Aug 13, 2013 at 02:58:26PM -0300, Fabio Estevam wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
> > +Required properties:
> > +
> > +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
> 
> Can't we just use "fsl,fsl-spdif" instead?
> 
> > +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.
> > +
> 
> I think this is not the usual approach we do with dt.
> 
> > +static const struct of_device_id fsl_spdif_dt_ids[] = {
> > +       { .compatible = "fsl,fsl-spdif", },
> 
> Isn't only the first entry enough here?

I just saw Mark's words as well. So I don't need to change this part right?
But I'd like to add imx35 on it.


> This MODULE_ALIAS name does not match the name you provided earlier:
> 
> .name = "fsl-spdif-dai"
>

I'll fix it in v5.

Best regards,
Nicolin Chen
