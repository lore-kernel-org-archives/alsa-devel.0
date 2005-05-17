From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001086]: surround5x plug will not work with nForce3 intel8x0
Date: Tue, 17 May 2005 18:28:44 +0200
Message-ID: <5d5c3aeac9881b74ab5121fb3eff5f8a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B7904310
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2005 18:28:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1086> 
======================================================================
Reported By:                b00zy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1086
Category:                   PCI - intel8x0
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-gentoo-r4
======================================================================
Date Submitted:             05-04-2005 10:27 CEST
Last Modified:              05-17-2005 18:28 CEST
======================================================================
Summary:                    surround5x plug will not work with nForce3 intel8x0
Description: 
When trying to use -Dplug:surround50 with aplay I'm unable to get
surround50 sound. Instead there is no sound.

lame --decode 01-at_the_drive-in-fahrenheit.mp3 - |aplay -Dplug:surround50
-

(no sound, though it *appears* to be playing)

Without -Dplug:surround50, I get stereo sound through the front-left/right
speakers, but nothing through rear-left/right or center speakers.

lame --decode 01-at_the_drive-in-fahrenheit.mp3 - |aplay -

(only front left/right speakers)

XMMS produces the same behavior when I set the audio device for ALSA
output plugin to "surround50". However, if I set I set it to
plug:surround50, XMMS freezes.
======================================================================

----------------------------------------------------------------------
 jdthood - 05-07-05 09:57 
----------------------------------------------------------------------
Does 5.1 sound work?

----------------------------------------------------------------------
 tiwai - 05-17-05 18:28 
----------------------------------------------------------------------
surround50 expects that the input channels are 5.
You would need to define an appropriate PCM type in ~/.asoundrc together
with route plugin with fixed "channels" parameter.  Otherwise the signals
won't be sent to surrounds.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-04-05 10:27 b00zy          New Issue                                    
05-04-05 10:27 b00zy          File Added: asound.state                     
05-04-05 10:27 b00zy          Kernel Version            => 2.6.11-gentoo-r4
05-04-05 10:29 b00zy          Issue Monitored: b00zy                       
05-04-05 10:41 b00zy          Issue End Monitor: b00zy                     
05-07-05 09:57 jdthood        Note Added: 0004603                          
05-17-05 18:28 tiwai          Note Added: 0004684                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
