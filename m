From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: ALSA releasing scheme
Date: Wed, 17 May 2006 19:55:55 +0200
Message-ID: <m23bf8mt78.fsf@vador2.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6889B1A7
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 19:57:36 +0200 (MEST)
Received: from vador.mandriva.com (unknown [192.168.100.253])
	by office.mandriva.com (Postfix) with ESMTP id ECC165485B
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 19:57:35 +0200 (CEST)
Received: from vador2.mandriva.com (vador2.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id 9C9CF1BD5C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 19:55:55 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

As ALSA packager in Mandriva Linux (at least for the userland part),
I've a few questions:

I know there's no roadmap, that developent is driven by bug fixes and
improvments, not by a schedule, ..., but anyway:

1) Is there an estimate date of release for the next release?

2) Is it planned to desync releases of drivers and of the lib (when
it's know that no changes was made in config files that depends upon a
new kernel).

Especially, there're changes (bug fixes regarding segfaults for
example) or new features that do not depends on the actual alsa-kernel
version.

It would be nice if :
- either alsa-lib's trunk would be stabilized and released more often
  (so that these features got tested earlier)
- or bug fixes releases would be released for latest stable release
  (eg: alsa-lib-1.0.11.1, then alsa-lib-1.0.11.2, alsa-lib-1.0.11.3,
  ...)

Even if some changes are done in that area (mixer element vs userland
config files), since alsa team is pulling its changes into main kernel
from times to times, wouldn't it make sense to release alsa-lib more
often?

Or better, why not have a way to make it work across driver changes in
that area? (whip me if this is not an actual problem :-) )

It's not that unusual that for the same distro, some users need to
boot an older kernel (thus with maybe an older alsa-kernel part)
because of some reasons.

It's also not that unusual than one test several different kernels at
once (the more usual case maybe being switching between his distro's
kernel and the latest upstream kernel).


See you


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
