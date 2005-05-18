From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001089]: ali5451 doesn't work on Sun Blade 150
Date: Wed, 18 May 2005 14:11:25 +0200
Message-ID: <4f2510a0cf242d334c06ec2fc52822a5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3FDB7294
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2005 14:11:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1089> 
======================================================================
Reported By:                gelaslean
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1089
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.8 - 2.6.11.8
======================================================================
Date Submitted:             05-06-2005 15:44 CEST
Last Modified:              05-18-2005 14:11 CEST
======================================================================
Summary:                    ali5451 doesn't work on Sun Blade 150
Description: 
My Sun Blade 150 (sparc64 cpu) has an onboard ali5451 chipset.
I installed Debian Sarge and update all packages with apt-get.
When I load snd-ali-5451 module the system respond with:

ioctl32(alsactl:2142): Unknown cmd fd(3) cmd(40045500){00} arg(effff734)
on /dev/snd/controlC0
ioctl32(amixer:2146): Unknown cmd fd(3) cmd(40045500){00} arg(effff814) on
/dev/snd/controlC0
ioctl32(amixer:2149): Unknown cmd fd(3) cmd(40045500){00} arg(effff814) on
/dev/snd/controlC0
ioctl32(amixer:2152): Unknown cmd fd(3) cmd(40045500){00} arg(effff814) on
/dev/snd/controlC0
<snipped many other similar lines>

Obviusly ALSA system doesn't work.

I tried with 2.6.8 (standard Debian package) and 2.6.11.8 (vanilla
sources) kernel. 

Any hints?

Leandro Gelasi

======================================================================

----------------------------------------------------------------------
 tiwai - 05-17-05 17:50 
----------------------------------------------------------------------
ioctl32 wrapper was largely rewritten in the recent version.

----------------------------------------------------------------------
 gelaslean - 05-18-05 14:11 
----------------------------------------------------------------------
I just succeded to obtain a working audio in KDE (that was what I want at
beginning). After various attempt I upgraded alsa-utils to 1.0.8+1.0.9rc3
Debian package and now I can use artsd in "Threaded OSS" mode (disabling
autoconfigure).
Other alsa packages are at 1.0.8 version with Debian patched kernel
2.6.8.

The problems with ioctl32 are still present and I think that alsa in
working only as OSS emulation mode.

It is possible this is a 32/64 bit issue?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 15:44 gelaslean      New Issue                                    
05-06-05 15:44 gelaslean      Distribution              => Debian Sarge    
05-06-05 15:44 gelaslean      Kernel Version            => 2.6.8 - 2.6.11.8
05-17-05 13:40 gelaslean      Note Added: 0004678                          
05-17-05 17:50 tiwai          Note Added: 0004679                          
05-18-05 14:11 gelaslean      Note Added: 0004686                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
