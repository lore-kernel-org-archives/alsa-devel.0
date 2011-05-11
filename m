From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Use spi_write() for SPI writes
Date: Wed, 11 May 2011 19:24:29 +0200
Message-ID: <20110511172428.GB31824@opensource.wolfsonmicro.com>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1305114833-7553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4DCAC454.6090005@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16BD0247CB
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:31:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DCAC454.6090005@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2011 at 10:16:04AM -0700, Lars-Peter Clausen wrote:

> This won't work. spi_write returns 0 or an error, but the snd_soc_cache
> framework expects the hw_write callback to return the number of bytes transferred.
> We need to keep do_spi_write to get i2c_transfer like semantics for the return
> value.
> The two patches[1] I send last weekm which do basically the same as your patch,
> but keep do_spi_write, work fine though.

Oh, fail.  We can still improve on the previous code by actually using
spi_write() rather than open coding it ourselves which is verbose, I'll
send a patch shortly.
