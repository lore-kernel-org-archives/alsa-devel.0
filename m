From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 14 Aug 2013 11:27:00 +0800
Message-ID: <20130814032658.GA16915@S2101-09.ap.freescale.net>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id B9D4F261A0B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 05:26:57 +0200 (CEST)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 13, 2013 at 02:58:26PM -0300, Fabio Estevam wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
> > +Required properties:
> > +
> > +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
> 
> Can't we just use "fsl,fsl-spdif" instead?
> 
> > +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.

I do not think we need this general compatible string.  Device tree
compatible should be specific.

Shawn
