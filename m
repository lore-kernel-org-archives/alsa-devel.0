From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001385]: sound is low with SIS7012 alc655
Date: Sat, 18 Feb 2006 03:01:14 +0100
Message-ID: <8640601eb49b25a3e09e129affb73216@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82E511AE
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 03:01:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1385> 
======================================================================
Reported By:                brainstorm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1385
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.12
======================================================================
Date Submitted:             08-31-2005 20:42 CEST
Last Modified:              02-18-2006 03:01 CET
======================================================================
Summary:                    sound is low with SIS7012 alc655
Description: 
hello
I m french and I ve a problem with my notebook (medion 42469). It s
impossible to have sound in speaker (only a very low sound in headphones-
same problem with Mandrake 10 - 10.1 mandiva 2005 and now mandriva 2006
beta 3 with alsa 9)) I saw in the form men with the same problem and one
have a solution for his computer but it s not good for mine 

( ID 0001274 ....  
temporarily solution:
I hop this will help

cat > /proc/asound/IXP/codec97#0/ac97#0-0+regs <<EOF
00 0000
02 0a0a
...... )

Where is the solution ?
FRED


======================================================================

----------------------------------------------------------------------
 brainstorm - 02-15-06 12:43 
----------------------------------------------------------------------
When you compile your kernel with alsa 1.10.0 you must to notch the box
click on alsadebug (excuse for my english).
FRED

----------------------------------------------------------------------
 NesmrtelnyDzin - 02-18-06 03:01 
----------------------------------------------------------------------
Hi I have similar problem, sound from speakers but no from headphones.
I have alsa 1.0.11.rc2 - fc5test2. same card and chip

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 20:42 brainstorm     New Issue                                    
08-31-05 20:42 brainstorm     Kernel Version            => 2.6.12          
12-30-05 23:12 rlrevell       Note Added: 0007279                          
02-09-06 13:33 mulvila        Note Added: 0007977                          
02-15-06 12:43 brainstorm     Note Added: 0008079                          
02-18-06 03:01 NesmrtelnyDzin Note Added: 0008114                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
