From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001159]: /tmp/ccN0wta4.s:6428: Warning: unterminated string; newline inserted
Date: Mon, 13 Feb 2006 09:19:28 +0100
Message-ID: <4c227ca4c880b478ddbde5ac3e84e5c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B8F71BF
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 09:19:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1159> 
======================================================================
Reported By:                jdthood
Assigned To:                jdthood
======================================================================
Project:                    ALSA - lib
Issue ID:                   1159
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   low
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 09:41 CEST
Last Modified:              02-13-2006 09:19 CET
======================================================================
Summary:                    /tmp/ccN0wta4.s:6428: Warning: unterminated string;
newline inserted
Description: 
if /bin/sh ../../libtool --mode=compile sparc-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I../../include -I../../include    -g -Wall -O2 -MT control.lo -MD -MP
-MF ".deps/control.Tpo" \
  -c -o control.lo `test -f 'control.c' || echo './'`control.c; \
then mv -f ".deps/control.Tpo" ".deps/control.Plo"; \
else rm -f ".deps/control.Tpo"; exit 1; \
fi
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c 
-fPIC -DPIC -o .libs/control.o
/tmp/ccN0wta4.s: Assembler messages:
/tmp/ccN0wta4.s:6428: Warning: unterminated string; newline inserted
 sparc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include
-g -Wall -O2 -MT control.lo -MD -MP -MF .deps/control.Tpo -c control.c -o
control.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 perex - 06-08-05 15:49 
----------------------------------------------------------------------
It looks like a specific sparc / binutils problem.

----------------------------------------------------------------------
 jdthood - 02-13-06 09:19 
----------------------------------------------------------------------
I don't see this warning in the build log for 1.0.11rc2 on sparc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 09:41 jdthood        New Issue                                    
06-08-05 15:49 perex          Note Added: 0004936                          
02-13-06 09:19 jdthood        Status                   new => resolved     
02-13-06 09:19 jdthood        Resolution               open => fixed       
02-13-06 09:19 jdthood        Assigned To               => jdthood         
02-13-06 09:19 jdthood        Note Added: 0008041                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
