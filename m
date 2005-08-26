From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000299]: No audio after recommended patch (see 0000216)
Date: Fri, 26 Aug 2005 15:05:08 +0200
Message-ID: <b77efcf9f0baf8756f201917e5b90433@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 209711D6
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 15:05:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299> 
======================================================================
Reported By:                salmo
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   299
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-22-2004 22:25 CEST
Last Modified:              08-26-2005 15:05 CEST
======================================================================
Summary:                    No audio after recommended patch (see 0000216)
Description: 
This is a continuation of bug 0000216.  Would have added this comment there
but bug was closed.

Applied the patch
(http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.5.diff.gz)
cleanly, recompiled, rebooted twice.  Now I get no sound output at all. 
Checked with headphones, checked mixer levels.  

The modules (snd_au8830, snd_ac97_codec, snd_mpu401_uart, snd_rawmidi,
snd_seq_oss, snd_seq_midi_event, snd_seq, snd_seq_device, snd_pcm_oss,
snd_pcm, snd_page_alloc, snd_timer, snd_mixer_oss, snd) are loaded,
everything seems fine.  XMMS, Rhythmbox, etc. will "play" the files at a
normal rate using both ALSA and OSS outputs, but nothing comes out of the
card.

Let me know if there is any information that I can give you that will
help.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000216 Speed/pitch issues when playing multipl...
======================================================================

----------------------------------------------------------------------
 perex - 08-09-05 13:14 
----------------------------------------------------------------------
reporter: Does this problem exists at the time?

----------------------------------------------------------------------
 Raymond - 08-26-05 15:05 
----------------------------------------------------------------------
Please post the output of 

lspci -vvn


cat /proc/asound/au8830/codec97#0/ac97#0-0+regs


alsactl store and the content of /etc/asound.state

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-04 22:25 salmo          New Issue                                    
05-22-04 22:25 salmo          Distribution              => Gentoo Linux    
05-22-04 22:25 salmo          Kernel Version            => 2.6.6           
05-22-04 23:42 mjander        Note Added: 0001176                          
08-09-05 13:13 perex          Relationship added       related to 0000216  
08-09-05 13:14 perex          Note Added: 0005729                          
08-26-05 15:05 Raymond        Note Added: 0005954                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
