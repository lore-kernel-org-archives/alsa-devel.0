From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 4 Aug 2011 11:35:58 +0100
Message-ID: <20110804103558.GA25976@opensource.wolfsonmicro.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEE8C24584
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 12:36:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 04, 2011 at 06:24:04PM +0800, Scott Jiang wrote:

> My version is linux 3.0, I found snd_soc_spi_read/write didn't work at
> 16-8 bit mode.
> The addr is 16bit, the function compares reg with reg_cache_size. This
> certainly causes failure.
> In the former version, reg &= 0xff seems right. So how to use
> snd_soc_16_8_write now?

reg &= 0xff is clearly broken for 16 bit register values...

Note that all this code will be replaced with regmap for 3.2.
