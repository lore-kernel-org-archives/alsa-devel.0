From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: S3C24XX: Remove I2Sv3 specific
	check
Date: Wed, 9 Dec 2009 10:41:25 +0000
Message-ID: <20091209104125.GB17832@opensource.wolfsonmicro.com>
References: <1260333001-11565-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CECAB1037E3
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 11:41:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260333001-11565-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 01:30:01PM +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>

> Since, now the I2Sv3 driver itself figures out and provides the start
> address of the base register, the s3c64xx specific patch can be
> discarded in the I2Sv2 core code.

> -	if (!base) {
> -		struct resource *res = platform_get_resource(pdev,

This is used by the S3C24xx IIS as well so they need converting over
before this can be removed.  To be honest I hadn't realised that S3C64xx
was using this at all.
