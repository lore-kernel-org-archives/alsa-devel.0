From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001866]: Build Error
Date: Wed, 22 Feb 2006 09:06:41 +0100
Message-ID: <ea497a9f91acf27fef2975b8f5408f7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 170491AA
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2006 09:06:41 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1866> 
======================================================================
Reported By:                mtlca
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1866
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-22-2006 09:06 CET
Last Modified:              02-22-2006 09:06 CET
======================================================================
Summary:                    Build Error
Description: 
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_shm.lo -MD -MP -MF .deps/pcm_shm.Tpo -c pcm_shm.c  -fPIC -DPIC -o
.libs/pcm_shm.o
if /bin/sh ../../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I.
-I../../include -I../../include    -g -O2 -MT pcm_file.lo -MD -MP -MF
".deps/pcm_file.Tpo" \
  -c -o pcm_file.lo `test -f 'pcm_file.c' || echo './'`pcm_file.c; \
then mv -f ".deps/pcm_file.Tpo" ".deps/pcm_file.Plo"; \
else rm -f ".deps/pcm_file.Tpo"; exit 1; \
fi
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
pcm_file.lo -MD -MP -MF .deps/pcm_file.Tpo -c pcm_file.c  -fPIC -DPIC -o
.libs/pcm_file.o
pcm_file.c: In function `snd_pcm_file_forward':
pcm_file.c:191: parse error before `n'
make[2]: *** [pcm_file.lo] Error 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-06 09:06 mtlca          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
