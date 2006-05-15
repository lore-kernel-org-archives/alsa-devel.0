From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002122]: DMIX crashes Ekiga
Date: Mon, 15 May 2006 22:33:22 +0200
Message-ID: <9da72d90cab658fa222ef190695faced@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3110229
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 22:33:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2122> 
======================================================================
Reported By:                dsandras
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2122
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             05-13-2006 17:35 CEST
Last Modified:              05-15-2006 22:33 CEST
======================================================================
Summary:                    DMIX crashes Ekiga
Description: 
This problem is probably related to problem #2095 that was closed. 
Unfortunately, I can not reopen it, so I'm posting a new bug report.

When using DMIX, Ekiga crashes. This problem was not present with earlier
versions of libasound2. I applied all patches from CVS.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-06 11:07 
----------------------------------------------------------------------
Are you using the latest HG repo?
hg-mirror looks out of sync for a long time.  Try HG repo from rsync, or
http://hg.alsa-project.org/alsa-lib.

The fix is SHA1 ID: 8c310c3277b78a6c53af86939fb5dd6a7db509ea.

----------------------------------------------------------------------
 dsandras - 05-15-06 22:33 
----------------------------------------------------------------------
I applied this patch:
http://hg.alsa-project.org/alsa-lib?cs=8c310c3277b7

And it solves the problem.

However, using the "default" device (and thus implicitely dmix) gives a
very bad result with Ekiga.

If I defined a .asoundrc file like this one :
pcm.snd_card {
        type hw
        card 0
}

pcm.dmixer {
        type dmix
        ipc_key 1024
        slave.pcm "snd_card"
        slave {
                period_size 256
                buffer_size 2048
                rate 44100
        }
}

pcm.dsnooper {
        type dsnoop
        ipc_key 2048
        slave.pcm "snd_card"

        slave {
                period_size 256
                buffer_size 2048
                rate 44100
        }
}

pcm.duplex {
        type asym
        playback.pcm "dmixer"
        capture.pcm "dsnooper"
}

pcm.!default {
        type plug
        slave.pcm "duplex"
}

Then the sound quality becomes correct, except if the machine is loaded.
If the machine is loaded, then the latency increases.

Is there any sane explanation to that problem?

I'm asking because Ekiga users will complain.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:35 dsandras       New Issue                                    
05-13-06 17:39 dsandras       Note Added: 0009795                          
05-13-06 17:41 dsandras       Note Added: 0009796                          
05-13-06 18:29 rlrevell       Note Added: 0009799                          
05-13-06 18:36 dsandras       Note Added: 0009800                          
05-13-06 18:37 dsandras       File Added: busytone.wav                     
05-15-06 10:35 tiwai          Status                   assigned => resolved
05-15-06 10:35 tiwai          Resolution               open => fixed       
05-15-06 10:35 tiwai          Note Added: 0009814                          
05-15-06 11:01 dsandras       Status                   resolved => feedback
05-15-06 11:01 dsandras       Resolution               fixed => reopened   
05-15-06 11:01 dsandras       Note Added: 0009816                          
05-15-06 11:07 tiwai          Note Added: 0009818                          
05-15-06 22:33 dsandras       Note Added: 0009828                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
