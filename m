From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000736]: modprobe snd-azx still gives segmentation fault
Date: Mon, 20 Dec 2004 16:01:34 +0100
Message-ID: <7983e71a0d9053463abdb5ab20b16576@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E2E92AC
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 16:01:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=736> 
======================================================================
Reported By:                fermier
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   736
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Mandrake 10.1 Offficial
Kernel Version:             2.3.8.1-12mdk
======================================================================
Date Submitted:             12-20-2004 07:40 CET
Last Modified:              12-20-2004 16:01 CET
======================================================================
Summary:                    modprobe snd-azx still gives segmentation fault
Description: 
After having read the other errors reported for the CMI9880 sound chip and
that the CVS version has been fixed, I downloaded the latest CVS version
of the alsa-driver.  ./configure and make seem to complete without errors.
 After a make install a modprobe snd-azx still gives a segmentation fault
just like the normal tarred ball install and the previous CVS gave.  After
a modprobe snd-azx gave the segmentation fault a /sbin/lsmod hangs and
becomes a zombie process the same is true for modprobe -r snd or modprobe
-r snd-azx
======================================================================

----------------------------------------------------------------------
 tiwai - 12-20-04 15:38 
----------------------------------------------------------------------
I meant to make sure that you remove (clean up) module _files_  in
/lib/modules/.... before installation of the CVS version.  I suspect that
you're still seeing 1.0.7 module by some reason.  Or, make sure that
snd-azx.ko there is the latest one you installed from the CVS version
(e.g. checking the timestamp).

----------------------------------------------------------------------
 fermier - 12-20-04 16:01 
----------------------------------------------------------------------
This is the output from the directory:

[root@khazad azx]# pwd
/lib/modules/2.6.8.1-12mdksmp/kernel/sound/pci/azx
[root@khazad azx]# ls -al
total 73
drwxr-xr-x   2 root root   112 Dec 20 07:09 ./
drwxr-xr-x  18 root root  1128 Dec 20 07:09 ../
-rw-r--r--   1 root root 14919 Dec 20 07:09 snd-azx.ko
-rw-r--r--   1 root root 54613 Dec 20 07:09 snd-hda-codec.ko

It is the one I installed this morning.  I see no other snd-azx drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 07:40 fermier        New Issue                                    
12-20-04 07:40 fermier        Distribution              => Mandrake 10.1
Offficial
12-20-04 07:40 fermier        Kernel Version            => 2.3.8.1-12mdk   
12-20-04 08:31 rlrevell       Note Added: 0002868                          
12-20-04 13:04 fermier        Note Added: 0002871                          
12-20-04 13:05 fermier        Note Added: 0002872                          
12-20-04 14:27 tiwai          Note Added: 0002873                          
12-20-04 15:35 fermier        Note Added: 0002877                          
12-20-04 15:38 tiwai          Note Added: 0002878                          
12-20-04 16:01 fermier        Note Added: 0002879                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
