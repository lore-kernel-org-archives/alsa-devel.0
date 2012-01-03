From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: Optimize the array work to
 find rate_min and rate_max
Date: Tue, 3 Jan 2012 21:18:48 +0000
Message-ID: <20120103211848.GB6832@opensource.wolfsonmicro.com>
References: <1325414174.4978.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2EF1D1039F3
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 22:18:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325414174.4978.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 01, 2012 at 06:36:14PM +0800, Axel Lin wrote:
> For a given ir and fs, there is at most one possible match for the case
> mclk_ratios[ir][j].ratio * fs == freq.
> Thus we can break from the inner loop once a match is found.

Applied, thanks.
