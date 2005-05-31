From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000950]: Volume randomly(?) jumps to maximum, extreme distortion
Date: Tue, 31 May 2005 18:05:14 +0200
Message-ID: <f90acefdfe84769e8a4721e9ac161c4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4138B5
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:05:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=950> 
======================================================================
Reported By:                ugly
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   950
Category:                   PCI - ice1724
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian (sarge)
Kernel Version:             2.4.28-rc1
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-28-2005 04:38 CET
Last Modified:              05-31-2005 18:05 CEST
======================================================================
Summary:                    Volume randomly(?) jumps to maximum, extreme
distortion
Description: 
While listening to audio, my soundcard (M-Audio Revolution 7.1 - ice1724)
will randomly (as far as I can tell) garble the audio and raise the volume
to its maximum.  I continue to hear the distortion until I unload and
reload the ALSA kernel modules-- that is, I'll continue to hear distorted
sound while audio is playing.

Switching between my headphones and speakers makes no difference, nor does
changing media players (XMMS is what I use most often).  Adjusting the
DAC/DAC 1 volume (which is what controls the volume with my card) has no
effect either.

My volume in XMMS is set to 50% (ALSA output), and DAC/DAC 1 in Alsamixer
are both set to 49%.
======================================================================

----------------------------------------------------------------------
 ugly - 02-28-05 23:46 
----------------------------------------------------------------------
I switched to OSS and it still happens, so I'm not sure what's causing the
problem anymore.

----------------------------------------------------------------------
 jdthood - 03-22-05 22:25 
----------------------------------------------------------------------
Probably a local hardware problem of some sort.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-05 04:38 ugly           New Issue                                    
02-28-05 04:38 ugly           Distribution              => Debian (sarge)  
02-28-05 04:38 ugly           Kernel Version            => 2.4.28-rc1      
02-28-05 04:42 ugly           Issue Monitored: ugly                        
02-28-05 04:42 ugly           Issue End Monitor: ugly                      
02-28-05 23:46 ugly           Note Added: 0003751                          
03-22-05 22:25 jdthood        Note Added: 0004140                          
03-22-05 22:25 jdthood        Status                   new => resolved     
03-22-05 22:25 jdthood        Resolution               open => not an issue
05-31-05 18:05 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
