From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000628]: Can't record audio
Date: Mon, 17 Jan 2005 15:07:10 +0100
Message-ID: <4ca0e9985d5a7a7378d1370dcaa3754e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 06E231A4
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 15:07:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=628> 
======================================================================
Reported By:                pawlik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   628
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.8.1
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-03-2004 18:46 CET
Last Modified:              01-17-2005 15:07 CET
======================================================================
Summary:                    Can't record audio
Description: 
I'm not able to record any audio. Reading from /dev/dsp results in an
"Input/Output Error".
The hardware I'm using is Soltek 75DRV5 with built-in soundcard.
======================================================================

----------------------------------------------------------------------
 rossaxe - 01-16-05 17:09 
----------------------------------------------------------------------
What is this particular knob supposed to do? So far as I can tell, it just
offers a choice betweens 'works' and 'breaks'

----------------------------------------------------------------------
 tiwai - 01-17-05 15:07 
----------------------------------------------------------------------
This defines the connection of which input pin is selected for the certain
input path.  So, whether it works or not strongly depends on the hardware.

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
01-17-05 15:07 tiwai          Status                   new => resolved     
01-17-05 15:07 tiwai          Resolution               open => not an issue
01-17-05 15:07 tiwai          Assigned To               => tiwai           
01-17-05 15:07 tiwai          Note Added: 0003236                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
