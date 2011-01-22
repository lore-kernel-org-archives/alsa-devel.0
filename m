From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix codec device id format used by
	some dai_links
Date: Sat, 22 Jan 2011 23:33:09 +0000
Message-ID: <20110122233309.GA22799@opensource.wolfsonmicro.com>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 678BF1037F9
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 00:32:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295735888-25527-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "for 2.6.37" <stable@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 22, 2011 at 11:38:07PM +0100, Lars-Peter Clausen wrote:

>  sound/soc/imx/wm1133-ev1.c                     |    2 +-

This at least is definitely wrong, the WM835x CODEC here is registered
as a platform device.  Please also check current kernels, a bunch of
these are already fixed.
