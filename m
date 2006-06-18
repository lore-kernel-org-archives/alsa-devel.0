From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002103]: Sound goes off when adjusting
	volume from alsa-mixer
Date: Sun, 18 Jun 2006 09:26:53 +0200
Message-ID: <3556d0849312689b98f0729f3db0c19a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 72637147
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jun 2006 09:26:53 +0200 (MEST)
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
Last Modified:              06-18-2006 09:26 CEST
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
 UMMO - 05-12-06 17:13 
----------------------------------------------------------------------
I managed to solve this using model=laptop-eapd. Applying the patch at
https://lists.ubuntu.com/archives/kernel-team/2006-April/000833.html
worked for autodetection.



----------------------------------------------------------------------
 raddy - 06-18-06 09:26 
----------------------------------------------------------------------
Hello Everybody

i installed SUSE 10.1 recently,
it comes with alsa 1.0.11 ,
my sound card's codec chip is AD1986A
i used model=laptop-eapd , 
but still same problem,
please help

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 11:28 raddy          New Issue                                    
05-08-06 11:28 raddy          Distribution              => Suse            
05-08-06 11:28 raddy          Kernel Version            => 2.6.13-15       
05-10-06 07:54 raddy          Issue Monitored: raddy                       
05-12-06 10:42 UMMO           Note Added: 0009774                          
05-12-06 10:43 UMMO           Issue Monitored: UMMO                        
05-12-06 16:04 tiwai          Note Added: 0009776                          
05-12-06 17:09 UMMO           Note Added: 0009781                          
05-12-06 17:13 UMMO           Note Edited: 0009781                         
05-23-06 16:21 shadoweel      Issue Monitored: shadoweel                    
06-18-06 09:26 raddy          Note Added: 0010296                          
======================================================================
