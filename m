From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001124]: sound recording does not work
Date: Fri, 30 Dec 2005 21:43:28 +0100
Message-ID: <c438327eded0dcc9b956c86658e58a35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E23A4184
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 21:43:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1124> 
======================================================================
Reported By:                demiurg
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1124
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-24-2005 21:03 CEST
Last Modified:              12-30-2005 21:43 CET
======================================================================
Summary:                    sound recording does not work
Description: 
Sorry if this is a duplicate - I could not find a way to search the
bagtrack 
system. My email to the mailing list was not answered and I did not find
anything in the archives, so...

I have an intel 810 based sound card :

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02).

It works great, except that I can't get sound recording to work. It
does works on windows, so HW is OK. On linux it records nothing but noise.
I
checked all the obvious places - mic and capture volumes in alsamixer,
etc. 

My system :

Vanilla FC3.
kernel  2.6.11-1.27_FC3smp
alsa-lib-1.0.6-8

lspci :
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)

CPU : Pentium4
motherboard : GA-8IPE1000
sound : onboard Realtek ALC850 CODEC 

amixer  contents :
see attachment

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 20:52 
----------------------------------------------------------------------
Any improvement in later releases?

----------------------------------------------------------------------
 demiurg - 12-30-05 21:41 
----------------------------------------------------------------------
Yep, it was actually cured in one of the latest updates to FC4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-05 21:03 demiurg        New Issue                                    
05-24-05 21:03 demiurg        File Added: amixer                           
12-30-05 20:52 rlrevell       Note Added: 0007260                          
12-30-05 21:41 demiurg        Note Added: 0007263                          
12-30-05 21:43 rlrevell       Status                   new => resolved     
12-30-05 21:43 rlrevell       Resolution               open => fixed       
12-30-05 21:43 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
