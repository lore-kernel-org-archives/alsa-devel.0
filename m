From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001064]: snd_hda_intel does not recognize acl880 sound chip
Date: Thu, 25 Aug 2005 14:59:46 +0200
Message-ID: <08ff632b326af584e5699e79a7952b6f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCE7A205
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 14:59:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1064> 
======================================================================
Reported By:                jwiegley
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1064
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian-pure64
Kernel Version:             2.6.12-rc2
======================================================================
Date Submitted:             04-18-2005 20:42 CEST
Last Modified:              08-25-2005 14:59 CEST
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
 tiwai - 08-25-05 12:15 
----------------------------------------------------------------------
The CVS version as of Aug 24 includes the better support of ULI controller.
 But, it may still lack of the proper support of your device.  Try
different "model" module option.  The available models can be found in
patch_realtek.c.

The scratch noise may be reduced by adding "position_fix=1" or "2" module
option.  See ALSA-Configuration.txt for details.

----------------------------------------------------------------------
 hubs - 08-25-05 14:59 
----------------------------------------------------------------------
Thank you tiwai. For the scratch, both 1 and 2 values worked.
Regarding the model, I chose 6stack which made the jack in front work. But
I don't have 6 jacks in rear. I have 3 jacks in back and 2 in front. I
don't care, the sound is now really good ;)

For my information, has the patched azx driver been useful for you?
Thanks again

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
