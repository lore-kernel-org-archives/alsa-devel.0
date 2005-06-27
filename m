From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001209]: Headphone and Front Mic are switched
Date: Mon, 27 Jun 2005 16:26:28 +0200
Message-ID: <b3e810bed4b3992564002461b7aa90cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18A791DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 16:26:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1209> 
======================================================================
Reported By:                alfred-ganz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1209
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-23-2005 20:02 CEST
Last Modified:              06-27-2005 16:26 CEST
======================================================================
Summary:                    Headphone and Front Mic are switched
Description: 
I installed alsa-driver-1.0.9b.tar.bz2, and the back panel
assignments that I can test seem to be assigned properly.
However, there is some sound coming out of the front mike jack,
and input is accepted through the headphone jack. Since these
jacks work as expected with Windows XP, I suspect that they are
misassigned in the driver.
Hardware: RealTek ALC655 AC'97 with ALC880(D)

Please let me know if there is anything else that you need from
me.

Thank you, AG

======================================================================

----------------------------------------------------------------------
 alfred-ganz - 06-26-05 20:10 
----------------------------------------------------------------------
After some scrounging around in alsa-kernel/pci/hda/patch_realtek.c, I
have come to the conclusion that although I don't believe there is any
access to digital output on my system, the proper model to use is
6statack-digout (Watch the spelling, I don't presume this was intended!).
With this model selected as option, everything seems to fall into place.

Unfortunately the PCI code on my system doesn't yet recognize Class
0x0403,
but otherwise, here is the output from scanpci -vv for the device:
pci bus 0x0000 cardnum 0x1b function 0x00: vendor 0x8086 device 0x2668
 Intel Corp.  Device unknown
 CardVendor 0x1019 card 0xa884 (Card unknown)
  STATUS    0x0010  COMMAND 0x0006
  CLASS     0x04 0x03 0x00  REVISION 0x04
  BIST      0x00  HEADER 0x00  LATENCY 0x00  CACHE 0x08
  BASE0     0x00000000fbe38004  addr 0x00000000fbe38000  MEM 64BIT
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x01  INT_LINE 0x0a
  BYTE_0    0x03  BYTE_1  0x00  BYTE_2  0x00  BYTE_3  0x00
The vendor and device numbers seem to match the corresponding entries in
the
table in the code. It would be interesting to know why the device isn't
properly recognized.

----------------------------------------------------------------------
 tiwai - 06-27-05 16:26 
----------------------------------------------------------------------
OK, creating 6stack without digital is easy.  I'll work on it.

Just give the output of lspci -nv.  This should contain the PCI subsystem
IDs to recognize.  The PCI class ID is irrelevant.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-05 20:02 alfred-ganz    New Issue                                    
06-23-05 22:35 alfred-ganz    Note Added: 0005195                          
06-23-05 23:21 alfred-ganz    Note Added: 0005197                          
06-23-05 23:29 erik           Note Added: 0005198                          
06-23-05 23:55 alfred-ganz    Note Added: 0005201                          
06-24-05 11:13 tiwai          Note Added: 0005211                          
06-24-05 15:42 alfred-ganz    Note Added: 0005229                          
06-24-05 15:46 tiwai          Note Added: 0005230                          
06-24-05 16:07 alfred-ganz    Note Added: 0005231                          
06-24-05 16:34 tiwai          Note Added: 0005234                          
06-24-05 16:42 alfred-ganz    Note Added: 0005235                          
06-24-05 16:54 alfred-ganz    Note Added: 0005236                          
06-24-05 17:26 alfred-ganz    Note Added: 0005240                          
06-24-05 17:48 tiwai          Note Added: 0005243                          
06-24-05 19:14 alfred-ganz    Note Added: 0005250                          
06-24-05 20:01 alfred-ganz    Note Added: 0005251                          
06-24-05 20:07 tiwai          Note Added: 0005252                          
06-24-05 21:12 alfred-ganz    Note Added: 0005253                          
06-24-05 21:54 alfred-ganz    Note Added: 0005254                          
06-25-05 21:28 alfred-ganz    Note Added: 0005258                          
06-26-05 04:29 alfred-ganz    Note Added: 0005260                          
06-26-05 20:10 alfred-ganz    Note Added: 0005266                          
06-27-05 16:26 tiwai          Note Added: 0005276                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
