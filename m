From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001856]: VIA8237 records only left channel
Date: Sat, 18 Feb 2006 22:41:09 +0100
Message-ID: <2e9d0b8cbe1e9d70ce3e680cd68c33b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27D461B7
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 22:41:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1856> 
======================================================================
Reported By:                ovek
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1856
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15-1-k7
======================================================================
Date Submitted:             02-18-2006 22:41 CET
Last Modified:              02-18-2006 22:41 CET
======================================================================
Summary:                    VIA8237 records only left channel
Description: 
After upgrading to 2.6.15 (from 2.6.9), recording (from Aux or Mix) results
in the right channel being silent - the left channel seems to record
normally. The sound can be heard fine on the speakers, the problem is
recording it. My old 2.6.9 kernel did not have such problems. I tried to
build the kernel modules from Debian's alsa-source package (1.0.10), but
no improvement.

I'm using the snd_via82xx driver, and recording through snd_pcm_oss. This
is the soundchip I have:

0 [V8237          ]: VIA8237 - VIA 8237
                     VIA 8237 with AD1888 at 0xe000, irq 209

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 810d
        Flags: medium devsel, IRQ 209
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

This may be the same issue as 0001811, except I'm using Aux, not Line-In,
and the volume of the sound appears normal to me, not too quiet, which may
be because I've remembered to adjust my mixer capture settings.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-06 22:41 ovek           New Issue                                    
02-18-06 22:41 ovek           Distribution              => Debian          
02-18-06 22:41 ovek           Kernel Version            => 2.6.15-1-k7     
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
