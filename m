From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/4] extend ad1938 codec driver to ad193x
	supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 17:08:01 +0800
Message-ID: <3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f222.google.com (mail-gx0-f222.google.com
	[209.85.217.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 6306124607
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 10:08:23 +0100 (CET)
Received: by gxk22 with SMTP id 22so988235gxk.4
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 02:08:21 -0700 (PDT)
In-Reply-To: <1268902095.3773.6.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 4:48 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Thu, 2010-03-18 at 16:16 +0800, Barry Song wrote:
>> This patch extends ad1938 codec driver to support ad1936/7/8/9,
>> ad1936/7 use i2c bus, ad1938/9 use spi bus.
>> The driver is splitted into three:
>> ad193x.h and ad193x.c: common codec driver
>> ad193x-spi.c: ad193x codec spi driver
>> ad193x-i2c.c: ad193x codec i2c driver
>
> Is the new common driver code the same as the original driver minus any
> I2C/SPI changes ? It's difficult to see if anything else has been
> changed.
Basically, the codes are same except renaming ad1938 to ad193x.
>
> Btw, have a look at wm8731.c. This driver supports both I2C and SPI and
> is less churn than splitting out the code into three files.
We have many discussion about a driver to support both spi and i2c in
another device(ad714x). At the beginning, the way in wm8731.c is used,
then after many comments, people agree splitting the driver to three
modules is the best way. If you are interested in it, you may take a
look at "input/misc: add Analog Devices AD714x captouch input driver"
in linux-input maillist.

>
> Thanks
>
> Liam
>
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>
