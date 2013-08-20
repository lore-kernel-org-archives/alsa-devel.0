From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v9 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Tue, 20 Aug 2013 10:16:28 -0600
Message-ID: <5213965C.6010908@wwwdotorg.org>
References: <cover.1376972170.git.b42378@freescale.com>
 <03182ed7464c156ec6345194d3f7ec920f753c2f.1376972170.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5284C261ACF
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 18:16:32 +0200 (CEST)
In-Reply-To: <03182ed7464c156ec6345194d3f7ec920f753c2f.1376972170.git.b42378@freescale.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com, s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/19/2013 10:32 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale
> S/PDIF controller that supports stereo playback and record feature.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.txt        |   54 +

What changed between v8 and v9?
