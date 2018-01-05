From: John Frankish <john.frankish@outlook.com>
Subject: Re: Compiling alsa-lib fails with lto
Date: Fri, 5 Jan 2018 06:18:36 +0000
Message-ID: <AM0PR0402MB34264C9A43A7B1ED313AEE95F31C0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
References: <AM0PR0402MB342656ED4BF898691F265412F31F0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
 <s5hfu7lbs9y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092072024.outbound.protection.outlook.com [40.92.72.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A20462679C5
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 07:18:37 +0100 (CET)
In-Reply-To: <s5hfu7lbs9y.wl-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > Using gcc-7.2.0 and alsa-lib-1.1.5
> > 
> > Is there a way to compile alsa-lib with lto (the method below works with alsa-plugins and alsa-utils)?
> > 
> > Compiling alsa-lib like this works fine:
> > 
> > CC="gcc -mtune=generic -Os -pipe" CXX="g++ -mtune=generic -Os -pipe 
> > -fno-exceptions -fno-rtti" ./configure --prefix=/usr/local 
> > --disable-static --localstatedir=/var 
> > --with-configdir=/usr/local/etc/alsa
> > 
> > ..but compiling with lto like this fails as per below:
> > 
> > CC=" gcc -flto -fuse-linker-plugin -mtune=generic -Os -pipe" CXX="g++ 
> > -flto -fuse-linker-plugin -mtune=generic -Os -pipe -fno-exceptions 
> > -fno-rtti" ./configure --prefix=/usr/local --disable-static 
> > --localstatedir=/var --with-configdir=/usr/local/etc/alsa
> > 
> > libtool: link: gcc -flto -fuse-linker-plugin -mtune=generic -Os -pipe 
> > -o .libs/aserver aserver.o  ../src/.libs/libasound.so -lm -ldl 
> > -lpthread -lrt
> > /tmp/ccoTf6DH.ltrans0.ltrans.o: In function `pcm_shm_cmd':
> > <artificial>:(.text+0xe7a): undefined reference to `snd_pcm_forward'
> > ../src/.libs/libasound.so: undefined reference to `snd_timer_params_set_filter'
> > ../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimension'
> > ../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimensions'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:333: aserver] Error 1
> > make[1]: Leaving directory '/usr/src/alsa-lib-1.1.5/aserver'
> > make: *** [Makefile:338: all-recursive] Error 1 Command exited with 
> > non-zero status 2
> 
> That's interesting.  These are basically fallouts of the internal function calls,
> and they should have been called with INTERNAL() wrapper for covering
> the versioned symbols.
> 
> I fixed the latest git tree, but still something doesn't work with linkage
> in aserver.  I guess Makefile.am in aserver needs to be fixed somehow,
> but I leave it as is for now, as you can work around it by disabling via the
> configure option.
>
Thanks - I'm not sure though what you mean by "configure option" - there is no "--disable-aserver"?

In any case, libasound is built before "make" halts and is 29kb smaller (stripped) with lto :)

John
