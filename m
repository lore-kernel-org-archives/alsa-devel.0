From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
Date: Fri, 23 Aug 2013 13:08:28 -0600
Message-ID: <5217B32C.5070300@wwwdotorg.org>
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C47726158B
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 21:08:34 +0200 (CEST)
In-Reply-To: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, tomasz.figa@gmail.com, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/23/2013 02:04 AM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

The binding looks reasonable to me now. Thanks.

> diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c

> +	if (of_property_read_bool(np, "spdif-out")) {

I'd be tempted to safe those property values into a variable so that ...

> +	data->txdev = platform_device_register_simple("spdif-dit", -1, NULL, 0);
...
> +	data->rxdev = platform_device_register_simple("spdif-dir", -1, NULL, 0);

... those two statements could be conditional upon whether TX/RX were
required too.

However, this isn't a big deal, and could be cleaned up later.
