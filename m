From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add missed MODULE_LICENSE("GPL") for
	imx-pcm-fiq
Date: Mon, 12 Dec 2011 18:12:21 +0800
Message-ID: <20111212101220.GE31568@opensource.wolfsonmicro.com>
References: <1323676875.8204.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA184103973
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 11:12:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323676875.8204.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 04:01:15PM +0800, Axel Lin wrote:
> This driver can be built as module and the file header indicates that
> the driver is published under the GPL.
> Thus add MODULE_LICENSE("GPL") for it.

Applied, thanks - adding the additional information as Wolfram suggested
would also be good.
