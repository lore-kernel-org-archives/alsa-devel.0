From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002110]: idAudioHardwareALSA::Write: 4096 frames overflowed and dropped
Date: Tue, 9 May 2006 22:37:08 +0200
Message-ID: <2b31ff745c5c4ee4d041a0bb385e0166@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B68024F
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2006 22:37:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2110> 
======================================================================
Reported By:                kratz00
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2110
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-09-2006 21:48 CEST
Last Modified:              05-09-2006 22:37 CEST
======================================================================
Summary:                    idAudioHardwareALSA::Write: 4096 frames overflowed
and dropped
Description: 
Id's Quake IV and Doom III have Alsa support.
But the music sounds horrible and I see a lot of following message in the
console:

snd_pcm_writei short write: 3760 out of 4096
snd_pcm_writei short write: 3760 out of 4096
snd_pcm_writei short write: 3760 out of 4096
snd_pcm_writei short write: 3760 out of 4096
snd_pcm_writei short write: 1880 out of 2048
snd_pcm_writei short write: 940 out of 1024
idAudioHardwareALSA::Write: 4096 frames overflowed and dropped

The sound initalization output is:

------ Alsa Sound Initialization -----
dlopen(libasound.so.2)
asoundlib version: 1.0.11
opened Alsa PCM device default for playback
device buffer size: 5644 frames ( 22576 bytes )
allocated a mix buffer of 16384 bytes
--------------------------------------

if i pass '+set s_driver oss' to the startscript the client uses OSS
emulation and the sound is like expected

so whats wrong using alsa directly instead of the oss emu

======================================================================

----------------------------------------------------------------------
 kratz00 - 05-09-06 22:28 
----------------------------------------------------------------------
i just wonder why it works with oss emulation and on my other computer with
a emu10k1 chip

----------------------------------------------------------------------
 rlrevell - 05-09-06 22:37 
----------------------------------------------------------------------
Maybe they didn't test their code on a wide range of hardware?  It's hard
to say.  Unless you can reproduce it with an open source app it's
impossible to debug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-06 21:48 kratz00        New Issue                                    
05-09-06 21:48 kratz00        File Added: codec#0                          
05-09-06 22:22 rlrevell       Note Added: 0009692                          
05-09-06 22:28 kratz00        Note Added: 0009693                          
05-09-06 22:37 rlrevell       Note Added: 0009694                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
