From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002126]: via82xx module fails in syslog, no sound
Date: Mon, 15 May 2006 11:30:03 +0200
Message-ID: <a3561f7b771a4eeb582fdb685baf7610@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23B88223
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 11:30:03 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2126> 
======================================================================
Reported By:                davidsrsb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2126
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware current
Kernel Version:             2.6.16.16
======================================================================
Date Submitted:             05-15-2006 11:30 CEST
Last Modified:              05-15-2006 11:30 CEST
======================================================================
Summary:                    via82xx module fails in syslog, no sound
Description: 
This problem happens with both 2.4.32 kernel and 2.6.16.16 kernel.
The sound was working with alsa 1.0.10 before alsa and hotplug updates.

/var/log/syslog has this entry:
May 3 13:41:33 tungsten kernel: ALSA ../alsa-kernel/pci/via82xx.c:580:
codec_read: codec 0 is not valid [0xfe0000]

There is no other soundcard/modem/capture device in this system.
Sound is on board on an ASUS A7V8
The same syslog line appears with both kernels
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-15-06 11:30 davidsrsb      New Issue                                    
05-15-06 11:30 davidsrsb      Distribution              => Slackware current
05-15-06 11:30 davidsrsb      Kernel Version            => 2.6.16.16       
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
