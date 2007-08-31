From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: compilation faillure (was: Re:  ALSA 1.0.15rc1)
Date: Fri, 31 Aug 2007 15:24:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0708311452050.7587@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
	<m2lkbrj3gd.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FA82103909
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 15:24:44 +0200 (CEST)
In-Reply-To: <m2lkbrj3gd.fsf@vador.mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Aug 2007, Thierry Vignaud wrote:

> Jaroslav Kysela <perex@suse.cz> writes:
> 
> > 	ALSA 1.0.15rc1 packages are released. Please, check 
> > http://www.alsa-project.org for download and changelog.
> 
> (...)
> Making all in simple
> make[3]: Entering directory `/home/tv/rpm/BUILD/alsa-lib-1.0.15rc1/modules/mixer/simple'
> if /bin/sh ../../../libtool --tag=CC --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include   -g -O
> 2 -W -Wall -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fstack-protector --param=ssp-buffer-size=4 -fexceptions -fomit-frame-pointer
>  -march=i586 -mtune=generic -fasynchronous-unwind-tables -MT python.lo -MD -MP -MF ".deps/python.Tpo" -c -o python.lo python.
> c; \
>         then mv -f ".deps/python.Tpo" ".deps/python.Plo"; else rm -f ".deps/python.Tpo"; exit 1; fi
>  gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include -g -O2 -W -Wall -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fstack-protector --param=ssp-buffer-size=4 -fexceptions -fomit-frame-pointer -march=i586 -mtune=generic -fasynchronous-unwind-tables -MT python.lo -MD -MP -MF .deps/python.Tpo -c python.c  -DPIC -fPIC -DPIC -o .libs/python.o
> ICECC[32088] 14:23:50: can't send joblocalmsg to daemon
> python.c:26:27: error: python/Python.h: No such file or directory

Oops, configure script does not detected location of python C header files. 
Fixed in HG.

You may disable building of python code with --disable-python and wait for 
1.0.15rc2.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
