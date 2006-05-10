From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001931]: Unknown AC97 codec, digital sound works
Date: Wed, 10 May 2006 17:07:16 +0200
Message-ID: <78a7fd4afb493c98b1b50849e4b75712@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA9D0185
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 17:07:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1931> 
======================================================================
Reported By:                marc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1931
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.15
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-16-2006 19:28 CET
Last Modified:              05-10-2006 17:07 CEST
======================================================================
Summary:                    Unknown AC97 codec, digital sound works
Description: 
Hi everyone,

i got a brandnew benq s53w notebook with intel ICH 6 chipset. the digital
audio out via spdif works great, but analog audio thru internal speakers
or headphone jack doesn't work at all.

the main problem i think is:
Intel ICH6 with unknown codec at 0xb0040800, irq 11

i investigated that the adding the following line 

{ 0x43585430, 0xfffffff0, "CX20468-21", NULL, NULL }

to ac97_codec.c affects the output above to

Intel ICH6 with CX20468-21 at 0xb0040800, irq 11.

but i think i've chosen the wrong driver...i've heard that benq uses a
conexand 20551 chip in this notebook.

question 1) how do i figure out which chip is mounted on my mainbord

and 

question 2) is this chip already supported?

and if not

question 3) how can i support those who can implement a driver for this?

i appended aadebug.txt for more information about my system.

thanks in advance
marc
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001134 alsa 1.0.9rc4 + intel 82801FB/.../ = No...
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-10-06 17:07 
----------------------------------------------------------------------
Closing - please add any new info to bug #1134

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-16-06 19:28 marc           New Issue                                    
03-16-06 19:28 marc           File Added: aadebug.txt                      
03-16-06 19:28 marc           Distribution              => Gentoo Linux    
03-16-06 19:28 marc           Kernel Version            => 2.6.15          
03-16-06 19:34 rlrevell       Relationship added       duplicate of 0001134
05-03-06 15:56 fedukoff       Issue Monitored: fedukoff                    
05-10-06 17:07 rlrevell       Status                   new => closed       
05-10-06 17:07 rlrevell       Note Added: 0009734                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
