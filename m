From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000576]: PCM device number wrong for iec958 on emu10k1
Date: Wed, 13 Oct 2004 15:58:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013135836.E5C4C1B00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 535BD2F0
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 15:58:37 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000576
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     576
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             10-09-2004 18:23 CEST
Last Modified:              10-13-2004 15:58 CEST
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
									
This may probably the same as bug https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0274951.

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
 pzad - 10-11-2004 10:12 CEST 
----------------------------------------------------------------------
You should use same alsa-driver (in kernel) and alsa-lib version. Your
versions are diffrent. You probably have old alsa-driver (1.0.4) and new
alsa-lib (> 1.0.4).

----------------------------------------------------------------------
 jdthood - 10-11-2004 10:55 CEST 
----------------------------------------------------------------------
Thanks for the tip.  I will ask the bug submitters for version information.

----------------------------------------------------------------------
 jdthood - 10-13-2004 11:52 CEST 
----------------------------------------------------------------------
OK, I assume that version mismatch is the root of the problem.
Linux 2.6.8.1 still contains ALSA 1.0.4, not 1.0.6.  This bug
report can be closed.

----------------------------------------------------------------------
 tiwai - 10-13-2004 15:58 CEST 
----------------------------------------------------------------------
Closed.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 18:23 jdthood        New Bug                                      
10-11-04 10:12 pzad           Bugnote Added: 0002071                       
10-11-04 10:55 jdthood        Bugnote Added: 0002072                       
10-13-04 11:52 jdthood        Bugnote Added: 0002119                       
10-13-04 15:58 tiwai          Bugnote Added: 0002124                       
10-13-04 15:58 tiwai          Assigned To               => tiwai           
10-13-04 15:58 tiwai          Resolution               open => fixed       
10-13-04 15:58 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
