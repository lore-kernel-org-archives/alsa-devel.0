From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000782]: Poor digital aidio quality
Date: Sun, 23 Jan 2005 04:52:57 +0100
Message-ID: <2ea3ba3d5b60c0f17747f96a1843f79e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2FE6526F
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2005 04:52:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=782> 
======================================================================
Reported By:                ddemmer
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   782
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core
Kernel Version:             2.6.9-1.681_FC3.i686
======================================================================
Date Submitted:             01-03-2005 16:20 CET
Last Modified:              01-23-2005 04:52 CET
======================================================================
Summary:                    Poor digital aidio quality
Description: 
Attempting to play MP3 files with RealPlay or xmms using ALSA output
results in scratchy, erratic, slow (Realplay) or speeded up (xmms) sound.
I can change the xmms configuration to use libOSS.so instead of libALSA
which fixes the problem.

The gnome "Detect Sound Card" utility works fine and plays it's sound
fine.

The gnome volume control does not affect the output level when using
libOSS.

I have by now muted everything in the alsamixer except the Master volume.

Playing a CD works fine.
======================================================================

----------------------------------------------------------------------
 fmoraes - 01-22-05 23:29 
----------------------------------------------------------------------
Some of the problems you describe (device busy) cannot be fixed unless you
either configure dmix usage for your system or disable the sound server
which is probably using the sound, preventing other OSS enabled
applications to use the sound card.

The emu10k1x doesn't have true hardware mixing, so this has to be done in
software with dmix.

----------------------------------------------------------------------
 ddemmer - 01-23-05 04:52 
----------------------------------------------------------------------
Thanks for the comments, folks. It is looking like things are wandering
away from the original complaint, so I suppose I could be persuaded to
drop this as a bug report. However, I do have some issues outsanding,
though they're getting to the point more of satisfying my curiosity.

Anyway, in answer to tiwai, I see the definition of plughw:0,0 in
/etc/alsa/alsa.conf but I don't see a way to get xmms to use it, so I
can't try that.

In answer to fmoraes 22 Jan 05 comment: I agree, and I have been trying to
go through the ALSA web site to get the dmix set up. I'm not sure if it's
working though: Rhythmbox no longer complains on starting up, but xmms
does. xmms will play once you clear the error. However, xmms is still
garbled if I use the default PCM device: only hw:0,0 works. Realplay now
doesn't work at all. xmms and Rhythmbox lock each other out -- if dmix was
working should they both be able to play at the same time?

My .asoundrc now looks like this:

pcm.emu10k1x {
  type hw
  card 0
}

ctl.emu10k1x {
  type hw
  card 0
}

pcm.emu10k1x {
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

Is this right? Also, is there a quick way to try it out -- right now I am
rebooting to be sure it "takes", which limits my eagerness to experiment.
When I try to use aplay as suggested in the ALSA pages to test with an mp3
file I just get screeching. 

And finally: please let me know if this is getting too far off the mark
and should take my questions to some other forum.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 16:20 ddemmer        New Issue                                    
01-03-05 16:20 ddemmer        Distribution              => Fedora Core     
01-03-05 16:20 ddemmer        Kernel Version            => 2.6.9-1.681_FC3.i686
01-03-05 16:49 stransky       Issue Monitored: stransky                    
01-04-05 13:43 ddemmer        Issue Monitored: ddemmer                     
01-04-05 13:43 ddemmer        Issue End Monitor: ddemmer                    
01-16-05 14:57 fmoraes        Note Added: 0003217                          
01-16-05 20:43 ddemmer        Note Added: 0003221                          
01-19-05 18:34 ddemmer        Note Added: 0003310                          
01-19-05 20:45 tiwai          Note Added: 0003317                          
01-22-05 23:29 fmoraes        Note Added: 0003383                          
01-23-05 04:52 ddemmer        Note Added: 0003386                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
