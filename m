From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001029]: doesn't seem to attach to device
Date: Thu, 31 Mar 2005 21:57:30 +0200
Message-ID: <d2bb012a423553c19b119860e60c0121@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00E98254
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 21:57:30 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1029> 
======================================================================
Reported By:                Meeuw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1029
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-31-2005 21:57 CEST
Last Modified:              03-31-2005 21:57 CEST
======================================================================
Summary:                    doesn't seem to attach to device
Description: 
# lsmod
Module                  Size  Used by
snd_seq                52368  0
snd_via82xx            23968  0
snd_ac97_codec         78840  1 snd_via82xx
snd_pcm                83076  2 snd_via82xx,snd_ac97_codec
snd_timer              22532  2 snd_seq,snd_pcm
snd_page_alloc          8452  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7424  1 snd_via82xx
snd_rawmidi            20352  1 snd_mpu401_uart
snd_seq_device          8076  2 snd_seq,snd_rawmidi
snd                    42932  8
snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               8544  1 snd

kernel config:
#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

there are no (relevant) driver messages
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-05 21:57 Meeuw          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
