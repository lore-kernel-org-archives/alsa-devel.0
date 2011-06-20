From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/4] ASoC: SAMSUNG: Move I2S common
	register definition
Date: Mon, 20 Jun 2011 11:32:32 +0100
Message-ID: <20110620103232.GE31864@opensource.wolfsonmicro.com>
References: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50D6C24436
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 12:32:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 04:36:18PM +0900, Sangbeom Kim wrote:

> +#define I2SCON		0x0
> +#define I2SMOD		0x4
> +#define I2SFIC		0x8
> +#define I2SPSR		0xc
> +#define I2STXD		0x10
> +#define I2SRXD		0x14
> +#define I2SFICS		0x18
> +#define I2STXDS		0x1c

It'd be better to namespace things in header files, though if the header
is only included in a single driver it doesn't really matter so much.
