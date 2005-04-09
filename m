From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000433]: Clicking noise on some sample rates with Chaintech AV-710 (ICE1724)
Date: Sat, 9 Apr 2005 04:36:15 +0200
Message-ID: <b9bc76222e5d6807d85ff8c3a7a7b580@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B54F26E
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 04:36:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=433> 
======================================================================
Reported By:                cabbagerat
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   433
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-09-2004 11:36 CEST
Last Modified:              04-09-2005 04:36 CEST
======================================================================
Summary:                    Clicking noise on some sample rates with Chaintech
AV-710 (ICE1724)
Description: 
Playing sound at any sample rate other than 48000Hz produces a loud
clicking sound along with the expected sound. This started with the ALSA
included with kernel 2.6.7 (worked perfectly in 2.6.6).
Clicking sound is loudest at 44.1kHz, not present at 48Khz and soft but
noticeable at 96kHz.
I have tried playing with alsaplayer, aplay, mpg123 and a variety of
gstreamer based apps - all display this behavior. Both native alsa and OSS
emulation display the same problem.
======================================================================

----------------------------------------------------------------------
 cabbagerat - 09-01-04 23:23 
----------------------------------------------------------------------
Testing a bunch of kernel versions on both an Athlon (VIA KT133A chipset)
and an Athlon64 (VIA K8T800 chipset) system seems to indicate that the
clicking is linked to the kernel version. 2.6.7, 2.6.8 and 2.6.9-pre1 all
show the problem, where 2.6.8-mm1, mm3 and 2.6.9-pre1-mm1 all work as
expected - all with the same .config (just ran 'make oldconfig' to
update).

----------------------------------------------------------------------
 jdthood - 04-09-05 04:36 
----------------------------------------------------------------------
What's the status of this bug?  Any improvement in 2.6.10 or 2.6.11?
Does alsa-driver from tarball work better?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-09-04 11:36 cabbagerat     New Issue                                    
08-09-04 11:36 cabbagerat     Distribution              => Debian Unstable 
08-09-04 11:36 cabbagerat     Kernel Version            => 2.6.7           
08-09-04 11:37 cabbagerat     Issue Monitored: cabbagerat                    
08-21-04 02:40 av710user      Note Added: 0001603                          
08-22-04 10:04 cabbagerat     Note Added: 0001608                          
08-25-04 03:00 av710user      Note Added: 0001616                          
08-25-04 05:56 av710user      Note Added: 0001618                          
09-01-04 23:23 cabbagerat     Note Added: 0001681                          
12-03-04 23:00 escher9694     Issue Monitored: escher9694                    
04-09-05 04:36 jdthood        Note Added: 0004385                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
