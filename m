From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000829]: powerpc: "confmisc.c:879: warning: passing arg 2 of `snd_config_get_pointer' from incompatible pointer type"
Date: Mon, 30 May 2005 13:18:27 +0200
Message-ID: <30b145f7170bc142434ba45fad0ef8d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADA691C1
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:18:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=829> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   829
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2005 09:21 CET
Last Modified:              05-30-2005 13:18 CEST
======================================================================
Summary:                    powerpc: "confmisc.c:879: warning: passing arg 2 of
`snd_config_get_pointer' from incompatible pointer type"
Description: 
Making all in alisp
[...]
if /bin/sh ../libtool --mode=compile powerpc-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../include -I../include  -D__ppc__  -g -Wall -O2 -MT confmisc.lo -MD
-MP -MF ".deps/confmisc.Tpo" \
  -c -o confmisc.lo `test -f 'confmisc.c' || echo './'`confmisc.c; \
then mv -f ".deps/confmisc.Tpo" ".deps/confmisc.Plo"; \
else rm -f ".deps/confmisc.Tpo"; exit 1; \
fi
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT confmisc.lo -MD -MP -MF .deps/confmisc.Tpo -c
confmisc.c  -fPIC -DPIC -o .libs/confmisc.o
confmisc.c: In function `snd_func_private_pcm_subdevice':
confmisc.c:879: warning: passing arg 2 of `snd_config_get_pointer' from
incompatible pointer type
 powerpc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include
-D__ppc__ -g -Wall -O2 -MT confmisc.lo -MD -MP -MF .deps/confmisc.Tpo -c
confmisc.c -o confmisc.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:44 
----------------------------------------------------------------------
Yep, this should get fixed.
The problem is perhaps const void **.  Both const and "void **" are tricky
to use...

Anyway, thanks for these reports.

----------------------------------------------------------------------
 perex - 05-30-05 13:18 
----------------------------------------------------------------------
This warning should be fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:21 jdthood        New Issue                                    
01-17-05 09:30 jdthood        Note Added: 0003224                          
01-17-05 11:26 jdthood        Note Added: 0003233                          
01-18-05 16:49 jdthood        Note Added: 0003251                          
01-19-05 14:31 tiwai          Note Added: 0003269                          
01-19-05 14:39 jdthood        Note Added: 0003274                          
01-19-05 14:44 tiwai          Note Added: 0003277                          
05-30-05 12:59 perex          Category                 alisp => general    
05-30-05 13:18 perex          Status                   new => resolved     
05-30-05 13:18 perex          Resolution               open => fixed       
05-30-05 13:18 perex          Assigned To               => perex           
05-30-05 13:18 perex          Note Added: 0004807                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
