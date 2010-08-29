From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: Add HP iPAQ RX1950 support
Date: Sun, 29 Aug 2010 14:54:43 +0100
Message-ID: <20100829135442.GA10500@opensource.wolfsonmicro.com>
References: <1282984632-12665-1-git-send-email-anarsoul@gmail.com>
	<1282985666-13973-1-git-send-email-anarsoul@gmail.com>
	<20100828090604.GB9324@opensource.wolfsonmicro.com>
	<201008291232.01044.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A58B24362
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 15:54:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008291232.01044.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 29, 2010 at 12:31:54PM +0300, Vasily Khoruzhick wrote:

> snd-soc-s3c24xx and snd-soc-s3c24xx-i2s are just drivers, but there's no 
> appropriate platform_device for them. So I'm getting this (with debug 
> enabled):

> soc-audio soc-audio: CPU DAI s3c24xx-i2s not registered
> soc-audio soc-audio: platform s3c24xx-pcm-audio not registered

> Who should register platform_device for these drivers?

This should be done by the arch/arm code for the board, referring to
platform devices defined for the CPU (Samsung support tends to make the
registration of devices optional rather than just registering everything
the CPU supports as many other platforms do).
