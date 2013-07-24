From: John Spencer <maillist-alsa@barfooze.de>
Subject: question about alsa-lib commit 8c9e4114 (Add struct
 timeval and timespec definition when _POSIX_C_SOURCE is not defined)
Date: Wed, 24 Jul 2013 03:10:11 +0200
Message-ID: <51EF2973.20703@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B9E2651E5
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 03:15:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

the commit 
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=8c9e4114a23aad96b4b9570624a4fd96745dfe01

was added in 2006 with a FIXME hint that it could cause a build error.
this is exactly what happens when using the header with musl libc to 
build software depending on alsa-lib (for example "sweep").

may i ask what for this hack was added ? i suspect it's for supporting 
some ancient version of glibc that didnt define those structs.
in that case something like

#if defined(__GLIBC__) && (__GLIBC__ < 2)

would probably make more sense.
i could even imagine that the target for the hack is no longer supported 
anyway, so i think it could simply be removed.

the problematic part is that it's the job of the *application* to 
request the POSIX namespace, not the job of the libc.

since sweep's build environment does not set _POSIX_SOURCE, the code 
gets activated and causes a conflict.

--JS

p.s.
thanks for applying the signal.h patch!
