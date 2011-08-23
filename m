From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [linux-next] ASoC: build failure if CONFIG_I2C=m
 && CONFIG_SPI=y && CONFIG_SND_SOC=y
Date: Tue, 23 Aug 2011 10:42:53 -0700
Message-ID: <20110823104253.d7768c82.rdunlap@xenotime.net>
References: <1314099960.13722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy8-pub.bluehost.com (oproxy8-pub.bluehost.com
	[69.89.22.20]) by alsa0.perex.cz (Postfix) with SMTP id 514382441D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 19:42:57 +0200 (CEST)
In-Reply-To: <1314099960.13722.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Aug 2011 19:46:00 +0800 Axel Lin wrote:

> 
> hi,
> I got below build failure if CONFIG_I2C=m && CONFIG_SPI=y && CONFIG_SND_SOC=y
> 
>   LD      .tmp_vmlinux1
> sound/built-in.o: In function `snd_soc_codec_set_cache_io':
> last.c:(.text+0x1cb80): undefined reference to `regmap_init_i2c'
> make: *** [.tmp_vmlinux1] Error 1


I don't know if this is the same failure or just similar:

ERROR: "regmap_exit" [drivers/mfd/wm8400-core.ko] undefined!
ERROR: "regmap_bulk_read" [drivers/mfd/wm8400-core.ko] undefined!
ERROR: "regmap_read" [drivers/mfd/wm8400-core.ko] undefined!
ERROR: "regmap_init_i2c" [drivers/mfd/wm8400-core.ko] undefined!
ERROR: "regmap_raw_read" [drivers/mfd/wm8400-core.ko] undefined!
ERROR: "regmap_write" [drivers/mfd/wm8400-core.ko] undefined!

Maybe MFD_WM8400 needs to select REGMAP_I2C ?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
