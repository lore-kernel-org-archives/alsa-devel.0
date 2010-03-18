From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] extend ad1938 codec driver to ad193x
 supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 08:48:15 +0000
Message-ID: <1268902095.3773.6.camel@odin>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DB83245D0
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 09:48:19 +0100 (CET)
Received: by iwn42 with SMTP id 42so910481iwn.6
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 01:48:18 -0700 (PDT)
In-Reply-To: <1268900221-6833-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-18 at 16:16 +0800, Barry Song wrote:
> This patch extends ad1938 codec driver to support ad1936/7/8/9,
> ad1936/7 use i2c bus, ad1938/9 use spi bus.
> The driver is splitted into three:
> ad193x.h and ad193x.c: common codec driver
> ad193x-spi.c: ad193x codec spi driver
> ad193x-i2c.c: ad193x codec i2c driver

Is the new common driver code the same as the original driver minus any
I2C/SPI changes ? It's difficult to see if anything else has been
changed.

Btw, have a look at wm8731.c. This driver supports both I2C and SPI and
is less churn than splitting out the code into three files.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
