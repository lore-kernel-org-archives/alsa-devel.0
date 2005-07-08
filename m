From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000847]: alsa-tools 1.0.8 fail to compile on ppc64
Date: Fri, 8 Jul 2005 10:35:22 +0200
Message-ID: <2df4a13b1a8da8c2a5ca188cab21a277@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA75D17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:22 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=847> 
======================================================================
Reported By:                Markus Rothe
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Issue ID:                   847
Category:                   ac3dec
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             01-24-2005 21:09 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    alsa-tools 1.0.8 fail to compile on ppc64
Description: 
Hi,

I'm just trying to compile alsa-tools 1.0.8 on my G5, which runs Gentoo
Linux.

Here comes the output:

checking for ALSA CFLAGS... 
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.0... found.
checking for snd_ctl_open in -lasound... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: executing depfiles commands
if powerpc64-unknown-linux-gnu-gcc -DPACKAGE_NAME=\"\"
-DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\"
-DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"cspctl\" -DVERSION=\"0.2.0\"
-DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1  -I. -I.   -I/usr/include/fltk-1.1 
-mcpu=G5 -O3 -pipe -fsigned-char -mabi=altivec  -MT cspctl.o -MD -MP -MF
".deps/cspctl.Tpo" \
  -c -o cspctl.o `test -f 'cspctl.c' || echo './'`cspctl.c; \
then mv -f ".deps/cspctl.Tpo" ".deps/cspctl.Po"; \
else rm -f ".deps/cspctl.Tpo"; exit 1; \
fi
powerpc64-unknown-linux-gnu-gcc  -mcpu=G5 -O3 -pipe -fsigned-char
-mabi=altivec   -L/usr/lib/fltk-1.1  -lasound -lm -ldl -lpthread -o cspctl
 cspctl.o  -lasound -lm -ldl -lpthread
cspctl.o(.toc+0xe8): undefined reference to
`__invalid_size_argument_for_IOC'
collect2: ld returned 1 exit status
make: *** [cspctl] Error 1

======================================================================

----------------------------------------------------------------------
 Markus Rothe - 01-24-05 21:11 
----------------------------------------------------------------------
sorry, Category is wrong..

----------------------------------------------------------------------
 tiwai - 01-25-05 15:17 
----------------------------------------------------------------------
This probleam happens because the available ioctl size is only 13bits on
PPC64 while it's 14bit on x86.

Don't compile this program for PPC64.  It's only for ISA SB16 boards.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-05 21:09 Markus Rothe   New Issue                                    
01-24-05 21:10 Markus Rothe   Issue Monitored: Markus Rothe                    
01-24-05 21:11 Markus Rothe   Note Added: 0003397                          
01-25-05 15:17 tiwai          Status                   assigned => resolved
01-25-05 15:17 tiwai          Resolution               open => won't fix   
01-25-05 15:17 tiwai          Note Added: 0003401                          
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
