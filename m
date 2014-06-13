From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA 1.0.28 release - request for testing
Date: Fri, 13 Jun 2014 13:02:01 +0200
Message-ID: <539ADA29.50508@canonical.com>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>	<539AB5C7.6020501@perex.cz>	<539ABEF0.7020508@canonical.com>
 <s5hfvj9go7w.wl%tiwai@suse.de> <539AC54C.60504@canonical.com>
 <539ACD9A.5040209@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070502040305020603050709"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EADA26109C
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 13:01:59 +0200 (CEST)
In-Reply-To: <539ACD9A.5040209@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, jordi@debian.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070502040305020603050709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

While testing alsa-lib I found that the attached patch - which comes 
from Debian - probably should be applied upstream as well.

On 2014-06-13 12:08, Jaroslav Kysela wrote:
> Hello all,
>
>    ALSA 1.0.28 packages are available for testing at
>
> ftp://ftp.alsa-project.org/pub/testing/
>
>    Please, report any issues. I expect to announce the release on Monday.
>
> 					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project; Red Hat, Inc.
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------070502040305020603050709
Content-Type: text/x-patch;
 name="tests_lm_ftbfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tests_lm_ftbfs.patch"

>From 7a794ce0d1e28f191e113742ce1604334b4187f2 Mon Sep 17 00:00:00 2001
From: Jordi Mallach <jordi@debian.org>
Date: Fri, 28 Jun 2013 15:01:40 +0200
Subject: [PATCH] Add -lm to test programs to fix build failure.

Add -lm to test programs that use sin(), to fix a build failure with recent
binutils.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 test/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/Makefile.am b/test/Makefile.am
index 8705402..c1896f8 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -7,8 +7,10 @@ check_PROGRAMS=control pcm pcm_min latency seq \
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
+pcm_LDFLAGS= -lm
 pcm_min_LDADD=../src/libasound.la
 latency_LDADD=../src/libasound.la
+latency_LDFLAGS= -lm
 seq_LDADD=../src/libasound.la
 playmidi1_LDADD=../src/libasound.la
 timer_LDADD=../src/libasound.la
-- 
1.8.3.1


--------------070502040305020603050709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070502040305020603050709--
