From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000736]: modprobe snd-azx still gives segmentation fault
Date: Mon, 20 Dec 2004 16:23:48 +0100
Message-ID: <0e25965fc0fb1dcef394f2d77198f6df@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 858122CE
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 16:23:48 +0100 (MET)
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
Last Modified:              12-20-2004 16:23 CET
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
 tiwai - 12-20-04 16:06 
----------------------------------------------------------------------
Also, don't forget to compile with --with-debug option (as best
--with-debug=detect).  This will help to detect the buggy point.

----------------------------------------------------------------------
 fermier - 12-20-04 16:23 
----------------------------------------------------------------------
I already reported about oops.  Right, I did what you asked, here is the
proof

[fermier@khazad azx]$ ls -al
total 73
drwxr-xr-x   2 root root   112 Dec 20 07:09 ./
drwxr-xr-x  18 root root  1128 Dec 20 07:09 ../
-rw-r--r--   1 root root 14919 Dec 20 07:09 snd-azx.ko
-rw-r--r--   1 root root 54613 Dec 20 07:09 snd-hda-codec.ko
[fermier@khazad azx]$ ls -al
total 77
drwxr-xr-x   2 root root   112 Dec 20 16:18 ./
drwxr-xr-x  18 root root  1128 Dec 20 16:18 ../
-rw-r--r--   1 root root 15733 Dec 20 16:18 snd-azx.ko
-rw-r--r--   1 root root 57915 Dec 20 16:18 snd-hda-codec.ko
[fermier@khazad azx]$

As expected with the debuging included the files are slightly bigger.

When I do modprobe snd-azx, I still have the segmentation fault, but I do
not know where to read the debugging messages.  In /var/log somewhere?

root@khazad alsa-driver]# modprobe snd-azx
Segmentation fault
[root@khazad alsa-driver]#

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
12-20-04 16:05 tiwai          Note Added: 0002881                          
12-20-04 16:06 tiwai          Note Added: 0002882                          
12-20-04 16:23 fermier        Note Added: 0002884                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
