From: John Frankish <john.frankish@outlook.com>
Subject: Compiling alsa-lib fails with lto
Date: Thu, 4 Jan 2018 13:29:42 +0000
Message-ID: <AM0PR0402MB342656ED4BF898691F265412F31F0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-oln040092071018.outbound.protection.outlook.com [40.92.71.18])
 by alsa0.perex.cz (Postfix) with ESMTP id C4CAE26782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 14:29:45 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Using gcc-7.2.0 and alsa-lib-1.1.5

Is there a way to compile alsa-lib with lto (the method below works with alsa-plugins and alsa-utils)?

Compiling alsa-lib like this works fine:

CC="gcc -mtune=generic -Os -pipe" CXX="g++ -mtune=generic -Os -pipe -fno-exceptions -fno-rtti" ./configure --prefix=/usr/local --disable-static --localstatedir=/var --with-configdir=/usr/local/etc/alsa

..but compiling with lto like this fails as per below:

CC=" gcc -flto -fuse-linker-plugin -mtune=generic -Os -pipe" CXX="g++ -flto -fuse-linker-plugin -mtune=generic -Os -pipe -fno-exceptions -fno-rtti" ./configure --prefix=/usr/local --disable-static --localstatedir=/var --with-configdir=/usr/local/etc/alsa

libtool: link: gcc -flto -fuse-linker-plugin -mtune=generic -Os -pipe -o .libs/aserver aserver.o  ../src/.libs/libasound.so -lm -ldl -lpthread -lrt
/tmp/ccoTf6DH.ltrans0.ltrans.o: In function `pcm_shm_cmd':
<artificial>:(.text+0xe7a): undefined reference to `snd_pcm_forward'
../src/.libs/libasound.so: undefined reference to `snd_timer_params_set_filter'
../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimension'
../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimensions'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:333: aserver] Error 1
make[1]: Leaving directory '/usr/src/alsa-lib-1.1.5/aserver'
make: *** [Makefile:338: all-recursive] Error 1
Command exited with non-zero status 2
