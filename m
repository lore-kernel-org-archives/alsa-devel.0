From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002110]: idAudioHardwareALSA::Write:
	4096 frames overflowed and dropped
Date: Sat, 22 Jul 2006 22:47:02 +0200
Message-ID: <5ffd5a301d07960edee3fae6ae8536a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54675167
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 22:47:02 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-09-2006 21:48 CEST
Last Modified:              07-22-2006 22:47 CEST
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
07-22-06 22:47 Adrian Bunk    Status                   assigned => closed  
07-22-06 22:47 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
