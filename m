From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000628]: Can't record audio
Date: Sun, 16 Jan 2005 17:09:12 +0100
Message-ID: <bce1f87f7defff7db728687525110149@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B589A29C
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2005 17:09:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=628> 
======================================================================
Reported By:                pawlik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   628
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-03-2004 18:46 CET
Last Modified:              01-16-2005 17:09 CET
======================================================================
Summary:                    Can't record audio
Description: 
I'm not able to record any audio. Reading from /dev/dsp results in an
"Input/Output Error".
The hardware I'm using is Soltek 75DRV5 with built-in soundcard.
======================================================================

----------------------------------------------------------------------
 pawlik - 01-16-05 10:05 
----------------------------------------------------------------------
This resolve the issue. Thanks tiwai

----------------------------------------------------------------------
 rossaxe - 01-16-05 17:09 
----------------------------------------------------------------------
What is this particular knob supposed to do? So far as I can tell, it just
offers a choice betweens 'works' and 'breaks'

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 18:46 pawlik         New Issue                                    
11-03-04 18:46 pawlik         Distribution              => Debian          
11-03-04 18:46 pawlik         Kernel Version            => 2.6.8.1         
11-09-04 15:28 tiwai          Note Added: 0002323                          
11-18-04 19:41 prymitive      Issue Monitored: prymitive                    
01-16-05 10:05 pawlik         Note Added: 0003214                          
01-16-05 17:09 rossaxe        Note Added: 0003219                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
