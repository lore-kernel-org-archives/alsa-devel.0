From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000494]: aoss crashes (patch)
Date: Tue, 9 Nov 2004 16:32:06 +0100
Message-ID: <d36c92df7388a1c589a96183451aa56a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 581462A9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:32:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=494> 
======================================================================
Reported By:                stsp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - liboss
Issue ID:                   494
Category:                   
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-09-2004 20:46 CEST
Last Modified:              11-09-2004 16:32 CET
======================================================================
Summary:                    aoss crashes (patch)
Description: 
aoss always causes a SIGSEGV for me. Here is a
stack trace:
---
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x4002a76d in fopen
(path=0x40039c3a "/proc/mounts", mode=0x40039c38
"r")
    at alsa-oss.c:661
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x40036d4d in
print_access_vector () from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x40038971 in
setfscreatecon () from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x4002fc55 in _init ()
from /lib/libselinux.so.1
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x4000bf71 in
_dl_init_internal () from /lib/ld-linux.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x400007f5 in
_dl_start_user () from /lib/ld-linux.so.2
---
======================================================================

----------------------------------------------------------------------
 stsp - 09-13-04 18:01 
----------------------------------------------------------------------
Hmm, OK. Thanks for the hint.
Lets try that:

-----------

Summary: [ALSA-OSS] Always initialize pointers before use

Description:
This patch makes sure that the initialize() is always called
before any pointer to function is used. Somehow it happens
that the __attribute__((constructor)) is not always sufficient -
other libs may have that attribute either, and may call fopen()
from within their constructors, which leads to a SIGSEGV, that
this patch fixes. Perhaps the __attribute__((constructor)) is no
longer needed with that patch at all.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

----------------------------------------------------------------------
 tiwai - 09-13-04 18:08 
----------------------------------------------------------------------
Perfect :)

Now applied to CVS.  Thanks for the patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 20:46 stsp           New Issue                                    
09-09-04 20:46 stsp           File Added: alsa-oss.c.diff                    
09-13-04 15:49 tiwai          Note Added: 0001749                          
09-13-04 18:01 stsp           Note Added: 0001751                          
09-13-04 18:02 stsp           File Added: aoss_init_fix.diff                    
09-13-04 18:08 tiwai          Status                   new => resolved     
09-13-04 18:08 tiwai          Resolution               open => fixed       
09-13-04 18:08 tiwai          Assigned To               => tiwai           
09-13-04 18:08 tiwai          Note Added: 0001752                          
11-09-04 16:32 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
