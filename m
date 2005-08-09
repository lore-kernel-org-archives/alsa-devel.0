From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000299]: No audio after recommended patch (see 0000216)
Date: Tue, 9 Aug 2005 13:14:23 +0200
Message-ID: <ef0416ce48ed80f84f9a8766777e0dd1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8217D1AF
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:14:23 +0200 (MEST)
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
Last Modified:              08-09-2005 13:14 CEST
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
 mjander - 05-22-04 23:42 
----------------------------------------------------------------------
Hi,

- Why are you using patch 2.6.5 if you are using kernel 2.6.6 ?! Use the
patch for 2.6.6 instead:
http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.6.diff.gz
That wont change much, but its the latest.

- Please check your mixer settings *again*. Use alsamixer (or other ALSA
mixer), not a OSS mixer. Be sure to uncheck the "mute" toggles.
CDROM,line-in,video,auxiliar,etc audio won't be hearable through the
"headpones" output, since the codec is not capable to do so, and another
kind of workaround is needed for that.

- If you experience too low output level, toggle the "Externel Amplifier
Disable" control in alsamixer to set it right.

- Turn on your loudspeaker, take out your earplugs ... :D

- Any bad things reported on dmesg ?

You should not have any problem, many people are using the current driver
without problem, i use them everyday (what else could i say ?) ...

Best Regards

Manuel Jander

----------------------------------------------------------------------
 perex - 08-09-05 13:14 
----------------------------------------------------------------------
reporter: Does this problem exists at the time?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-04 22:25 salmo          New Issue                                    
05-22-04 22:25 salmo          Distribution              => Gentoo Linux    
05-22-04 22:25 salmo          Kernel Version            => 2.6.6           
05-22-04 23:42 mjander        Note Added: 0001176                          
08-09-05 13:13 perex          Relationship added       related to 0000216  
08-09-05 13:14 perex          Note Added: 0005729                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
