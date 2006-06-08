From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Thu, 8 Jun 2006 04:01:31 +0200
Message-ID: <9a70762f4eb3020f14b260bc2e78b08e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0946C165
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 04:01:31 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              06-08-2006 04:01 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001224 artsd-like style
======================================================================

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

----------------------------------------------------------------------
 Raymond - 06-08-06 04:01 
----------------------------------------------------------------------
If Hetfield 's solution work, this may mean the problem is dsnoop in stead
of dmix.

The OSS application try to capture mono, but the ALSA driver of most
on-board audio chip only support stereo capture instead of mono

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
06-08-06 04:01 Raymond        Note Added: 0010107                          
======================================================================
