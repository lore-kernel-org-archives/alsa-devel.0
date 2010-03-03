From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix ak4104 register array
	access
Date: Wed, 3 Mar 2010 19:19:24 +0000
Message-ID: <20100303191924.GB1231@rakim.wolfsonmicro.main>
References: <1267166214-1977-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6752103977
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 20:19:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267166214-1977-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 26, 2010 at 02:36:54PM +0800, Daniel Mack wrote:
> Don't touch the variable 'reg' to construct the value for the actual SPI
> transport. This variable is again used to access the driver's register
> cache, and so random memory is overwritten.
> Compute the value in-place instead.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: stable@kernel.org

Applied, thanks.  Please CC Liam on ASoC commits.
