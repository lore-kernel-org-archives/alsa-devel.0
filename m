From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Issues with tip alsa-lib (stable, 1.1.9)
Date: Tue, 18 Jun 2019 20:12:45 +0200
Message-ID: <21aba5e0-16e1-f406-267b-4ab4af9dd19d@perex.cz>
References: <20190618091424.6c61c97e98fe7bb02193b2d6dca4a85a.2b4174f59f.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F073DF89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 20:12:48 +0200 (CEST)
In-Reply-To: <20190618091424.6c61c97e98fe7bb02193b2d6dca4a85a.2b4174f59f.mailapi@email03.godaddy.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: scott andrew franco <samiam@moorecad.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 18. 06. 19 v 18:14 scott andrew franco napsal(a):
> A roundup of my current issues with the alsa-lib repository:
>  
> 1. No apparent .so (dynamic link) file output.
>  
> The configure and make instructions were followed, and no apparent .so
> resulted:
>  
> samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$ find . -name *.so
> samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$ find . -name *.a
> ./src/timer/.libs/libtimer.a
> ./src/rawmidi/.libs/librawmidi.a
> ./src/ucm/.libs/libucm.a
> ./src/topology/.libs/libtopology.a
> ./src/.libs/libasound.a
> ./src/hwdep/.libs/libhwdep.a
> ./src/seq/.libs/libseq.a
> ./src/mixer/.libs/libmixer.a
> ./src/control/.libs/libcontrol.a
> ./src/pcm/.libs/libpcm.a
> samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$
>  This has made it difficult to debug issues with the library.
>  Using the configure flags does not seem to have an effect on this, IE:
>  ./configure --enable-shared=yes --enable-static=no
>  Linux distributions have libasound.so files in them, so clearly it was
>  possible at some time in the past.

You don't send the more details (config logs etc.) so it's difficult to see
what's going wrong with your distribution and configuration. Ubuntu is
specific. If you miss something, send us a patch for the review and inclusion.

>  2. Build instructions are conflicting.
>  ./configure
>  make
>  Does work on this version. This is the standard GNU build method, and I 
>  have seen these build instructions around the internet for building alsa.
>  The INSTALL file recommends:
>  ./gitcompile
>  Which also (appears) to work, but no reason appears for why this special
>  file is needed or what it does that is different. I can't get a .so (dynamic library
>  from the build, so I can't check the function of the resulting build.
>  Is there a reason the instructions from ./gitcompile cannot be merged back
>  into the make?

If you compile from the repository, gitcompile should be used, otherwise use
the tar ball. The ALSA website allows to generate/download the latest tar ball
with the autoconf/automake/libtool scripts bundled.

>  3. make install brings the system down.
>  Executing:
>  make install
>  Brought my ubuntu 18.04 sound system down. I had to reinstall Ubuntu to get
>  it to work again.

Distributions usually do own modifications in the default ALSA library
configurations. The best way is to use LD_PRELOAD when you compile your own
alsa-lib for the debugging to not broke the system's dependencies.

>  In summary, ALSA is not a development project anymore. It is the "official sound
>  system of Linux" and is part of the kernel. There is a lot of activity on the ALSA
>  list. Cannot some effort be put into professionalizing the repository?

??? I see your frustration, but we are not responsible how distributions adapt
the universal code.

						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
