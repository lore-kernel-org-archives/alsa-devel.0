From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001556]: Fortissimo 4: No Volume Control
Date: Mon, 14 Nov 2005 13:55:49 +0100
Message-ID: <41241fa4ac94366be26c443c67be1f91@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D85651A4
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 13:55:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556> 
======================================================================
Reported By:                bladus
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1556
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14-ck1
======================================================================
Date Submitted:             11-13-2005 22:06 CET
Last Modified:              11-14-2005 13:55 CET
======================================================================
Summary:                    Fortissimo 4: No Volume Control
Description: 
With the Hercules Fortissimo 4 (Envy24HT) there's no posibillity to control
the volume.
It's always at max.

Under Windows the card uses the reference drivers from VIA, so maybe you
can fix that issue.
I would be very happy if you could send me a response to this issue within
a week, since when it's not possible i can return the card to the
merchant.

Thank you.

======================================================================

----------------------------------------------------------------------
 bladus - 11-14-05 13:39 
----------------------------------------------------------------------
i hope i did it right when i wrote:

options snd-ice1724 model="sn25p"

in /etc/modules.conf

It didn't work, one problem might be that i use 1.10rc1, i'll try rc3 (but
i don't think it will work :(

----------------------------------------------------------------------
 bladus - 11-14-05 13:55 
----------------------------------------------------------------------
rc3 dont work either.
But it gives some additional information when i start alsasound

ice1724: No matching model found for ID 0x81160100
ice1724: Invalid EEPROM version 1
snd_seq_oss: Unknown symbol snd_unregister_oss_device
snd_seq_oss: Unknown symbol snd_register_oss_device
snd_seq_oss: Unknown symbol snd_oss_info_register
snd_mixer_oss: Unknown symbol snd_unregister_oss_device
snd_mixer_oss: Unknown symbol snd_register_oss_device
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
snd_mixer_oss: Unknown symbol snd_oss_info_register
snd_pcm_oss: Unknown symbol snd_unregister_oss_device
snd_pcm_oss: Unknown symbol snd_register_oss_device
snd_pcm_oss: Unknown symbol snd_mixer_oss_ioctl_card
snd_pcm_oss: Unknown symbol snd_task_name
snd_pcm_oss: Unknown symbol snd_oss_info_register
snd_mixer_oss: Unknown symbol snd_unregister_oss_device
snd_mixer_oss: Unknown symbol snd_register_oss_device
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
snd_mixer_oss: Unknown symbol snd_oss_info_register

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 22:06 bladus         New Issue                                    
11-13-05 22:06 bladus         Distribution              => Gentoo Linux 2005.1
11-13-05 22:06 bladus         Kernel Version            => 2.6.14-ck1      
11-14-05 11:02 perex          Note Added: 0006713                          
11-14-05 11:02 perex          Assigned To               => perex           
11-14-05 11:02 perex          Status                   new => feedback     
11-14-05 13:39 bladus         Note Added: 0006722                          
11-14-05 13:55 bladus         Note Added: 0006723                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
