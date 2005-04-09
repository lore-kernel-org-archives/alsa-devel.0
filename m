From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000369]: SPDIF gives continous output on later versions of ALSA
Date: Sat, 9 Apr 2005 04:24:54 +0200
Message-ID: <47103b8f410ffb4541b6d7a00fb8aba8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A4EA926A
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 04:24:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=369> 
======================================================================
Reported By:                Alphix
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   369
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.4.25 and 2.6.7
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-06-2004 20:26 CEST
Last Modified:              04-09-2005 04:24 CEST
======================================================================
Summary:                    SPDIF gives continous output on later versions of
ALSA
Description: 
First I was using this box with Linux kernel 2.4.25 and ALSA 1.0.3 (both
downloaded and built myself). Everything worked great, I have both the
SPDIF and regular stereo jack connected to my reciever. 

The reason for this is that the OSS emulation won't work with the SPDIF as
it's underlying device. This was no problem however, since the reciever
could detect if there was activity on the digital input and automatically
switch between digital and analogous.

However, I've been working on moving to a 2.6 based kernel, and one of the
last few annoyances that stop me is that ALSA as shipped with the 2.6.7
kernel (it seems to be 1.0.5a) seems to fool the reciever into believing
that there is input on the SPDIF wire constantly. Therefore auto-switching
doesn't work anymore (playback via both devices still work, it's just the
autoswitching that stopped working so I now have to switch manually).

======================================================================

----------------------------------------------------------------------
 Alphix - 08-05-04 21:49 
----------------------------------------------------------------------
I've investigated this some more and it turns out that everything works as
expected when ALSA is built from sources downloaded from the ALSA website
on either a 2.4 or 2.6 kernel (tried 1.0.3, 1.0.5a and 1.0.6a and they all
worked on 2.4.25 and 2.6.7).

I've also managed to find out that the in-kernel ALSA tree (in 2.6.7)
*does* work as expected, provided that IEC958 is muted (then both digital
and analogue playback works as expected).

I don't know if the in-kernel version of ALSA or the out-of-kernel one is
the version which has got it wrong but it seems to me that they should be
consistent.

This is now a very minor severity as a easy workaround exists.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-04 20:26 Alphix         New Issue                                    
07-06-04 20:26 Alphix         Distribution              => Debian          
07-06-04 20:26 Alphix         Kernel Version            => 2.4.25 and 2.6.7
08-05-04 21:49 Alphix         Note Added: 0001537                          
04-09-05 04:24 jdthood        Status                   new => resolved     
04-09-05 04:24 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
