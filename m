From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-driver 0.9.0beta12 / make dep on x86
Date: Thu, 28 Mar 2002 20:13:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203282013370.504-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0203272247440.16913-100000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA05605
	for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2002 20:13:48 +0100
In-Reply-To: <Pine.LNX.4.44.0203272247440.16913-100000@pc24.sr.bham.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Mar 2002, Mark Cooke wrote:

> Hi everyone,
> 
> Just to note that the buildrpm script / cvscompile is currently 
> failing on x86 for the uda1341.c (ARM-specific) module.
> 
> gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
> -I/var/BUILD/alsa-driver-0.9.0beta12/include 
> -I/lib/modules/2.4.18-19pre4ac2c1/build/include -O2 
> -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall 
> -Wstrict-prototypes -fomit-frame-pointer -pipe  uda1341.c > .depend
> uda1341.c:32:25: linux/l3/l3.h: No such file or directory
> make[2]: *** [fastdep] Error 1
> 
> This causes the rpm building to bomb, as any error bombs out of the 
> bulding process during rpm generation.
> 
> Perhaps a framework is needed for fastdep to be taught about 
> architectural exclusions ?

Fixed. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
