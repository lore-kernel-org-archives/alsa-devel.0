From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001926]: No sound and no internal speakers with Samsung R65-T2300 Charis notebook
Date: Thu, 16 Mar 2006 15:37:56 +0100
Message-ID: <a3c957be24b82c50db8aac70a2d3c99a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFEFC1B4
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 15:37:56 +0100 (MET)
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
Last Modified:              03-16-2006 15:37 CET
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

----------------------------------------------------------------------
 tiwai - 03-16-06 14:54 
----------------------------------------------------------------------
The attached patch adds a new model "laptop-eapd".  It's enabled
automatically for your device.

With this model, you'll have "Master" and "PCM" volumes/mutes.  Both
influence on headphone and (possibly) internal speaker at the same time. 
Don't forget to unmute both Master and PCM.
There is a new control "External Amplifier", which hopefully toggles
speaker on/off.

If this doesn't work, change line 625 to '#if 1'.  This will add 'Speaker'
and 'Headphone' volumes/mutes.

If the patch works but the speaker isn't muted even after plugging the
headphone, we need to toggle the speaker on software with jack detection. 
Try to uncomment line 586 '#define EAPD_AUTO_MUTE'.  (Note that this might
be a bit dangerous, prepare for reboot ;)

----------------------------------------------------------------------
 tassilo80 - 03-16-06 15:37 
----------------------------------------------------------------------
Hey tiwai.

It works with the patch (no modifications were needed). The internal
speaker work and if I plugin the headphones the speakers are muted, too.

Thanks for your great and fast help!

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
