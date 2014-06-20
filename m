From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6: remove wrong spdif
	rxtx2 clock
Date: Fri, 20 Jun 2014 15:58:14 +0800
Message-ID: <20140620075812.GD28225@dragon>
References: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 by alsa0.perex.cz (Postfix) with ESMTP id B73902619D8
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 09:58:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2014 at 02:39:44AM +0300, Anssi Hannula wrote:
> The rxtx2 clock of i.MX6 S/PDIF is currently set to "asrc" clock.
> However, according to SoC documentation, rxtx2 is connected to
> ASRC_EXT_CLK, a different external clock.
> 
> Testing on Cubox-i system seems to confirm that: when fsl_spdif is
> forced to select rxtx2 as input clock, audio playback fails with an I/O
> error.
> 
> Set rxtx2 to the dummy clock by default to prevent fsl_spdif from
> selecting it.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> Cc: Mark Brown <broonie@kernel.org>

Applied both, thanks.
