From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: Set sdma peripheral type
	directly
Date: Thu, 25 Jul 2013 22:01:52 +0800
Message-ID: <20130725140150.GB19368@S2101-09.ap.freescale.net>
References: <1374745301-29508-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D5DE260879
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 16:02:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1374745301-29508-1-git-send-email-b42378@freescale.com>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 05:41:41PM +0800, Nicolin Chen wrote:
> Let CPU DAI drivers set SDMA periperal type directly to support more
> dma types(SPDIF, ESAI) other than only two for SSI.
> This will easily allow some non-SSI drivers to use the imx-pcm-dma
> as well.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
