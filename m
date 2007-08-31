From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: compilation faillure
Date: Fri, 31 Aug 2007 15:22:07 +0200
Message-ID: <m24pifj0u8.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
	<m2lkbrj3gd.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id F311F10398E
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 15:22:07 +0200 (CEST)
In-Reply-To: <m2lkbrj3gd.fsf@vador.mandriva.com> (Thierry Vignaud's message of
	"Fri\, 31 Aug 2007 14\:25\:38 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud <tvignaud@mandriva.com> writes:

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
> 
> >From where does come this header?
> Also this shows that configure.in misses some test...

looks like it doesn't use python-config at all :-(
