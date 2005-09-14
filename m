From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in full duplex, works with OSS, griffin imic
Date: Wed, 14 Sep 2005 15:49:52 +0200
Message-ID: <7a3c0103ed9c569e8abc002090889cb1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAD98191
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:49:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=521> 
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              09-14-2005 15:49 CEST
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with
OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================

----------------------------------------------------------------------
 ryanpg - 10-08-04 18:40 
----------------------------------------------------------------------
I also find this bug when using my EMI 2|6 soundcard.

Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver.

2.6 and 2.4 kernels. All jack versions including 0.99.

----------------------------------------------------------------------
 jdthood - 09-14-05 15:49 
----------------------------------------------------------------------
> Jack works with the OSS audio driver in full duplex but only works
simplex with alsa driver.

Has this problem been fixed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Issue                                    
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
10-08-04 18:32 ryanpg         Issue Monitored: ryanpg                      
10-08-04 18:40 ryanpg         Note Added: 0002055                          
09-14-05 15:49 jdthood        Note Added: 0006160                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
