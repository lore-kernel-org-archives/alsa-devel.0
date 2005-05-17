From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001089]: ali5451 doesn't work on Sun Blade 150
Date: Tue, 17 May 2005 13:40:37 +0200
Message-ID: <ee6378dec5a13a2fab98971e03b25918@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 85EC729C
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2005 13:40:37 +0200 (MEST)
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
Last Modified:              05-17-2005 13:40 CEST
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
 gelaslean - 05-17-05 13:40 
----------------------------------------------------------------------
The sound card works with Trident OSS driver, but the mixer doesn't work.
For example, kmixer seems to work correctly, but the mixer level are not
setted.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 15:44 gelaslean      New Issue                                    
05-06-05 15:44 gelaslean      Distribution              => Debian Sarge    
05-06-05 15:44 gelaslean      Kernel Version            => 2.6.8 - 2.6.11.8
05-17-05 13:40 gelaslean      Note Added: 0004678                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
