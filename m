From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000822]: CMI9880 (IHDA) alsamixer no controll
Date: Tue, 18 Jan 2005 14:01:26 +0100
Message-ID: <3729ef11d2139cebde7fefb932f266ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E803B25E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 14:01:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=822> 
======================================================================
Reported By:                1g0R
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   822
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               FC3
Kernel Version:             2.6.10-ac8
======================================================================
Date Submitted:             01-16-2005 19:06 CET
Last Modified:              01-18-2005 14:01 CET
======================================================================
Summary:                    CMI9880 (IHDA) alsamixer no controll
Description: 
The compile went fine.
I have sound,with alsa.In alsamixer all trigger on 0, but i have sound.
I cant raise the trigger.
No SPDIF out.
======================================================================

----------------------------------------------------------------------
 1g0R - 01-17-05 16:43 
----------------------------------------------------------------------
Hi Tiwai,

Thank you for the answer, but please write more detail about softvol.
What should i need to do ?

Thanks

Best regards

1g0R

----------------------------------------------------------------------
 1g0R - 01-18-05 14:01 
----------------------------------------------------------------------
Something like that:

pcm.!default {
type plug
slave.pcm "dmixer"
    }

 
    pcm.dmixer  {
type dmix
ipc_key 1024
slave {
    pcm "hw:1,0"
    period_time 0
    period_size 1024
    buffer_size 4096
    rate 44100
}
bindings {
    0 0
    1 1
}
    }
 
    ctl.dmixer {
type hw
card 0
    }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-05 19:06 1g0R           New Issue                                    
01-16-05 19:06 1g0R           Distribution              => FC3             
01-16-05 19:06 1g0R           Kernel Version            => 2.6.10-ac8      
01-17-05 15:05 tiwai          Status                   new => resolved     
01-17-05 15:05 tiwai          Resolution               open => not an issue
01-17-05 15:05 tiwai          Assigned To               => tiwai           
01-17-05 15:05 tiwai          Note Added: 0003235                          
01-17-05 15:05 tiwai          Assigned To              tiwai =>            
01-17-05 16:43 1g0R           Status                   resolved => feedback
01-17-05 16:43 1g0R           Resolution               not an issue => reopened
01-17-05 16:43 1g0R           Note Added: 0003238                          
01-17-05 16:43 1g0R           Assigned To               => tiwai           
01-18-05 14:01 1g0R           Note Added: 0003249                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
