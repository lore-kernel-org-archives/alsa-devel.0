From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Sat, 1 Apr 2006 10:55:39 +0200
Message-ID: <76573fea2d9bcb2d68a61c5d648289be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74813167
	for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2006 10:55:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228> 
======================================================================
Reported By:                hil
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1228
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-03-2005 09:09 CEST
Last Modified:              04-01-2006 10:55 CEST
======================================================================
Summary:                    Skype Does not work with aoss
Description: 
I downloaded alsa-oss-1.0.9rc2 and install by
# ./configure --with-aoss=yes && make && make install
as root. Virtually every program works except skype
(http://www.skype.com/) version 1.1.0.13_API. I downloaded the Fedora
version of skype from the skype official website. Skype only uses
/dev/dsp. I guess skype uses /dev/dsp as microphone input as well. I could
not hear anything and the microphone did not work as well if I run  skype
like aoss /usr/bin/skype. If I run skype without aoss, then skype works
just fine.
======================================================================
Relazioni           ID      Riassunto
----------------------------------------------------------------------
in relazione con    0001224 artsd-like style
======================================================================

----------------------------------------------------------------------
 Hetfield - 03-22-06 10:02 
----------------------------------------------------------------------
oki, but kiax still has the same problem and kiax is open, you may try to
fix that, hoping it's a similar bug

----------------------------------------------------------------------
 Hetfield - 04-01-06 10:55 
----------------------------------------------------------------------
ok i have now skype working with aoss and dmix. solution found somewhere in
the web, not only mine...

1) i have whole .11rc4
2) i have .asoundrc pasted below (yes i know i should use no more it)
3) start skype this way:

export ALSA_OSS_PCM_DEVICE="skype"
aoss /opt/skype/skype.bin --resources-path /opt/skype/

it works with dmix, i can listen mplayer and use skype audio

only a notice: whould be so nice if next alsa could implement such things
by default settings

cat .asoundrc
pcm.skype {
    type asym
    playback.pcm "skypeout"
    capture.pcm "skypein"
 }

 pcm.skypein {
    type route
    slave {
       pcm "skypedsnoop"
       format S16_LE
    }
    ttable {
       0 {0 0.5}
       1 {0 0.5}
    }
 }

 pcm.skypeout {
    type plug
    slave {
       pcm "dmix"
    }
 }

 pcm.skypedsnoop {
    type dsnoop
    ipc_key 1133
    slave {
       pcm "hw:0,0"
       period_size 256
       periods 16
       buffer_size 16384
    }
    bindings {
       0 0
    }
 }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 09:09 hil            New Issue                                    
08-09-05 15:33 rapand         Note Added: 0005732                          
08-10-05 00:49 rlrevell       Relationship added       duplicate of 0001224
08-10-05 00:50 rlrevell       Note Added: 0005740                          
12-31-05 00:19 rlrevell       Note Added: 0007315                          
01-02-06 18:54 rlrevell       Relationship deleted     duplicate of 0001224
01-02-06 18:55 rlrevell       Relationship added       related to 0001224  
01-02-06 18:56 rlrevell       Note Added: 0007375                          
01-05-06 21:36 Hetfield       Note Added: 0007479                          
01-05-06 21:40 rlrevell       Note Added: 0007480                          
01-05-06 21:42 rlrevell       Note Added: 0007481                          
01-05-06 22:01 Hetfield       Note Added: 0007482                          
01-28-06 05:34 nono31         Note Added: 0007824                          
01-28-06 05:35 nono31         Issue Monitored: nono31                      
01-28-06 05:38 rlrevell       Note Added: 0007825                          
01-28-06 06:11 nono31         Note Added: 0007826                          
01-28-06 06:12 nono31         File Added: strace_aoss_kiax.bz2                  
 
01-28-06 06:13 nono31         Note Added: 0007827                          
03-22-06 00:28 rlrevell       Note Added: 0008761                          
03-22-06 10:02 Hetfield       Note Added: 0008849                          
04-01-06 10:55 Hetfield       Note Added: 0009054                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
