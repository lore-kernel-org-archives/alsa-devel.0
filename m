From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000540]: alsa driver will no longer function
Date: Wed, 23 Mar 2005 16:30:49 +0100
Message-ID: <02925d944e4a2d60b8a4d74558259d56@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44F4424A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 16:30:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=540> 
======================================================================
Reported By:                wolftech
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   540
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core
Kernel Version:             2.6.5-1.3
======================================================================
Date Submitted:             09-25-2004 15:03 CEST
Last Modified:              03-23-2005 16:30 CET
======================================================================
Summary:                    alsa driver will no longer function
Description: 
Alsa-1.2.10

lsmod 

snd_mixer_oss          13824  0
snd_intel8x0           26280  0
snd_ac97_codec         50436  1 snd_intel8x0
snd_pcm                68872  1 snd_intel8x0
snd_timer              17156  1 snd_pcm
snd_page_alloc          7940  2 snd_intel8x0,snd_pcm
gameport                3328  1 snd_intel8x0
snd_mpu401_uart         4864  1 snd_intel8x0
snd_rawmidi            17184  1 snd_mpu401_uart
snd_seq_device          6152  1 snd_rawmidi
snd                    38372  8
snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6112  1 snd



How reproducible:
in XMMS, select Alsa driver, attempt to play an mp3/cd, get:

Please check that the sound card is configured properly and You have the
correct output plugin selected and no other program is blocking the
soundcard.

======================================================================

----------------------------------------------------------------------
 djtm - 09-28-04 16:04 
----------------------------------------------------------------------
Try renaming the .asoundrc to .asoundrc.old .
If that helps and no other application is running, the config file is
bad.

also try "killall artsd" a couple times before starting/running xmms. 
make sure to kill all sound daemons before starting playback.

----------------------------------------------------------------------
 jdthood - 03-23-05 16:30 
----------------------------------------------------------------------
> alsa driver will no longer function

Submitter: Did you ever manage to solve this problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 15:03 wolftech       New Issue                                    
09-25-04 15:03 wolftech       Distribution              => Fedora Core     
09-25-04 15:03 wolftech       Kernel Version            => 2.6.5-1.3       
09-28-04 16:04 djtm           Note Added: 0001947                          
03-23-05 16:30 jdthood        Note Added: 0004177                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
