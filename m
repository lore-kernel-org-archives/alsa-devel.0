From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001124]: sound recording does not work
Date: Tue, 24 May 2005 21:03:23 +0200
Message-ID: <485a4322a2603a23208deaf229ea1583@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D5E641AA
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 21:03:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1124> 
======================================================================
Reported By:                demiurg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1124
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-24-2005 21:03 CEST
Last Modified:              05-24-2005 21:03 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-05 21:03 demiurg        New Issue                                    
05-24-05 21:03 demiurg        File Added: amixer                           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
