From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit,
	no sound from line-in
Date: Sun, 25 Jun 2006 17:37:48 +0200
Message-ID: <acdabd4a5a53c6436ce710844413cf7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A9B821D
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jun 2006 17:37:49 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1331> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1331
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     feedback
Distribution:               Kubuntu 6.06
Kernel Version:             2.6.15-25
======================================================================
Date Submitted:             08-13-2005 01:27 CEST
Last Modified:              06-25-2006 17:37 CEST
======================================================================
Summary:                    MSI K8N's SB Live 24 bit, no sound from line-in
Description: 
I have a MSI K8N Platinum motherboard that has a SBLive! 24 bit
integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack like the pci version of the sb live 24
bit.

With this card I cannot hear any sound that come from line-in.
For Example I have a tv card, its output audio go into line-in: result is
I cannot hear nothing from the tv, I can only see channels without audio.

The "Capture feedback into playback" in the mixer change the mic's
volume.
There is nothing that change line-in's volume.
======================================================================

----------------------------------------------------------------------
 Cimmo - 06-25-06 17:34 
----------------------------------------------------------------------
Compiled alsa 1.0.11 final:
line-in doesn't work but now also mic stop to work, with 1.0.10 it
worked!

I can say this is a regression.

----------------------------------------------------------------------
 Cimmo - 06-25-06 17:37 
----------------------------------------------------------------------
Compiled and installed:
alsa-driver
alsa-lib
alsa-utils

Need something else?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 01:27 Cimmo          New Issue                                    
08-13-05 01:27 Cimmo          Distribution              => Fedora Core 4   
08-13-05 01:27 Cimmo          Kernel Version            => 2.6.12-1.1398-x86_64
08-13-05 01:41 jcdutton       Note Added: 0005798                          
08-13-05 01:42 jcdutton       Status                   assigned => feedback
08-13-05 18:30 Cimmo          Note Added: 0005807                          
08-31-05 15:14 Cimmo          Note Added: 0005989                          
08-31-05 18:59 rlrevell       Note Added: 0005991                          
09-10-05 10:31 jcdutton       Note Added: 0006107                          
10-19-05 19:13 Cimmo          Note Added: 0006496                          
11-07-05 00:02 jcdutton       Note Added: 0006610                          
11-07-05 11:07 Cimmo          Note Added: 0006612                          
11-11-05 19:33 Cimmo          Note Added: 0006678                          
12-13-05 13:16 jcdutton       Note Added: 0007007                          
12-13-05 13:34 Cimmo          Note Added: 0007015                          
04-09-06 21:40 jcdutton       Status                   feedback => assigned
04-09-06 21:42 jcdutton       Status                   assigned => closed  
04-09-06 21:42 jcdutton       Note Added: 0009185                          
06-25-06 17:34 Cimmo          Distribution             Fedora Core 4 => Kubuntu
6.06
06-25-06 17:34 Cimmo          Kernel Version           2.6.12-1.1398-x86_64 =>
2.6.15-25
06-25-06 17:34 Cimmo          Status                   closed => feedback  
06-25-06 17:34 Cimmo          Resolution               open => reopened    
06-25-06 17:34 Cimmo          Note Added: 0010515                          
06-25-06 17:37 Cimmo          Note Added: 0010516                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
