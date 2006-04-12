From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002010]: Terratec DMX Fire 1024 recording problem
Date: Wed, 12 Apr 2006 21:44:11 +0200
Message-ID: <cad7b3188da4fa5926a6855b32135a24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D07814B
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 21:44:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2010> 
======================================================================
Reported By:                rbielefeld
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2010
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 10.0
Kernel Version:             
======================================================================
Date Submitted:             04-07-2006 09:09 CEST
Last Modified:              04-12-2006 21:44 CEST
======================================================================
Summary:                    Terratec DMX Fire 1024 recording problem
Description: 
I want to record from LineIn port.
Even with no signal on that port, one input channel is noisy.
With a signal on that port, the noisy channel does not have the real audio
signal.




======================================================================

----------------------------------------------------------------------
 rbielefeld - 04-12-06 21:16 
----------------------------------------------------------------------
Adjusting the ADC and Capture slider resolves the noise problem, but on the
previous "noisy" channel the sound data is still missing.
Hopefully the attached files can help you.

Thanks a lot.

----------------------------------------------------------------------
 rlrevell - 04-12-06 21:44 
----------------------------------------------------------------------
You have set the mixer to capture line on the left channel and mic on the
right channel:

        control.16 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source' 
                value.0 Line
                value.1 Mic
        }

Set both left and right 'Capture Source' to Line.  Are you using a broken
mixer app like kmix by any chance?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 09:09 rbielefeld     New Issue                                    
04-07-06 09:09 rbielefeld     Distribution              => SuSE Linux 10.0 
04-07-06 19:18 tiwai          Note Added: 0009143                          
04-12-06 21:07 rbielefeld     File Added: asound.state                     
04-12-06 21:07 rbielefeld     File Added: interrupts.txt                    
04-12-06 21:07 rbielefeld     Issue Monitored: rbielefeld                    
04-12-06 21:08 rbielefeld     Issue End Monitor: rbielefeld                    
04-12-06 21:08 rbielefeld     File Added: modules.txt                      
04-12-06 21:16 rbielefeld     Note Added: 0009248                          
04-12-06 21:44 rlrevell       Note Added: 0009249                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
