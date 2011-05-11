From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: Use spi_write() for SPI writes
Date: Wed, 11 May 2011 10:16:04 -0700
Message-ID: <4DCAC454.6090005@metafoo.de>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1305114833-7553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A5C124426
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:16:45 +0200 (CEST)
In-Reply-To: <1305114833-7553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/11/2011 04:53 AM, Mark Brown wrote:
> do_spi_write() is just an open coded copy of do_spi_write() so we can
> delete it and just call spi_write() directly.  Indeed, as a result of
> recent refactoring all the SPI write functions are just very long
> wrappers around spi_write() which don't add anything except for some
> pointless copies so we can just use spi_write() as the hw_write
> operation directly.

This won't work. spi_write returns 0 or an error, but the snd_soc_cache
framework expects the hw_write callback to return the number of bytes transferred.
We need to keep do_spi_write to get i2c_transfer like semantics for the return
value.
The two patches[1] I send last weekm which do basically the same as your patch,
but keep do_spi_write, work fine though.

- Lars

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/039467.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/039468.html
