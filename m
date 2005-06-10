From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001180]: Use of MIDI with SIS7018 (Trident driver) causes instant freeze
Date: Fri, 10 Jun 2005 21:49:41 +0200
Message-ID: <2153a56ee8eab4edee333d534fcc2200@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 746CC1A2
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 21:49:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1180> 
======================================================================
Reported By:                jindo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1180
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.11 (stock from kernel.org)
======================================================================
Date Submitted:             06-10-2005 21:49 CEST
Last Modified:              06-10-2005 21:49 CEST
======================================================================
Summary:                    Use of MIDI with SIS7018 (Trident driver) causes
instant freeze
Description: 
When using any kind of app which accesses port 64:0 (eg pmidi) or any
generic MIDI type app (eg Rosegarden), the machine hangs.  No response to
X, Magic SySRq or Ctrl-Alt-Del.  If a wave file is playing it enters a
constant 0.25s loop and the only option is to do a hardware reset.

I think that this is similar to bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001116, although I get
different
error messages.  Initially, no messages appeared onscreen or in the logs,
but after switching on debug mode and running in a non-X terminal I got
this before the machine hung:

mpu401_uart.c: 206: cmd: tx timeout (status = 0xd0)
mpu401_uart.c: 226: cmd: 0xff failed at 0x20 (status = 0xff, data =0x1)
mpu401_uart.c: 206: cmd: tx timeout (status = 0xff)
mpu401_uart.c: 226: cmd: 0x3f failed at 0x20 (status = 0x3f, data =0x1)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 21:49 jindo          New Issue                                    
06-10-05 21:49 jindo          Distribution              => Debian Sarge    
06-10-05 21:49 jindo          Kernel Version            => 2.6.11 (stock from
kernel.org)
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
