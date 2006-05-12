From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002103]: Sound goes off when adjusting volume from alsa-mixer
Date: Fri, 12 May 2006 10:42:39 +0200
Message-ID: <f71d2b2121e6b08e34dc1e281ecd9e99@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C6425219
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 10:42:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2103> 
======================================================================
Reported By:                raddy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2103
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             05-08-2006 11:28 CEST
Last Modified:              05-12-2006 10:42 CEST
======================================================================
Summary:                    Sound goes off when adjusting volume from alsa-mixer
Description: 
i have an Asus P5RD2-VM motherboard equipped with Uli M5461 integrated 
sound card supporting HD-Audio,
it uses snd_hda_intel driver,
it was detected fine,
Alsa played a test sound that itself produced no sound from speakers,
sound is going off in many curcomstance,
they are,
1 > when adjusting volume,
2 > switching to several songs intermittently.

======================================================================

----------------------------------------------------------------------
 UMMO - 05-12-06 10:42 
----------------------------------------------------------------------
I'm having the same issue on my Lenovo 3000 N100 using the Intel ICH7 rev
02 chipset. Alsamixer reports the audio chip as an Analog Devices AD1986A.
Using ALSA 1.0.11 drivers compiled separately, and a 2.6.16 kernel.

After loading the ALSA modules, sound works fine until trying to adjust
the mixer in any way while an audio stream is playing, after which it just
cuts off completely. If I close all playing audio streams and tweak the
headphone and PCM mixers up and down a bit using alsamixer, it comes back
and new streams will play until I adjust the mixer again.

Also, there's no sound on the internal speakers, only the headphone jack.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 11:28 raddy          New Issue                                    
05-08-06 11:28 raddy          Distribution              => Suse            
05-08-06 11:28 raddy          Kernel Version            => 2.6.13-15       
05-10-06 07:54 raddy          Issue Monitored: raddy                       
05-12-06 10:42 UMMO           Note Added: 0009774                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
