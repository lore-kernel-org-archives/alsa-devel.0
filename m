From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000671]: ALSA sound cuts out w/ message: ALSA sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Date: Mon, 6 Dec 2004 02:24:03 +0100
Message-ID: <b640b92a8f6db581bab6021b0e9ccf2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 872E8380
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 02:24:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=671> 
======================================================================
Reported By:                brentcfisher
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   671
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-24-2004 06:36 CET
Last Modified:              12-06-2004 02:24 CET
======================================================================
Summary:                    ALSA sound cuts out w/ message: ALSA
sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Description: 
Particularily noticeable when watching a DVD via xine using AC3 Pass
Through.  Sound will cut out momentarily (usually for no more than a
second).  The skip is always accompanied by multiples of this message in
the /var/log/messages file:

Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer

These messages appear in the log file once or twice a minute although the
sound only noticable cuts out every few minutes .  Very annoying on an
HTPC.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-04 19:34 
----------------------------------------------------------------------
Hmm, intel8x0 driver doesn't have such messages.

In the case of via82xx, the DMA pointer reported by the hardware is
confused.  It happend often on a machine with broken ACPI support.

Anyway, try to enable POINTER_DEBUG in via82xx.c and recompile the driver.
 Then you'll get more detailed debug information.
Also, please show /proc/asound/card0/pcm0p/sub0/hw_params during the run.

----------------------------------------------------------------------
 brentcfisher - 12-06-04 02:24 
----------------------------------------------------------------------
tiwai,

Thanks for looking into this.  The information that you requested is below
- captured while playing back a DVD.  Hopefully this is helpful...

# cat /proc/asound/card0/pcm0p/sub0/hw_params
closed

Here is a snippit from /var/log/message with POINTER_DEBUG enabled:

Dec  5 18:20:23 samwise fail: idx = 0/16, lastpos = 0x1000, bufsize2 =
0x8000, offsize = 0x0, size = 0x1000, count = 0xfe0
Dec  5 18:20:23 samwise ALSA sound/pci/via82xx.c:738: invalid
via82xx_cur_ptr, using last valid pointer
Dec  5 18:20:23 samwise fail: idx = 0/16, lastpos = 0x1000, bufsize2 =
0x8000, offsize = 0x0, size = 0x1000, count = 0xfe0
Dec  5 18:20:23 samwise ALSA sound/pci/via82xx.c:738: invalid
via82xx_cur_ptr, using last valid pointer
Dec  5 18:20:23 samwise fail: idx = 0/16, lastpos = 0x1000, bufsize2 =
0x8000, offsize = 0x0, size = 0x1000, count = 0xfe0
Dec  5 18:20:23 samwise ALSA sound/pci/via82xx.c:738: invalid
via82xx_cur_ptr, using last valid pointer
Dec  5 18:20:23 samwise fail: idx = 0/16, lastpos = 0x1000, bufsize2 =
0x8000, offsize = 0x0, size = 0x1000, count = 0xfe0
Dec  5 18:20:23 samwise ALSA sound/pci/via82xx.c:738: invalid
via82xx_cur_ptr, using last valid pointer
Dec  5 18:20:23 samwise fail: idx = 0/16, lastpos = 0x1000, bufsize2 =
0x8000, offsize = 0x0, size = 0x1000, count = 0xfc0
Dec  5 18:20:23 samwise ALSA sound/pci/via82xx.c:738: invalid
via82xx_cur_ptr, using last valid pointer

Thanks again,
-Brent

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 06:36 brentcfisher   New Issue                                    
11-24-04 06:36 brentcfisher   Distribution              => Gentoo          
11-24-04 06:36 brentcfisher   Kernel Version            => 2.6.8.1         
11-24-04 06:47 brentcfisher   Note Added: 0002541                          
11-24-04 06:48 brentcfisher   Issue Monitored: brentcfisher                    
11-24-04 23:50 squarooticus   Note Added: 0002584                          
11-25-04 01:59 brentcfisher   Note Added: 0002585                          
11-25-04 06:45 squarooticus   Note Added: 0002586                          
12-02-04 19:34 tiwai          Note Added: 0002694                          
12-06-04 02:24 brentcfisher   Note Added: 0002725                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
