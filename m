From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000890]: no dialtone with modem & strange log "semaphore is not ready [0x1][0x701300]"
Date: Wed, 2 Mar 2005 15:19:43 +0100
Message-ID: <df8b6dda6aa18f0d93b6ac7b7daa6a71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1CA371F8
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2005 15:19:44 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000857.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=890> 
======================================================================
Reported By:                hothead
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   890
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9
======================================================================
Date Submitted:             02-08-2005 14:33 CET
Last Modified:              03-02-2005 15:19 CET
======================================================================
Summary:                    no dialtone with modem & strange log "semaphore is
not ready [0x1][0x701300]"
Description: 
Hi,

I want to tell you that snd-intel8x0m works with the
ag&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=232;re modem on
my 
thinkpad t41p. The problem is that I can not get the dialtone working.
Do you have any suggestion concerning this problem?


# System Information
# ***********************
System uname: 2.6.9-thinkpad-r1 i686 Intel(R) Pentium(R) M processor
1700MHz
Gentoo Base System version 1.6.9
Python:              dev-lang/python-2.3.4 [2.3.4
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1, Dec 30 2004,
09:19:20)]
distcc 2.16 i686-pc-linux-gnu (protocols 1 and 2) (default port 3632) 
[enabled]
dev-lang/python:     2.3.4
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.7.9-r1, 1.8.5-r3, 1.6.3, 1.9.4, 1.5
sys-devel/binutils:  2.15.92.0.2-r1
sys-devel/libtool:   1.5.10-r4
virtual/os-headers:  2.6.8.1-r2



# Furthermore I get curious messages from the driver:
# *********************************************************
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54


It would be great if you could help me!

Regards

Ruben Jenster
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000509 Conexant Moden &quot;not ready&quot;
related to          0000857 intel8x0m does not work on asus a3n laptop
======================================================================

----------------------------------------------------------------------
 perex - 03-02-05 14:12 
----------------------------------------------------------------------
Have you tried to load "snd-intel8x0" and "snd-intel8x0m" modules in
opposite order?

----------------------------------------------------------------------
 perex - 03-02-05 15:15 
----------------------------------------------------------------------
Alessandro Suardi <alessandro.suardi at gmail.com> wrote at linux-kernel
mailing list (so that it might be also incompatible codec):

slmodemd over snd-intel8x0m worked for me last week on 2.6.11-rc4-bk10:

Feb 24 23:19:07 incident chat[2554]: send (ATX3M0^M)
Feb 24 23:19:07 incident chat[2554]: timeout set to 120 seconds
Feb 24 23:19:07 incident chat[2554]: expect (OK)
Feb 24 23:19:07 incident chat[2554]: ^M
Feb 24 23:19:07 incident chat[2554]: ATX3M0^M^M
Feb 24 23:19:07 incident chat[2554]: OK
Feb 24 23:19:07 incident chat[2554]:  -- got it
Feb 24 23:19:07 incident chat[2554]: send (ATDT0,,xxxxxx^M)
Feb 24 23:19:07 incident chat[2554]: expect (CONNECT)
Feb 24 23:19:07 incident chat[2554]: ^M
Feb 24 23:19:07 incident chat[2554]: ATDT0,,xxxxxx^M^M
Feb 24 23:19:07 incident kernel: ALSA sound/pci/intel8x0m.c:401:
codec_semaphore: semaphore is not ready [0x1][0x301300]
Feb 24 23:19:07 incident kernel: ALSA sound/pci/intel8x0m.c:415:
codec_write 1:
semaphore is not ready for register 0x54
Feb 24 23:19:52 incident chat[2554]: CONNECT
Feb 24 23:19:52 incident chat[2554]:  -- got it
Feb 24 23:19:52 incident chat[2554]: send (^M)
Feb 24 23:19:52 incident chat[2554]: expect (ogin:)
Feb 24 23:19:52 incident chat[2554]:  28800^M
Feb 24 23:19:58 incident chat[2554]: ^M

[snipped rest of log]

That is - I do get the codec_semaphore messages (though the error code
 is slightly different), but the modem connection works fine.

----------------------------------------------------------------------
 perex - 03-02-05 15:19 
----------------------------------------------------------------------
Please, can you provide output of ac97*regs like in bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=509?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 14:33 hothead        New Issue                                    
02-08-05 14:33 hothead        Kernel Version            => 2.6.9           
03-02-05 14:12 perex          Note Added: 0003772                          
03-02-05 15:15 perex          Note Added: 0003778                          
03-02-05 15:17 perex          Relationship added       related to 0000509  
03-02-05 15:19 perex          Note Added: 0003779                          
03-02-05 15:19 perex          Relationship added       related to 0000857  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
