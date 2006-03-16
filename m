From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001931]: Unknown AC97 codec, digital sound works
Date: Thu, 16 Mar 2006 19:28:37 +0100
Message-ID: <0b5c80290702b9a88aaa667627fc5fbb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 42209196
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 19:28:38 +0100 (MET)
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
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.15
======================================================================
Date Submitted:             03-16-2006 19:28 CET
Last Modified:              03-16-2006 19:28 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-16-06 19:28 marc           New Issue                                    
03-16-06 19:28 marc           File Added: aadebug.txt                      
03-16-06 19:28 marc           Distribution              => Gentoo Linux    
03-16-06 19:28 marc           Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
