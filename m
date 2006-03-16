From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001532]: Mute controls are gone, therefore unmuting impossible and no sound: NM256,AC97
Date: Thu, 16 Mar 2006 08:03:31 +0100
Message-ID: <803d8828557d13dc1a2ed590f5f4dac3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D24C8194
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:03:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1532> 
======================================================================
Reported By:                sstefan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1532
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-06-2005 19:32 CET
Last Modified:              03-16-2006 08:03 CET
======================================================================
Summary:                    Mute controls are gone, therefore unmuting
impossible and no sound: NM256,AC97
Description: 
Upgrading from Linux 2.6.10 to 2.6.13, I was no longer able to use the alsa
nm256 driver, because the mute controls (e.g. for Master and PCM output)
disappeared from alsamixer or kmix. The chip is muted by default, so upon
playing nothing is output to the speakers, and there's no way to unmute
the channels.
======================================================================

----------------------------------------------------------------------
 sstefan - 11-10-05 22:31 
----------------------------------------------------------------------
I isolated the code that actually broke it, it is the snd_ac97_try_bit if
clause in  snd_ac97_cmix_new_stereo().
---
	if (snd_ac97_try_bit(ac97, reg, 15)) {
        {
		sprintf(name, "%s Switch", pfx);
		if ((err = snd_ac97_cmute_new_stereo(card, name, reg, check_stereo,
ac97)) < 0)
			return err;
	}
---
When I commented out the condition, the mute switches were all there!

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:03 
----------------------------------------------------------------------
Was this ever resolved?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-06-05 19:32 sstefan        New Issue                                    
11-06-05 19:32 sstefan        Distribution              => Debian          
11-06-05 19:32 sstefan        Kernel Version            => 2.6.13          
11-08-05 18:29 tiwai          Note Added: 0006632                          
11-10-05 00:23 sstefan        Note Added: 0006658                          
11-10-05 22:31 sstefan        Note Added: 0006674                          
03-16-06 08:03 rlrevell       Note Added: 0008589                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
