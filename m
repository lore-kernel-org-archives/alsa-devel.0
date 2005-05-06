From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001089]: ali5451 doesn't work on Sun Blade 150
Date: Fri, 6 May 2005 15:44:02 +0200
Message-ID: <00865502fd4dd2d773fd4b42ac41cc05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C398D20C
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 15:44:02 +0200 (MEST)
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
Last Modified:              05-06-2005 15:44 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 15:44 gelaslean      New Issue                                    
05-06-05 15:44 gelaslean      Distribution              => Debian Sarge    
05-06-05 15:44 gelaslean      Kernel Version            => 2.6.8 - 2.6.11.8
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
