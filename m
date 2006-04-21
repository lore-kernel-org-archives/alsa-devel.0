From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002050]: Modprobe snd-intel8x0 gives unknown symbol
Date: Fri, 21 Apr 2006 22:28:05 +0200
Message-ID: <aab5cc70b128953f1b904904b4e185b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0D09162
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 22:28:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2050> 
======================================================================
Reported By:                binro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2050
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             04-21-2006 13:58 CEST
Last Modified:              04-21-2006 22:28 CEST
======================================================================
Summary:                    Modprobe snd-intel8x0 gives unknown symbol
Description: 
When I emerged alsa-driver-1.0.11 against a 2.6.16 kernel, the module load
produces "unknown symbol snd_ac97_pcm_close" and many more similar
messages. This worked fine with version 1.0.11_rc3 but fails with rc4, rc5
and final versions.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-21-06 18:20 
----------------------------------------------------------------------
Ah OK, then try "modprobe snd-ac97-codec" to see whether this module can be
loaded.  Anyway, there is no relevant change about snd_ac97_pcm_close
between rc3 and final, too.

Possibly, some old modules are remaining that conflict with the newer
version.
Cean up completely snd*.ko from the module directory, then reinstall the
modules again.

----------------------------------------------------------------------
 binro - 04-21-06 22:28 
----------------------------------------------------------------------
I use the Gentoo alsa-driver ebuild, alsa is turned off in the kernel
config. The only kernel module is soundcore.ko. I completely deleted
/lib/modules/2.6.16-gentoo/alsa-driver to be on the safe side but it makes
no difference. The emerge works for RC3, RC4 and above, "unknown symbol"
hell.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 13:58 binro          New Issue                                    
04-21-06 13:58 binro          Distribution              => Gentoo          
04-21-06 13:58 binro          Kernel Version            => 2.6.16.1        
04-21-06 16:46 tiwai          Note Added: 0009415                          
04-21-06 18:12 binro          Note Added: 0009421                          
04-21-06 18:20 tiwai          Note Added: 0009424                          
04-21-06 22:28 binro          Note Added: 0009430                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
