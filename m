From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000878]: No right channel
Date: Mon, 19 Sep 2005 10:26:45 +0200
Message-ID: <afc5b360bb4d0136887d04f922b268d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 01A5617B
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:26:45 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=878> 
======================================================================
Reported By:                atermiles
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   878
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-02-2005 17:36 CET
Last Modified:              09-19-2005 10:26 CEST
======================================================================
Summary:                    No right channel
Description: 
No right channel(always muted) (I use surround for listening).
With 1.0.7 driver all ok.
======================================================================

----------------------------------------------------------------------
 Raymond - 09-19-05 10:25 
----------------------------------------------------------------------
Is it SQ1500 or au8830 ?

Do you find the front/rear channels swap after first play ?


It's not easy to find out since you have to mute 

numid=48,iface=MIXER,name='Sigmatel 4-Speaker Stereo Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

numid=17,iface=MIXER,name='Sigmatel Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off



----------------------------------------------------------------------
 jdthood - 09-19-05 10:26 
----------------------------------------------------------------------
Thanks for the update.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-05 17:36 atermiles      New Issue                                    
04-15-05 19:50 atermiles      Issue Monitored: atermiles                    
09-19-05 09:59 jdthood        Note Added: 0006279                          
09-19-05 10:04 atermiles      Note Added: 0006283                          
09-19-05 10:14 Raymond        Note Added: 0006288                          
09-19-05 10:25 Raymond        Note Edited: 0006288                         
09-19-05 10:26 jdthood        Status                   assigned => resolved
09-19-05 10:26 jdthood        Resolution               open => fixed       
09-19-05 10:26 jdthood        Note Added: 0006291                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
