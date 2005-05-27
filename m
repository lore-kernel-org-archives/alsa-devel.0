From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001129]: codec 0 is not valid
Date: Fri, 27 May 2005 17:22:11 +0200
Message-ID: <8ad2832bb181c3d89a678b4f20694f6a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EDB7D20F
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 17:22:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1129> 
======================================================================
Reported By:                afselby
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1129
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-26-2005 23:51 CEST
Last Modified:              05-27-2005 17:22 CEST
======================================================================
Summary:                    codec 0 is not valid
Description: 
repeatable error (/var/log/messages):
kernel: PCI: Setting latency timer of device 00:11.5 to  64
kernel: ALSA ../alsa-kernel/pci/via82xx.c:584: codec_read: codec 0 is not
valid for reg=0x7e, xval= 0x2fe0000, is [0xfe0000]
   NOTE: I modified source print to include reg & xval

today, once:
May 26 17:25:45 localhost kernel: ALSA ../alsa-kernel/pci/via82xx.c:797:
zero position is read
May 26 17:26:08 localhost kernel: ALSA ../alsa-kernel/pci/via82xx.c:797:
zero position is read
May 26 17:27:35 localhost modprobe: modprobe: Can't locate module
sound-slot-0
May 26 17:27:35 localhost modprobe: modprobe: Can't locate module
sound-service-0-6

======================================================================

----------------------------------------------------------------------
 tiwai - 05-27-05 12:35 
----------------------------------------------------------------------
This is likely a broken BIOS or a wrong ACPI support.
Try to turn off ACPI.

----------------------------------------------------------------------
 afselby - 05-27-05 17:22 
----------------------------------------------------------------------
Looks like this and  0001123 are closely related

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-05 23:51 afselby        New Issue                                    
05-27-05 00:28 afselby        Note Added: 0004740                          
05-27-05 12:35 tiwai          Note Added: 0004750                          
05-27-05 17:22 afselby        Note Added: 0004753                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
