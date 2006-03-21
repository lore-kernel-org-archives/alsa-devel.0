From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001945]: aplay fails to complete on ppc
Date: Tue, 21 Mar 2006 17:31:20 +0100
Message-ID: <5719f0fcad85467ca600318ebd7c4b04@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 735B81EF
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 17:31:20 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1945> 
======================================================================
Reported By:                zarni
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1945
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               linuxfromscratch
Kernel Version:             2.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-20-2006 16:28 CET
Last Modified:              03-21-2006 17:31 CET
======================================================================
Summary:                    aplay fails to complete on ppc
Description: 
On my G5 SMU with an Audigy SE, aplay does not complete

'top' shows 99% cpu, there is no audible sound.

======================================================================

----------------------------------------------------------------------
 zarni - 03-20-06 22:42 
----------------------------------------------------------------------
It's in the eighth call to snd_pcm_writei : each time it passes 170 bytes,
the last time it never comes back (this is an 8KHz mono file). 
Unfortunately, I have no idea how to find the source for _snd_pcm_write,
for which this call is a wrapper.

----------------------------------------------------------------------
 tiwai - 03-21-06 17:31 
----------------------------------------------------------------------
It's a 32/64bit incompatibility in struct snd_timer_tread.  Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-20-06 16:28 zarni          New Issue                                    
03-20-06 16:28 zarni          Distribution              => linuxfromscratch
03-20-06 16:28 zarni          Kernel Version            => 2.6             
03-20-06 18:21 zarni          Note Added: 0008721                          
03-20-06 22:42 zarni          Note Added: 0008728                          
03-21-06 17:31 tiwai          Status                   assigned => resolved
03-21-06 17:31 tiwai          Resolution               open => fixed       
03-21-06 17:31 tiwai          Note Added: 0008748                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
