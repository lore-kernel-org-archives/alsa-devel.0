From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rc4 lib - build failing
Date: Wed, 23 Oct 2002 12:06:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210231206090.5772-100000@pnote.perex-int.cz>
References: <s5h8z0p32xd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA32451
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 12:07:26 +0200
In-Reply-To: <s5h8z0p32xd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Takashi Iwai wrote:

> At Wed, 23 Oct 2002 09:57:50 +0200 (CEST),
> Jaroslav wrote:
> > 
> > Hi all,
> > 
> > 	could everybody with problems of building alsa library (undefined 
> > symbol) send me version of ld? (ld --version)? I will try to add a 
> > detection of faulty ld to the configure script. Thanks.
> 
> as i reported before, it looks like a problem of libtool.
> libtool doesn't pass -Wl,xx options to linker, although ld itself
> supports the versioned symbols.
> sorry, i forgot to stress this theme.

And I forgot to your report. Sorry.

> well, checking libtool version in configure script would be one of
> easy solutions.

Doesn't exist a trick for older libtool?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
