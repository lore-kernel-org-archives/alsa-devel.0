From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001980]: No Sound with module snd-hda-intel and no error output
Date: Thu, 20 Apr 2006 15:44:48 +0200
Message-ID: <ed8d5deca21dc5eef98ecc6d997f9f85@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3958F16E
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 15:44:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1980> 
======================================================================
Reported By:                zyfhie
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1980
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu
Kernel Version:             2.6.15-19-386
======================================================================
Date Submitted:             03-30-2006 14:43 CEST
Last Modified:              04-20-2006 15:44 CEST
======================================================================
Summary:                    No Sound with module snd-hda-intel and no error
output
Description: 
I just have ubuntu installed in my laptop,and there is no sound at all.
In dmesg|grep hda-intel there is no message,but I could see 
[4296289.511000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[4296330.997000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 201
[4296330.997000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
 
after rmmod snd-hda-intel &modprobe snd-hda-intel

I had tried many parm in my alsa-base such as model,position_fix.
Hope somebody could help!!! 

======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-06 15:34 
----------------------------------------------------------------------
What model is your laptop exactly?  I need it for a comment in the source
code.

----------------------------------------------------------------------
 zyfhie - 04-20-06 15:44 
----------------------------------------------------------------------
It's  "laptop-eapd"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-06 14:43 zyfhie         New Issue                                    
03-30-06 14:43 zyfhie         Distribution              => ubuntu          
03-30-06 14:43 zyfhie         Kernel Version            => 2.6.15-19-386   
04-01-06 00:28 error10        Note Added: 0009051                          
04-03-06 01:57 anarki         Note Added: 0009076                          
04-03-06 02:12 zyfhie         Note Added: 0009078                          
04-03-06 02:46 zyfhie         Note Added: 0009079                          
04-03-06 03:22 zyfhie         Note Added: 0009082                          
04-03-06 05:52 rlrevell       Note Added: 0009083                          
04-03-06 09:03 zyfhie         Note Added: 0009090                          
04-04-06 09:23 zyfhie         Note Added: 0009110                          
04-04-06 09:23 zyfhie         Issue Monitored: zyfhie                      
04-04-06 09:23 zyfhie         Issue End Monitor: zyfhie                    
04-04-06 09:24 zyfhie         Note Deleted: 0009090                        
04-20-06 15:34 tiwai          Note Added: 0009386                          
04-20-06 15:44 zyfhie         Note Added: 0009391                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
