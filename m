From: "mjander " <mjander@embedded.cl>
Subject: devfs OSS /dev/sound/* problem.
Date: Mon, 10 Mar 2003 10:57:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303101057.AA55640994@embedded.cl>
Reply-To: <mjander@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from embedded.cl (correo1.ispchile.cl [200.29.13.60])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA04395
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 14:56:30 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I noticed the  following bug:

If i load more than one soundcard driver  (example ens1371 and
intel8x0),
with OSS support i  get a error message  from "devfs", that it 
"could not append
to /dev/sound", and the second  soundcard is  unable to create its
OSS /dev/sound/*
file nodes.

I noticed similar bugs in other OSS sound drivers before, but it
semes that very few people  use devfs. Yesterday i checked with
0.9rc8d (previous tests with 0.9rc7) and the problem is  still there.

I semes to me that the file node index passes to the corresponding
devfs_register() calls is static rather incremental or -1 for
automatic allocation as it should be.

Does this behave the same with any 2.5 kernel? I'm to much a
coward to try 2.5, last time i did, i lost very important data.

Kernel 2.4.20  + xfs
Dist: Debian SID
ALSA: 0.9rc8d
ARCH: i386


Best Regards

Manuel Jander.
.
__________________________________________________
Enviado via NewPlanet WebMail en embedded.cl


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
