From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000831]: sparc: "alsa-oss.c:405: warning: long int format, __suseconds_t arg (arg 4)"
Date: Wed, 19 Jan 2005 14:35:37 +0100
Message-ID: <07da76491dd7562cbdf4f3e47ce79cca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AC41E24F
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 14:35:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=831> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - liboss
Issue ID:                   831
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2005 09:46 CET
Last Modified:              01-19-2005 14:35 CET
======================================================================
Summary:                    sparc: "alsa-oss.c:405: warning: long int format,
__suseconds_t arg (arg 4)"
Description: 
Making all in alsa
[...]
if /bin/sh ../libtool --mode=compile sparc-linux-gcc -DPACKAGE_NAME=\"\"
-DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\"
-DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"alsa-oss\" -DVERSION=\"1.0.8\"
-DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1
-DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1
-DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1
-DHAVE_LIBASOUND=1  -I. -I.     -Wall -g -O2 -MT alsa-oss.lo -MD -MP -MF
".deps/alsa-oss.Tpo" \
  -c -o alsa-oss.lo `test -f 'alsa-oss.c' || echo './'`alsa-oss.c; \
then mv -f ".deps/alsa-oss.Tpo" ".deps/alsa-oss.Plo"; \
else rm -f ".deps/alsa-oss.Tpo"; exit 1; \
fi
 sparc-linux-gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\"
-DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
-DPACKAGE=\"alsa-oss\" -DVERSION=\"1.0.8\" -DSTDC_HEADERS=1
-DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1
-DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1
-DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DHAVE_LIBASOUND=1
-I. -I. -Wall -g -O2 -MT alsa-oss.lo -MD -MP -MF .deps/alsa-oss.Tpo -c
alsa-oss.c  -fPIC -DPIC -o .libs/alsa-oss.o
alsa-oss.c: In function `dump_select':
alsa-oss.c:405: warning: long int format, __suseconds_t arg (arg 4)
 sparc-linux-gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\"
-DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
-DPACKAGE=\"alsa-oss\" -DVERSION=\"1.0.8\" -DSTDC_HEADERS=1
-DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1
-DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1
-DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DHAVE_LIBASOUND=1
-I. -I. -Wall -g -O2 -MT alsa-oss.lo -MD -MP -MF .deps/alsa-oss.Tpo -c
alsa-oss.c -o alsa-oss.o >/dev/null 2>&1

======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:35 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 09:46 jdthood        New Issue                                    
01-19-05 14:35 tiwai          Status                   new => resolved     
01-19-05 14:35 tiwai          Resolution               open => fixed       
01-19-05 14:35 tiwai          Assigned To               => tiwai           
01-19-05 14:35 tiwai          Note Added: 0003271                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
