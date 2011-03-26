From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ad73311: drop I2C requirement
Date: Sat, 26 Mar 2011 17:39:06 +0000
Message-ID: <20110326173906.GC3535@opensource.wolfsonmicro.com>
References: <1301128710-3244-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 399E6103847
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 18:38:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301128710-3244-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 04:38:30AM -0400, Mike Frysinger wrote:
> From: Scott Jiang <scott.jiang@analog.com>
> 
> The AD73311 codec does not use I2C, so don't require it in Kconfig.
> 
> Signed-off-by: Scott Jiang <scott.jiang@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

I had to apply this one by hand, probably because of some of the other
changes in the Kconfig file in other patches in the series.
