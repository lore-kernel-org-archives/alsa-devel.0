From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000611]: Can't access Digi32 with kernel 2.6.9
Date: Sun, 14 Nov 2004 20:17:06 +0100
Message-ID: <7a0c1b89c896ca585b95ab26460cb79f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4E3C222A
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2004 20:17:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=611> 
======================================================================
Reported By:                spirou
Assigned To:                martin
======================================================================
Project:                    ALSA - driver
Issue ID:                   611
Category:                   PCI - RME 32
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9-gentoo-r1
======================================================================
Date Submitted:             10-27-2004 03:44 CEST
Last Modified:              11-14-2004 20:17 CET
======================================================================
Summary:                    Can't access Digi32 with kernel 2.6.9
Description: 
The Driver for the digi32 in kernel 2.6.9 doesn't let me access the card.
All I get is a "Device busy". With 2.6.8 everything is fine.
lsmod shows the driver as loaded, permissions are the same as with 2.6.8.
======================================================================

----------------------------------------------------------------------
 martin - 11-14-04 15:07 
----------------------------------------------------------------------
It occurs in cases of "sample rate conversion"!

I've figured out that removing this line in snd_rme32_*_ops{} helps me:

//    .mmap =         snd_pcm_lib_mmap_iomem,

... at least on x86 running 2.4.26. But those lines were introduced in
1.45
because of architecture incompatibilities. So, undoing it will not solve
it
for all architectures and I fear it will only re-introduce another bug.

Maybe this problem exist also for rme96 and other cards...

----------------------------------------------------------------------
 martin - 11-14-04 20:17 
----------------------------------------------------------------------
spirou, can you please try out the pcmnative.patch. It fixes my problems
with 2.4, but I haven't yet tried it on 2.6. I hope this patch solves it
there, too.

Takashi, the vm_flag "VM_RESERVED" is also missing, but it seems that it's
not recommended... at least for me on rme32 at the moment.

--

Summary:

The patch adds the definition vm_private_data again to
snd_pcm_lib_mmap_iomem(). It got lost during the rewrite of the mmap
stuff.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 03:44 spirou         New Issue                                    
10-27-04 03:44 spirou         Distribution              => Gentoo Linux    
10-27-04 03:44 spirou         Kernel Version            => 2.6.9-gentoo-r1 
11-09-04 19:16 tiwai          Note Added: 0002341                          
11-10-04 02:47 spirou         Note Added: 0002354                          
11-10-04 11:04 martin         Note Added: 0002360                          
11-10-04 12:08 tiwai          Note Added: 0002363                          
11-10-04 22:09 martin         File Added: rme32.stracelog.WRONG.gz              
     
11-10-04 22:10 martin         File Added: rme32.stracelog.FINE.gz               
    
11-10-04 22:33 martin         Note Added: 0002377                          
11-10-04 22:37 martin         Note Added: 0002380                          
11-11-04 15:04 tiwai          Note Added: 0002388                          
11-11-04 16:11 martin         Note Added: 0002389                          
11-14-04 15:07 martin         Note Added: 0002408                          
11-14-04 20:05 martin         File Added: pcmnative.patch                    
11-14-04 20:17 martin         Note Added: 0002409                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
