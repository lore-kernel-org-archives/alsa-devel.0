From: joy ping <joy@pingfm.org>
Subject: Re: 0.9 ooops... undefined reference to atexit in
 libm.so.6
Date: Wed, 10 Apr 2002 15:33:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0204101529030.2264-100000@localhost.localdomain>
References: <20020410132419.A284@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from audio13.medien.uni-weimar.de (audio13.medien.uni-weimar.de [141.54.172.33])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12106
	for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2002 15:32:23 +0200
In-Reply-To: <20020410132419.A284@pengouin.univ-valenciennes.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i had the same problems while compiling alsa-lib and alsa-apps, which
depends on alsa-lib. after linking it to libm this error disapears. i
really dont know why, there was some changes in glibc, read the glibc FAQ.

On Wed, 10 Apr 2002, Charles [iso-8859-1] Fl=E8che wrote:

> Hello everybody...
>
> Er... After my migration from 0.5 to 0.9, I've tried to recompile my
> application about rawmidi. So, my include is now #include
> <alsa/asoundlib.h>. Compilation is good, but linking says
> "/usr/lib/libm.so.6 : undefined reference to 'atexit' "???
>
> What's goin' on ?
>
> Thanx !
>
> Charles
>
> PS : If I've really understood, it's better to use 0.9 than 0.5, isn't
> it ?
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
