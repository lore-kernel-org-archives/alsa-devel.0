From: Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: Re: alsa-driver 0.9.0beta12 / make dep on x86
Date: Wed, 27 Mar 2002 22:55:40 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203272247440.16913-100000@pc24.sr.bham.ac.uk>
References: <Pine.LNX.4.31.0201280902090.1065-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailer3.bham.ac.uk (mailer3.bham.ac.uk [147.188.128.54])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA20455
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2002 23:55:55 +0100
Received: from pc24.sr.bham.ac.uk ([147.188.32.174])
	by mailer3.bham.ac.uk with esmtp (Exim 3.16 #2)
	id 16qMKS-0003K6-00
	for alsa-devel@alsa-project.org; Wed, 27 Mar 2002 22:55:40 +0000
In-Reply-To: <Pine.LNX.4.31.0201280902090.1065-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

Just to note that the buildrpm script / cvscompile is currently 
failing on x86 for the uda1341.c (ARM-specific) module.

gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/var/BUILD/alsa-driver-0.9.0beta12/include 
-I/lib/modules/2.4.18-19pre4ac2c1/build/include -O2 
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall 
-Wstrict-prototypes -fomit-frame-pointer -pipe  uda1341.c > .depend
uda1341.c:32:25: linux/l3/l3.h: No such file or directory
make[2]: *** [fastdep] Error 1

This causes the rpm building to bomb, as any error bombs out of the 
bulding process during rpm generation.

Perhaps a framework is needed for fastdep to be taught about 
architectural exclusions ?

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+
