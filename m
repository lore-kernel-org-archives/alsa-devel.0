From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000576]: PCM device number wrong for iec958 on emu10k1
Date: Fri, 12 Nov 2004 12:28:46 +0100
Message-ID: <313a82fe725c4f09ca8d8db51412b155@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E793D280
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:28:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=576> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   576
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-09-2004 18:23 CEST
Last Modified:              11-12-2004 12:28 CET
======================================================================
Summary:                    PCM device number wrong for iec958 on emu10k1
Description: 
Package: libasound2
Version: 1.0.6-2
Severity: normal
Tags: patch

Hi,

passthrough of AC3 sound from xine with my Soundblaster
Live Value does not work any more with the current version
of ALSA. Xine reported snd_pcm_open(), no such device. I
suspect that the number of the iec958 PCM device has been
erroneously changed in EMU10K1.conf. After changing it
(back?) to 3, it works correctly, like with previous
versions. See the following mini-patch:

--- /usr/share/alsa/cards/EMU10K1.conf~ 2004-09-26 19:17:05.000000000
+0200
+++ /usr/share/alsa/cards/EMU10K1.conf  2004-10-08 22:29:14.000000000
+0200
@@ -223,7 +223,7 @@
	slave.pcm {
		type hw
		card $CARD
-		device 2
+               device 3
        }
        hooks.0 {
                type ctl_elems
									
This may probably the same as bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=274951.

Best Regards,
Martin (L)

-- System Information:
Debian Release: 3.1
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: i386 (i686)
Kernel: Linux 2.6.7-1-386
Locale: LANG=C, LC_CTYPE=C

Versions of packages libasound2 depends on:
ii  libc6                       2.3.2.ds1-16 GNU C Library: Shared
libraries an

-- no debconf information
======================================================================

----------------------------------------------------------------------
 jdthood - 10-13-04 11:52 
----------------------------------------------------------------------
OK, I assume that version mismatch is the root of the problem.
Linux 2.6.8.1 still contains ALSA 1.0.4, not 1.0.6.  This bug
report can be closed.

----------------------------------------------------------------------
 tiwai - 10-13-04 15:58 
----------------------------------------------------------------------
Closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 18:23 jdthood        New Issue                                    
10-11-04 10:12 pzad           Note Added: 0002071                          
10-11-04 10:55 jdthood        Note Added: 0002072                          
10-13-04 11:52 jdthood        Note Added: 0002119                          
10-13-04 15:58 tiwai          Status                   new => resolved     
10-13-04 15:58 tiwai          Resolution               open => fixed       
10-13-04 15:58 tiwai          Assigned To               => tiwai           
10-13-04 15:58 tiwai          Note Added: 0002124                          
11-12-04 12:28 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
