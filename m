From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001346]: Nforce3-250 has no working support for front microphone
Date: Fri, 13 Jan 2006 00:14:51 +0100
Message-ID: <5a4e5f0c1a8fcf431342a21a89c3270e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0764159
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:14:51 +0100 (MET)
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


The issue 0001232 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1346> 
======================================================================
Reported By:                alchemyx
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1346
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.12
Resolution:                 fixed
Fixed in Version:           1.0.9
======================================================================
Date Submitted:             08-17-2005 11:04 CEST
Last Modified:              01-13-2006 00:14 CET
======================================================================
Summary:                    Nforce3-250 has no working support for front
microphone
Description: 
I have nforce3-250 based motherboard. It uses i8x0 drivers for its sound
chip, my output from lspci:

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb
AC'97 Audio Controller (rev a1)
        Subsystem: Giga-byte Technology: Unknown device a002
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 21
        I/O ports at e000
        I/O ports at e400 [size=128]
        Memory at fa002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

That soundcard is supported quite well. Playing and also recording sounds
just fine. Only problem is that I have front audio panel built in my case,
where I can connect microphone and headphones. Headphones work fine, but I
can't get recording from microphone connected to front panel.

Tweaking with mixer didn't help. Only solution was to use binary nvsound
from nvidia drivers which is, to be honest, poor quality. Also it works
fine under Windows.

So it seems that there is something missing or wrong in current i8x0
driver.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001232 Microphone in front bracket - very low ...
======================================================================

----------------------------------------------------------------------
 jirka - 08-18-05 18:43 
----------------------------------------------------------------------
This bug is probably duplicate of my bug #1232

https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=1232

try to record some very loud sound and maybe you will find that is is
actually recorder, but with very very very low volume.

----------------------------------------------------------------------
 alchemyx - 08-18-05 23:01 
----------------------------------------------------------------------
You are completly right. I can hear myself, but I need to turn up the
volume to the max and almost scream to the mic! :)

----------------------------------------------------------------------
 vsu - 08-19-05 12:41 
----------------------------------------------------------------------
If your motherboard has the Realtek ALC850 codec, you need to upgrade ALSA
drivers to 1.0.9 (or later) release - see bug #1232 for details.  The
codec type is shown by alsamixer and in
/proc/asound/card0/codec97#0/ac97#0-0.

If your motherboard has some other codec, please upload
/proc/asound/card0/codec97#0/* files and /etc/asound.state file, like the
reporter of #1232 did.

----------------------------------------------------------------------
 alchemyx - 08-19-05 17:36 
----------------------------------------------------------------------
It did solve that issue. Thank you! By the way I see some nice changes in
drivers (like easy choosing channels number, great).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 11:04 alchemyx       New Issue                                    
08-17-05 11:04 alchemyx       Distribution              => Gentoo          
08-17-05 11:04 alchemyx       Kernel Version            => 2.6.12          
08-18-05 18:43 jirka          Note Added: 0005851                          
08-18-05 23:01 alchemyx       Note Added: 0005859                          
08-18-05 23:04 alchemyx       Issue Monitored: alchemyx                    
08-19-05 12:41 vsu            Note Added: 0005868                          
08-19-05 17:36 alchemyx       Note Added: 0005870                          
01-13-06 00:14 rlrevell       Status                   new => resolved     
01-13-06 00:14 rlrevell       Fixed in Version          => 1.0.9           
01-13-06 00:14 rlrevell       Resolution               open => fixed       
01-13-06 00:14 rlrevell       Assigned To               => rlrevell        
01-13-06 00:14 rlrevell       Relationship added       has duplicate 0001232
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
