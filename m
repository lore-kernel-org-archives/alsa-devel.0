From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001064]: snd_hda_intel does not recognize acl880 sound chip
Date: Tue, 22 Nov 2005 19:24:05 +0100
Message-ID: <956201aa1d7b61e4131057fc53f3c8b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 255F61B0
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 19:24:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1064> 
======================================================================
Reported By:                jwiegley
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1064
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian-pure64
Kernel Version:             2.6.12-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-18-2005 20:42 CEST
Last Modified:              11-22-2005 19:24 CET
======================================================================
Summary:                    snd_hda_intel does not recognize acl880 sound chip
Description: 
I bought a Shuttle ST20G5 box. Sound doesn't get detected or
seem to work with manual load.

chipset:
  ATI Xpress 200 northbridge
  ULI 1573 southbridge

The documentation says the sound is:
  Realtek ALC880

alsaconf detects nothing
manually loading snd_hda_intel also doesn't print anything in the
log files; though it does seem to load all the snd stuff just fine.
======================================================================

----------------------------------------------------------------------
 hubs - 08-25-05 14:59 
----------------------------------------------------------------------
Thank you tiwai. For the scratch, both 1 and 2 values worked.
Regarding the model, I chose 6stack which made the jack in front work. But
I don't have 6 jacks in rear. I have 3 jacks in back and 2 in front. I
don't care, the sound is now really good ;)

For my information, has the patched azx driver been useful for you?
Thanks again

----------------------------------------------------------------------
 rlrevell - 11-22-05 19:24 
----------------------------------------------------------------------
Reporter says bug is fixed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 20:42 jwiegley       New Issue                                    
04-18-05 20:42 jwiegley       File Added: ST20G5lspci.txt                    
04-18-05 20:42 jwiegley       Distribution              => Debian-pure64   
04-18-05 20:42 jwiegley       Kernel Version            => 2.6.12-rc2      
04-19-05 17:34 tiwai          Category                 PCI - azx => PCI -
hda-intel
04-19-05 17:38 tiwai          Note Added: 0004523                          
06-09-05 16:20 Ballbreaker    Issue Monitored: Ballbreaker                    
06-12-05 20:52 jwiegley       Note Added: 0005001                          
06-15-05 14:39 tiwai          Note Added: 0005026                          
07-04-05 23:27 Christoph      Issue Monitored: Christoph                    
07-04-05 23:39 Christoph      Note Added: 0005388                          
07-08-05 12:03 tiwai          Note Added: 0005413                          
07-08-05 17:04 Christoph      Note Added: 0005433                          
08-12-05 18:11 Ballbreaker    Issue End Monitor: Ballbreaker                    
08-23-05 14:40 hubs           Note Added: 0005905                          
08-23-05 14:40 hubs           Issue Monitored: hubs                        
08-25-05 11:57 hubs           Note Added: 0005938                          
08-25-05 12:15 tiwai          Note Added: 0005939                          
08-25-05 14:59 hubs           Note Added: 0005940                          
11-22-05 19:24 rlrevell       Status                   new => resolved     
11-22-05 19:24 rlrevell       Resolution               open => fixed       
11-22-05 19:24 rlrevell       Assigned To               => rlrevell        
11-22-05 19:24 rlrevell       Note Added: 0006795                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
