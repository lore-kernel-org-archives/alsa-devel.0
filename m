From: Barry Song <21cnbao@gmail.com>
Subject: bug in spi and i2c dual buses codecs
Date: Mon, 29 Mar 2010 14:24:28 +0800
Message-ID: <3c17e3571003282324t2b0cf67aj93dc3c4d1e6c8ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f197.google.com (mail-yw0-f197.google.com
	[209.85.211.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E79B24494
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 08:25:03 +0200 (CEST)
Received: by ywh35 with SMTP id 35so3099804ywh.24
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 23:25:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark/Liam,
I think there is really a bug in spi and i2c dual buses codecs drivers, for
example, for any codec with two buses, if you config kernel like this:

SPI MASTER built-in
I2C                module
Codec           built-in

You will get a link error like this:
sound/built-in.o: In function `i2c_add_driver':
include/linux/i2c.h:423: undefined reference to `i2c_register_driver'
sound/built-in.o: In function `ad193x_modexit':
sound/soc/codecs/ad193x.c:537: undefined reference to `i2c_del_driver'
make: *** [.tmp_vmlinux1] Error 1

I remember that is also one reason why we have splitted this kind of driver
into three parts(codec core, i2c bus, spi bus).

In fact, if any bus is compiled as module and code is built-in, link error
will be reported.
Thanks
Barry
