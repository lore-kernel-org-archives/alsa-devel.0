From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002234]: ISA sscape driver does not
	find Soundscape Elite
Date: Thu, 29 Jun 2006 23:14:32 +0200
Message-ID: <224d77be48e09225a572ef3bfe06ad17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E6AEE2A6
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 23:14:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2234> 
======================================================================
Reported By:                tjallen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2234
Category:                   ISA - sscape
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.2
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             06-26-2006 15:52 CEST
Last Modified:              06-29-2006 23:14 CEST
======================================================================
Summary:                    ISA sscape driver does not find Soundscape Elite
Description: 
The ALSA driver builds fine, both as a module and built-in but
the driver does not find the Soundscape Elite card.
======================================================================

----------------------------------------------------------------------
 tjallen - 06-29-06 20:30 
----------------------------------------------------------------------
It is not a PnP card.  I have the following /etc/modules.conf:
------------------------------------------------------------
# ALSA portion
        alias char-major-116 snd
        alias snd-card-0 snd-sscape
	# module options should go here
        options snd-sscape port=0x539 irq=5 mpu_irq=9 dma=0 isapnp=0 

# OSS/Free portion
        alias char-major-14 soundcore
        alias sound-slot-0 snd-card-0
	
# card #1
	alias sound-service-0-0 snd-mixer-oss
	alias sound-service-0-1 snd-seq-oss
	alias sound-service-0-3 snd-pcm-oss
	alias sound-service-0-8 snd-seq-oss
	alias sound-service-0-12 snd-pcm-os
--------------------------------------------------
and I've tried, in desperation, the following modprobe.conf:
--------------------------------------------------
alias snd-card-0 snd-sscape
alias sound-slot-0 snd-sscape
options snd-sscape port=0x539 irq=5 mpu_irq=9 dma=0 
---------------------------------------------------

The output of sscape_ctl --directory /boot 
gives me:

Error opening hw:0,0: No such device

It's not clear to me from the documentation
exactly how to configure the soundscape cards
in general.  Perhaps I need to try to load 
the firmware at a different point or to 
turn on the option 
"Userspace firmware loading support (FW_LOADER)"
when I compile the kernel to get sscape_ctl
to work.  

None of the things I've tried seems to work.
Do I have the correct syntax in /etc/modules.conf?

----------------------------------------------------------------------
 rankincj - 06-29-06 23:14 
----------------------------------------------------------------------
What does it say in the kernel log when you try and load the snd-sscape
module? As far as I can see, the driver should write something as soon as
it hits a problem. You can examine the kernel log by running the "dmesg"
command.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 15:52 tjallen        New Issue                                    
06-26-06 15:52 tjallen        Distribution              => Slackware 10.2  
06-26-06 15:52 tjallen        Kernel Version            => 2.6.17.1        
06-26-06 22:57 Adrian Bunk    Issue Monitored: Adrian Bunk                    
06-28-06 23:25 rankincj       Note Added: 0010628                          
06-29-06 00:40 tjallen        Note Added: 0010630                          
06-29-06 17:57 tiwai          Note Added: 0010679                          
06-29-06 20:30 tjallen        Note Added: 0010701                          
06-29-06 23:14 rankincj       Note Added: 0010703                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
