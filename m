From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Mon, 6 Feb 2006 18:37:18 +0100
Message-ID: <a830fc069cbb2c033f24208252301b0c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 081CB1E1
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2006 18:37:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1823> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1823
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-05-2006 22:59 CET
Last Modified:              02-06-2006 18:37 CET
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 darkbrain - 02-06-06 10:46 
----------------------------------------------------------------------
Well i'm not an alsa driver guru, i think that simply we have 2 channels
pcm 1 front and 1 rear and surround40 should be only an asound.conf
"tweak" that merge them together to virtualize 1 surround40 channel. 3
channels are probably supported by cards that supports 5+1 channels and
it's not my case.
Hmm if i'm correct there is a problem only on the rear pcm, i'll test it.
Any way by user side it works i can see a dvd with 4 channels and i tested
it very well :)

----------------------------------------------------------------------
 darkbrain - 02-06-06 18:37 
----------------------------------------------------------------------
I'm beginning to think that is not a memory leak problem or similar but a
syncing one. Infact if i use a ruote device type such as:
pcm.quad {
        type route
        slave.pcm "surround40:0"
        slave.channels  4
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
}
ctl.quad { type hw; card 0; }

and i play an mp3 throught quad, it results out of sync. Does pcm type
multi, used for surround40, trying to sync 2 device?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 22:59 darkbrain      New Issue                                    
02-06-06 06:32 Raymond        Note Added: 0007943                          
02-06-06 07:10 Raymond        Note Edited: 0007943                         
02-06-06 07:31 Raymond        Note Edited: 0007943                         
02-06-06 07:32 Raymond        Note Edited: 0007943                         
02-06-06 10:46 darkbrain      Note Added: 0007945                          
02-06-06 10:46 darkbrain      Note Added: 0007946                          
02-06-06 10:47 darkbrain      Note Deleted: 0007946                        
02-06-06 18:37 darkbrain      Note Added: 0007950                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
