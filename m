From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000652]: Compilation fails (alsa-driver/drivers/serialmidi.c)
Date: Mon, 29 Nov 2004 20:28:57 +0100
Message-ID: <3c64d0a6c5f46fcfbefb7fd2dd521e79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B1E571C9
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 20:28:57 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=652> 
======================================================================
Reported By:                visit0r
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   652
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Unstable
Kernel Version:             2.6.10-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-18-2004 08:51 CET
Last Modified:              11-29-2004 20:28 CET
======================================================================
Summary:                    Compilation fails (alsa-driver/drivers/serialmidi.c)
Description: 
Both 1.0.7 and CVS compilation fail with following:

[...]
 CC [M] /usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c: In function
`tx_loop':
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: warning: passing
arg 3 of pointer to function makes integer from pointer without a cast
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: error: too many
arguments to function
make[4]: ***
[/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o] Error 1
make[3]: *** [/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers] Error 2
make[2]: *** [_module_/usr/src/alsa-cvs/alsa-driver/kbuild] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10-rc2'
make: *** [compile] Error 2

I tried it with gcc 3.2.3 (Debian), 3.3.5 (Debian 1:3.3.5-2) and
3.4.2 (Debian 3.4.2-3). Looks more like Linux version incompatibility?

======================================================================

----------------------------------------------------------------------
 rwfranz - 11-29-04 20:03 
----------------------------------------------------------------------
Happens on gentoo, also, using kernel version 2.6.10-rc2. I get exactly the
same error message from the alsa-driver package (1.0.7).

----------------------------------------------------------------------
 tiwai - 11-29-04 20:28 
----------------------------------------------------------------------
Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 08:51 visit0r        New Issue                                    
11-18-04 08:51 visit0r        Distribution              => Debian Unstable 
11-18-04 08:51 visit0r        Kernel Version            => 2.6.10-rc2      
11-29-04 20:03 rwfranz        Note Added: 0002659                          
11-29-04 20:28 tiwai          Status                   assigned => resolved
11-29-04 20:28 tiwai          Resolution               open => fixed       
11-29-04 20:28 tiwai          Note Added: 0002660                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
