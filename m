From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000978]: intel8x0 sound does not work on 2.6.10 kernel with alsa 1.0.8
Date: Fri, 30 Dec 2005 23:51:24 +0100
Message-ID: <2fc30d3071f9a89b8aedf025914ded0d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64756168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:51:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=978> 
======================================================================
Reported By:                johnz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   978
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC3
Kernel Version:             kernel-2.6.10-1.770_14.rhfc3.at
======================================================================
Date Submitted:             03-10-2005 06:37 CET
Last Modified:              12-30-2005 23:51 CET
======================================================================
Summary:                    intel8x0 sound does not work on 2.6.10 kernel with
alsa 1.0.8
Description: 
On an ASRock motherboard with SIS 7012 sound controller, the Sound works on
kernel-2.6.9-1.681_FC3. (The mixer controls don't work. Only the PCM mute
mixer control works; volume sliders have no effect.)  There is no sound
when I boot the same system with kernel-2.6.10-1.770_14.rhfc3.at or other
2.6.10 kernels with 1.0.8 alsa.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001381 No sound on Thinkpad T40p
======================================================================

----------------------------------------------------------------------
 johnz - 09-27-05 04:43 
----------------------------------------------------------------------
Problem is still present in most current fedora core 3 kernel and alsa
module.
uname -r
2.6.12-1.1378_FC3

rpm -q alsa-kmdl-2.6.12-1.1378_FC3
alsa-kmdl-2.6.12-1.1378_FC3-1.0.9rfb-40.rhfc3.at


0:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound
Controller (rev a0)
        Subsystem: ASRock Incorporation: Unknown device 7012
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c800 [size=256]
        I/O ports at c400 [size=128]
        Capabilities: [48] Power Management version 2

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:51 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-05 06:37 johnz          New Issue                                    
03-10-05 06:37 johnz          File Added: asound.state                     
03-10-05 06:37 johnz          Distribution              => FC3             
03-10-05 06:37 johnz          Kernel Version            =>
kernel-2.6.10-1.770_14.rhfc3.at
03-10-05 06:39 johnz          Issue Monitored: johnz                       
03-10-05 06:43 johnz          File Added: lsmod                            
03-10-05 14:39 tiwai          Note Added: 0003853                          
03-11-05 03:19 johnz          Note Added: 0003879                          
09-22-05 15:03 jdthood        Note Added: 0006342                          
09-27-05 04:43 johnz          Note Added: 0006403                          
09-29-05 12:02 jdthood        Relationship added       related to 0001381  
12-30-05 23:51 rlrevell       Note Added: 0007301                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
