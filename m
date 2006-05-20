From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002137]: No mute controls for Audigy or Audigy 2ZS
Date: Sat, 20 May 2006 15:23:30 +0200
Message-ID: <d1dfe406832d4b3ea862b80a7c71ecb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A9A3140
	for <alsa-devel@alsa-project.org>; Sat, 20 May 2006 15:23:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2137> 
======================================================================
Reported By:                stdpikachu
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2137
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15, 2.6.16
======================================================================
Date Submitted:             05-20-2006 15:23 CEST
Last Modified:              05-20-2006 15:23 CEST
======================================================================
Summary:                    No mute controls for Audigy or Audigy 2ZS
Description: 
The problem has been around for while, but have only just got around to
reporting it (incidentally, where do I search for previously file bug
reports?).

I have three computers, all with various flavours of Audigy cards, all
using the latest emu10k1 alsa driver. The problem also exists with the
in-kernel audigy driver. Googling for other people with the same problem
suggests the problem crept it quite a while ago.

No matter what UI is used, I can't mute most channels provided by the
audigy driver. For instance, in alsamixer I can only mute Headphones,
Line, CD, Phone, PC Speaker and Aux. ALl other channels are without mute
toggles.

The upshot of this is that mute controls in almost all alsa apps doesn't
work and the only way to mute the channel is to manually set master or PCM
volume to zero.

I read of a bug with one of the intel sound drivers that lost most of the
mute controls, maybe this is the same sort of thing.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-06 15:23 stdpikachu     New Issue                                    
05-20-06 15:23 stdpikachu     File Added: alsamixer.png                    
05-20-06 15:23 stdpikachu     Distribution              => Gentoo          
05-20-06 15:23 stdpikachu     Kernel Version            => 2.6.15, 2.6.16  
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
