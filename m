From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001302]: Clicking noise when using kphone with the ALSA AD1816A sound driver
Date: Fri, 10 Feb 2006 07:35:20 +0100
Message-ID: <ac933d2516405d09621bf6369aba6e31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A782194
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 07:35:20 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1302> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1302
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             vanilla 2.6.11.12, vanilla 2.6.10, Debians 2.6.8-2
======================================================================
Date Submitted:             08-02-2005 17:29 CEST
Last Modified:              02-10-2006 07:35 CET
======================================================================
Summary:                    Clicking noise when using kphone with the ALSA
AD1816A sound driver
Description: 
Using kphone (VoIP softphone) with the ALSA native API and the AD1816A
sound driver a continuous clicking noise is heard approximately 3 times
per second. Using the OSS AD1816 with kphone(OSS API) sound driver on the
same system and kernel audio is crystal clear. Also audio latency is much
higher (0.3-0.5s guessed) compared to the OSS AD1816 (<0.1s, also guessed)
sound driver.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001300 modprobe goes into D-state when inserti...
======================================================================

----------------------------------------------------------------------
 tek01 - 11-07-05 13:17 
----------------------------------------------------------------------
I did some tests last weekend using Linux 2.6.14 and the in kernel ALSA,
ALSA 1.0.10rc2 and CVS from last Friday.
The ALSA version does not matter, however enabling preemption seems to
make the problem worse, whereas putting some load on the CPU (f.e.
compiling a kernel) with preemption disabled seems to almost cure the
problem.

I removed the sound card from my main test box, an AMD K7@800MHz and
plugged it into an old Pentium 133 box running a Debian 2.6.8 kernel. The
card is working fine in this box, however audio latency is still somewhat
higher than with the OSS driver, but within acceptable limits.

----------------------------------------------------------------------
 arromdee - 02-10-06 07:35 
----------------------------------------------------------------------
This sounds like my recent patch could have fixed this.  A function was
checking the bit pattern of its inputs to determine whether it was doing
capture or playback, but unfortunately capture and playback share the same
bit pattern, so turning on capture always turned on playback and produced
a continuous noise several times a second.  The noise depended on what
sound had been last played and thus could be louder or softer depending on
circumstances.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:29 tek01          New Issue                                    
08-02-05 17:29 tek01          Distribution              => Debian Sarge    
08-02-05 17:29 tek01          Kernel Version            => vanilla 2.6.11.12,
vanilla 2.6.10, Debians 2.6.8-2
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-03-05 10:11 perex          Relationship added       related to 0001300  
08-03-05 10:20 perex          Note Added: 0005613                          
08-03-05 12:09 tiwai          Note Added: 0005618                          
08-03-05 12:10 tiwai          Note Added: 0005619                          
10-31-05 17:48 rlrevell       Note Added: 0006588                          
11-07-05 13:17 tek01          Note Added: 0006614                          
01-12-06 03:43 Adrian Bunk    Issue End Monitor: Adrian Bunk                    
02-10-06 07:35 arromdee       Note Added: 0007993                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
