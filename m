From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B
 format problems in imx-ssi.
Date: Tue, 1 Mar 2011 23:31:45 +0000
Message-ID: <20110301233145.GE2560@opensource.wolfsonmicro.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B8172443D
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 00:31:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, b32542@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 01, 2011 at 03:02:06PM +0100, Javier Martin wrote:
> When choosing IMX_DMA flag, burtsizes are set to its default
> value (0) which leads to driver malfunction. Change them to 4.
> 
> DSP_B interface needs additional flag to match DSP_B formats
> as described in several codecs as wm8741 and aic3205.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Applied, thanks.
