From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001098]: aoss openal    gives too fast sound.
Date: Wed, 18 May 2005 14:53:56 +0200
Message-ID: <cefefc71004752a4be02dbf92d326412@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 331602BB
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2005 14:53:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1098> 
======================================================================
Reported By:                qwer1234
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1098
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-09-2005 17:09 CEST
Last Modified:              05-18-2005 14:53 CEST
======================================================================
Summary:                    aoss openal    gives too fast sound.
Description: 
Opanal layer gives too fast sound when I use aoss wrapper and I get this
error multiple times:

native_blitbuffer: select error occured

======================================================================

----------------------------------------------------------------------
 qwer1234 - 05-18-05 00:41 
----------------------------------------------------------------------
I don't understand this sentence:
You didn't pass "plug" layer.
My asound.conf is:
pcm.dmixoss {
         type dmix
         ipc_key 5678293
         slave {
           pcm "hw:0,0"
           period_time 0
           period_size 1024
           buffer_size 8192
	   rate 48000
         }
      bindings {
       	   0 0 # from 0 => to 0
   	   1 1 # from 1 => to 1
    }
}
pcm.dsnooposs {
         type dsnoop
         ipc_key 5778293
         slave {
             pcm "hw:0,0"
             period_time 0
             period_size 1024
             buffer_size 8192
	     rate 48000
	}
    bindings {
        0 0 # from 0 => to 0
        1 1 # from 1 => to 1
    }
} 
pcm.duplex {
        type asym
        playback.pcm "dmixoss"
        capture.pcm "dsnooposs"
}

pcm.!default {
        type plug
        slave.pcm "duplex"
}

ctl.!default {
	type hw           
	card 0
}

pcm.dsp0 {
    type plug
    slave.pcm "duplex"
}

ctl.dsp0 {
    type hw
    card 0
}

ctl.mixer0 {
    type hw 
    card 0
}
ctl.mixer {
    type hw
    card 0
}
/tiwai: Please tell me something more.



----------------------------------------------------------------------
 tiwai - 05-18-05 14:53 
----------------------------------------------------------------------
I guessed wrong.  The configuration looks OK.
So, this is likely a bug of aoss or openal.  What app does behave like
this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-05 17:09 qwer1234       New Issue                                    
05-09-05 17:15 qwer1234       Issue Monitored: qwer1234                    
05-17-05 17:52 tiwai          Note Added: 0004681                          
05-17-05 17:53 tiwai          Note Added: 0004682                          
05-18-05 00:38 qwer1234       Note Added: 0004685                          
05-18-05 00:41 qwer1234       Note Edited: 0004685                         
05-18-05 14:53 tiwai          Note Added: 0004687                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
