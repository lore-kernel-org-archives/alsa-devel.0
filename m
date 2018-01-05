From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Compiling alsa-lib fails with lto
Date: Fri, 5 Jan 2018 12:07:20 +0100
Message-ID: <56760146-f3b1-985f-0384-f0de2b7f1268@perex.cz>
References: <AM0PR0402MB342656ED4BF898691F265412F31F0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
 <s5hfu7lbs9y.wl-tiwai@suse.de>
 <AM0PR0402MB34264C9A43A7B1ED313AEE95F31C0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
 <s5hefn44uqn.wl-tiwai@suse.de>
 <AM0PR0402MB3426999BBCE62DF1172F1F89F31C0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 425752677F1
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 12:07:26 +0100 (CET)
In-Reply-To: <AM0PR0402MB3426999BBCE62DF1172F1F89F31C0@AM0PR0402MB3426.eurprd04.prod.outlook.com>
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
To: John Frankish <john.frankish@outlook.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dne 5.1.2018 v 12:00 John Frankish napsal(a):
>>>>> Using gcc-7.2.0 and alsa-lib-1.1.5
>>>>>
>>>>> Is there a way to compile alsa-lib with lto (the method below works with alsa-plugins and alsa-utils)?
>>>>>
>>>>> Compiling alsa-lib like this works fine:
>>>>>
>>>>> CC="gcc -mtune=generic -Os -pipe" CXX="g++ -mtune=generic -Os 
>>>>> -pipe -fno-exceptions -fno-rtti" ./configure --prefix=/usr/local 
>>>>> --disable-static --localstatedir=/var 
>>>>> --with-configdir=/usr/local/etc/alsa
>>>>>
>>>>> ..but compiling with lto like this fails as per below:
>>>>>
>>>>> CC=" gcc -flto -fuse-linker-plugin -mtune=generic -Os -pipe" 
>>>>> CXX="g++ -flto -fuse-linker-plugin -mtune=generic -Os -pipe 
>>>>> -fno-exceptions -fno-rtti" ./configure --prefix=/usr/local 
>>>>> --disable-static --localstatedir=/var 
>>>>> --with-configdir=/usr/local/etc/alsa
>>>>>
>>>>> libtool: link: gcc -flto -fuse-linker-plugin -mtune=generic -Os 
>>>>> -pipe -o .libs/aserver aserver.o  ../src/.libs/libasound.so -lm 
>>>>> -ldl -lpthread -lrt
>>>>> /tmp/ccoTf6DH.ltrans0.ltrans.o: In function `pcm_shm_cmd':
>>>>> <artificial>:(.text+0xe7a): undefined reference to `snd_pcm_forward'
>>>>> ../src/.libs/libasound.so: undefined reference to `snd_timer_params_set_filter'
>>>>> ../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimension'
>>>>> ../src/.libs/libasound.so: undefined reference to `snd_ctl_elem_info_get_dimensions'
>>>>> collect2: error: ld returned 1 exit status
>>>>> make[1]: *** [Makefile:333: aserver] Error 1
>>>>> make[1]: Leaving directory '/usr/src/alsa-lib-1.1.5/aserver'
>>>>> make: *** [Makefile:338: all-recursive] Error 1 Command exited 
>>>>> with non-zero status 2
>>>>
>>>> That's interesting.  These are basically fallouts of the internal 
>>>> function calls, and they should have been called with INTERNAL() 
>>>> wrapper for covering the versioned symbols.
>>>>
>>>> I fixed the latest git tree, but still something doesn't work with 
>>>> linkage in aserver.  I guess Makefile.am in aserver needs to be 
>>>> fixed somehow, but I leave it as is for now, as you can work around 
>>>> it by disabling via the configure option.
>>>>
>>> Thanks - I'm not sure though what you mean by "configure option" - there is no "--disable-aserver"?
>>
>> It can be done by specifying --with-pcm-plugins without shm.
>> But it'd be good to have --disable-aserver option for the easiness (or at best fix the aserver build :)
>>
>>> In any case, libasound is built before "make" halts and is 29kb 
>>> smaller (stripped) with lto :)
>>
>> And does everything still work, hopefully?
>>
> Oops - spoke too soon :(
> 
> Using libasound from alsa-lib-1.1.5 compiled with  lto, but without your update from alsa git:
> 
> $ speaker-test -Ddefault:1 -c2 -t wav -l1
> 
> speaker-test 1.1.5
> 
> Playback device is default:1
> Stream parameters are 48000Hz, S16_LE, 2 channels
> WAV file(s)
> Rate set to 48000Hz (requested 48000Hz)
> speaker-test: relocation error: speaker-test: symbol snd_pcm_hw_params_get_buffer_size_min, version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link time reference

It looks like we should use 'externally_visible' flag for the versioned
symbols, too. It was introduces for '-fwhole-program' but it seems that
'-flto' sees this flag, too.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
