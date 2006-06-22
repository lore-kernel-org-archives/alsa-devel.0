From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002216]: Install problem and more
Date: Thu, 22 Jun 2006 17:38:23 +0200
Message-ID: <7cf7b9dde3f739637ed1950b0223f615@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DA4E220
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jun 2006 17:38:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2216> 
======================================================================
Reported By:                hexer
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2216
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora core 4
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             06-17-2006 13:38 CEST
Last Modified:              06-22-2006 17:38 CEST
======================================================================
Summary:                    Install problem and more
Description: 

on your page says to do the following:
I opend a terminal, su, and created the dirs. Some worked fine, but I got
errors. Here they are:

modinfo soundcore
when I run this, it says: bash: modinfo: command not found

the chmod a+rw /dev/dsp /dev/mixer /dev/sequencer /dev/midi gives the
following error:
chmod: cannot access `/dev/dsp': No such file or directory
chmod: cannot access `/dev/mixer': No such file or directory
chmod: cannot access `/dev/sequencer': No such file or directory
chmod: cannot access `/dev/midi': No such file or directory

and after installing the driver, lib and utils, and runing "modprobe
snd-ca0106;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe
snd-seq-oss"
it says 
bash: modprobe: command not found
bash: modprobe: command not found
bash: modprobe: command not found
bash: modprobe: command not found

I did this once before, as root (logedin as root from the begining, not
using su), but with a wrong driver (a 5.1 creative), while I actualy had a
7.1 Creative. then only the first modeprobe didn't work, and the chown
giving the exact same error. oh, and alsamixer didn't start.

what can I do? I don't know to much about compiling kernels,  but am
willing to learn. Please help.

======================================================================

----------------------------------------------------------------------
 adeel - 06-22-06 17:38 
----------------------------------------------------------------------
Hi man i am also using fedora care 4. and had also creative sound blaster
live! 24 bit. I am worse then you.
Can you help me which driver and from where you downloaded the driver,
plus the lib and utils.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-06 13:38 hexer          New Issue                                    
06-17-06 13:38 hexer          Distribution              => Fedora core 4   
06-17-06 13:38 hexer          Kernel Version            => 2.6.11-1.1369_FC4
06-18-06 10:47 hexer          Issue Monitored: hexer                       
06-22-06 17:38 adeel          Note Added: 0010423                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
