From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000609]: No Mixer control for Ouput on CMI9880
Date: Thu, 13 Jan 2005 17:29:43 +0100
Message-ID: <e141372978e4f0b5383db701826a8ec0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08C34295
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:29:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=609> 
======================================================================
Reported By:                Grazy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   609
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-27-2004 00:10 CEST
Last Modified:              01-13-2005 17:29 CET
======================================================================
Summary:                    No Mixer control for Ouput on CMI9880
Description: 
The CMI9880 chip on my MotherBoard is detect by the snd-azx module.
But there is only one mixer control for "Capture" and two mute switch for
"Line" and "Mic". But nothing to control the output volume.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-14-04 22:21 
----------------------------------------------------------------------
Since the hardware has no volume control this is not a bug.  Decrease the
output level in your application to reduce volume.  Or turn your speakers
down.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:29 
----------------------------------------------------------------------
ALSA 1.0.8 includes softvol PCM plugin.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 00:10 Grazy          New Issue                                    
10-27-04 00:10 Grazy          Distribution              => Debian          
10-27-04 00:10 Grazy          Kernel Version            => 2.6.8           
10-27-04 02:36 cltien         Note Added: 0002270                          
11-08-04 09:22 madsend        Note Added: 0002310                          
11-08-04 09:25 madsend        Issue Monitored: madsend                     
11-08-04 21:02 cltien         Note Added: 0002313                          
12-12-04 14:01 jdthood        Note Added: 0002814                          
12-14-04 00:10 gaima          Issue Monitored: gaima                       
12-14-04 22:21 rlrevell       Note Added: 0002824                          
01-13-05 17:29 tiwai          Status                   new => resolved     
01-13-05 17:29 tiwai          Resolution               open => fixed       
01-13-05 17:29 tiwai          Assigned To               => tiwai           
01-13-05 17:29 tiwai          Note Added: 0003195                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
