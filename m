From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: Does anyone really have success experience with
 SPI codecs with new name-based SOC API?
Date: Mon, 22 Nov 2010 02:07:16 +0000
Message-ID: <1290391636.9850.5.camel@dplaptop.localdomain>
References: <1290079866.1496.55.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 539A31037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 03:07:22 +0100 (CET)
In-Reply-To: <1290079866.1496.55.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-18 at 14:31 +0300, Alexander wrote:
> Does anyone really have success experience with SPI codecs with new
> name-based SOC API?
> There are really few SPI codecs in ASoC subsystem, so I wonder if only I
> cannot bind my SPI codec to machine driver.
> 
> The codec is registered with name spi0.0 it's the behavior of SPI
> subsystem, I suppose. So the form is %s%d.%d and not %s.%d as supposed
> in fmt_single_name() in soc_core.c

Just use the registered codec name in the machine driver so soc-core can
match it correctly.  You should not worry about incompatibilities in the
naming convention between SPI registered devices and I2C ones.  The only
thing that we try to guarantee is to be able to uniquely identify the
devices on the system.

Thanks,
Dimitrios
