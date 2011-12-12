From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] ASoC: build errors if CONFIG_SND_SOC=m &&
 CONFIG_SND_SOC_ALL_CODECS=m
Date: Mon, 12 Dec 2011 15:38:09 +0800
Message-ID: <1323675489.8204.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,
I got below build errors if CONFIG_SND_SOC=m && CONFIG_SND_SOC_ALL_CODECS=m.
( build test on linux-next 20111212 ).

  Kernel: arch/arm/boot/zImage is ready
  Building modules, stage 2.
  MODPOST 87 modules
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8974.ko] undefined!
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8940.ko] undefined!
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8753.ko] undefined!
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8510.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Here is my gcc version:
$ arm-eabi-gcc -v
Using built-in specs.
Target: arm-eabi
Configured with: /home/jingyu/projects/gcc/android-toolchainsrc/build/../gcc/gcc-4.4.3/configure --prefix=/usr/local --target=arm-eabi --host=x86_64-linux-gnu --build=x86_64-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++ --with-gmp=/home/jingyu/projects/gcc/toolchain_build/obj/temp-install --with-mpfr=/home/jingyu/projects/gcc/toolchain_build/obj/temp-install --disable-libssp --enable-threads --disable-nls --disable-libmudflap --disable-libgomp --disable-libstdc__-v3 --disable-sjlj-exceptions --disable-shared --disable-tls --with-float=soft --with-fpu=vfp --with-arch=armv5te --enable-target-optspace --with-abi=aapcs --with-gcc-version=4.4.3 --with-binutils-version=2.19 --with-gmp-version=4.2.4 --with-mpfr-version=2.4.1 --with-gdb-version=7.1.x --with-arch=armv5te --with-mul
 tilib-list=mandroid --with-sysroot=/usr/local/google/home/android/cupcake_rel_root --program-transform-name='s&^&arm-eabi-&'
Thread model: single
gcc version 4.4.3 (GCC)

Regards,
Axel
