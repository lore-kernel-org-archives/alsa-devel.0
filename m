From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000828]: sparc: "pcm_direct.c:165: warning: long int format, __suseconds_t arg (arg 6)"
Date: Wed, 19 Jan 2005 14:43:31 +0100
Message-ID: <55eecafd80502bceaa1088bc32a2b86c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3B47C24E
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 14:43:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=828> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   828
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2005 09:18 CET
Last Modified:              01-19-2005 14:43 CET
======================================================================
Summary:                    sparc: "pcm_direct.c:165: warning: long int format,
__suseconds_t arg (arg 6)"
Description: 
When building on sparc we get the following warning:

Making all in pcm
[...]
if /bin/sh ../../libtool --mode=compile sparc-linux-gcc -DHAVE_CONFIG_H
-I. -I. -I../../include -I../../include    -g -Wall -O2 -MT pcm_direct.lo
-MD -MP -MF ".deps/pcm_direct.Tpo" \
  -c -o pcm_direct.lo `test -f 'pcm_direct.c' || echo './'`pcm_direct.c;
\
then mv -f ".deps/pcm_direct.Tpo" ".deps/pcm_direct.Plo"; \
else rm -f ".deps/pcm_direct.Tpo"; exit 1; \
fi
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT pcm_direct.lo -MD -MP -MF .deps/pcm_direct.Tpo -c
pcm_direct.c  -fPIC -DPIC -o .libs/pcm_direct.o
pcm_direct.c: In function `get_tmp_name':
pcm_direct.c:165: warning: long int format, __suseconds_t arg (arg 6)
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT pcm_direct.lo -MD -MP -MF .deps/pcm_direct.Tpo -c
pcm_direct.c -o pcm_direct.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:43 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:18 jdthood        New Issue                                    
01-19-05 14:43 tiwai          Status                   new => resolved     
01-19-05 14:43 tiwai          Resolution               open => fixed       
01-19-05 14:43 tiwai          Assigned To               => tiwai           
01-19-05 14:43 tiwai          Note Added: 0003276                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
