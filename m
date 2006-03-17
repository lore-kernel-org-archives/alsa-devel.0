From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001926]: No sound and no internal speakers with Samsung R65-T2300 Charis notebook
Date: Fri, 17 Mar 2006 02:45:30 +0100
Message-ID: <624ac2a22dae9fa10d3c3e81a952c135@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 78DFE1C2
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 02:45:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1926> 
======================================================================
Reported By:                tassilo80
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1926
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-15-2006 18:21 CET
Last Modified:              03-17-2006 02:45 CET
======================================================================
Summary:                    No sound and no internal speakers with Samsung
R65-T2300 Charis notebook
Description: 
I have no sound on my laptop. 

First I tried alsa-diver-1.0.11rc3:
* The headphones are listed in alsamixer, but the internal speakers are
not listed.
* There's no sound with headphones
* If I apply the patch mentioned in bug #1793
(http://quaggaspace.org/a8nvm/a8nvmsound.patch) I have at least sound with
my headphones

The I tried the current CVS:
* without model-option I had short a sound on my right headphone till I
tweaked the mixer settings
* with model=laptop I had no sound at all
* with model=3stack I had no sount at all, too
* if I apply the patch mentioned above and give no model-option, the sound
works again (only headphones)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001925 no sound from hda_intel
======================================================================

----------------------------------------------------------------------
 tassilo80 - 03-17-06 02:30 
----------------------------------------------------------------------
I checked out again and applied the new patch. Here are the results:

  * Sound works with headphones and internal speakers (external amp toggle
works, too)
  * recording works with external microphone
  * recording doesn't work with internal mic
  * Playing CDs does not work (neither with the old patch where I had a CD
toggle, nor with the new patch which offers only Mic, Mix and Internal)

----------------------------------------------------------------------
 rlrevell - 03-17-06 02:45 
----------------------------------------------------------------------
You might have to use an app that plays CDs in digital mode.  I suspect
that some vendors are not connecting the analog CD output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 18:21 tassilo80      New Issue                                    
03-15-06 18:21 tassilo80      File Added: asound.state                     
03-15-06 18:26 tassilo80      File Added: codec-files                      
03-15-06 18:50 tiwai          Note Added: 0008563                          
03-15-06 18:59 tassilo80      Note Added: 0008565                          
03-15-06 19:35 tiwai          Note Added: 0008568                          
03-15-06 19:56 tassilo80      Note Added: 0008571                          
03-16-06 14:54 tiwai          Note Added: 0008604                          
03-16-06 14:56 tiwai          File Added: ad1986a-laptop-eapd.diff              
     
03-16-06 15:37 tassilo80      Note Added: 0008607                          
03-16-06 16:14 tiwai          Note Added: 0008609                          
03-16-06 16:26 tiwai          File Added: ad1986a-laptop-eapd-new.diff          
         
03-16-06 16:27 tiwai          Note Added: 0008610                          
03-16-06 17:25 tassilo80      Note Added: 0008613                          
03-16-06 17:31 tiwai          Note Added: 0008614                          
03-16-06 17:33 tiwai          Relationship added       has duplicate 0001925
03-16-06 20:14 stefanob       Issue Monitored: stefanob                    
03-17-06 02:30 tassilo80      Note Added: 0008627                          
03-17-06 02:45 rlrevell       Note Added: 0008630                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
