From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: alsa cvs not building on top of 2.6.10-rc2-mm3-V0.7.32_14
Date: 09 Dec 2004 21:38:59 -0800
Message-ID: <1102657139.4096.5.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.Stanford.EDU (smtp2.Stanford.EDU [171.67.16.125])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AFD0D2F0
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 06:39:08 +0100 (MET)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by smtp2.Stanford.EDU (8.12.11/8.12.11) with ESMTP id iBA5d33J008747
	for <alsa-devel@alsa-project.org>; Thu, 9 Dec 2004 21:39:06 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

I can't seem to build current alsa cvs on top of
2.6.10-rc2-mm3-V0.7.32-14...

  CC [M]  /usr/src/redhat/BUILD/alsa-driver-1.0.7/acore/hwdep.o
  CC [M]  /usr/src/redhat/BUILD/alsa-driver-1.0.7/acore/memalloc.o
/usr/src/redhat/BUILD/alsa-driver-1.0.7/acore/memalloc.c:53: error:
initializer element is not constant
/usr/src/redhat/BUILD/alsa-driver-1.0.7/acore/memalloc.c:53: error:
(near initialization for `__param_arr_enable.num')
make[4]: *** [/usr/src/redhat/BUILD/alsa-driver-1.0.7/acore/memalloc.o]
Error 1
make[3]: *** [/usr/src/redhat/BUILD/alsa-driver-1.0.7/acore] Error 2
make[2]: *** [_module_/usr/src/redhat/BUILD/alsa-driver-1.0.7] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory
`/lib/modules/2.6.9-1.1.rdtV0.7.32_14.rhfc2.ccrma/build'
make: *** [compile] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.69519 (%build)

I read a couple of old messages regarding this but found no solution (or
did not search long enough :-)
 
-- Fernando




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
