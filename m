From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000540]: alsa driver will no longer function
Date: Wed, 28 Sep 2005 11:54:09 +0200
Message-ID: <319b856e212d70786389ea9561e11fbc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 816F6143
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 11:54:09 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Fedora Core
Kernel Version:             2.6.5-1.3
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-25-2004 15:03 CEST
Last Modified:              09-28-2005 11:54 CEST
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
 jdthood - 03-24-05 16:50 
----------------------------------------------------------------------
Please provide hardware information: mainboard, sound chipset, lspci
output.

----------------------------------------------------------------------
 jdthood - 09-28-05 11:54 
----------------------------------------------------------------------
In the absence of additional information...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 15:03 wolftech       New Issue                                    
09-25-04 15:03 wolftech       Distribution              => Fedora Core     
09-25-04 15:03 wolftech       Kernel Version            => 2.6.5-1.3       
09-28-04 16:04 djtm           Note Added: 0001947                          
03-23-05 16:30 jdthood        Note Added: 0004177                          
03-24-05 16:50 jdthood        Note Added: 0004193                          
09-28-05 11:54 jdthood        Status                   new => closed       
09-28-05 11:54 jdthood        Note Added: 0006409                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
