From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000986]: snd-ice1724 outputs white noise on rear surround output of Chaintech AV-710
Date: Sat, 19 Mar 2005 08:17:07 +0100
Message-ID: <a712c99ac91cf9a583069828421e36f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EDDC71CF
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 08:17:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=986> 
======================================================================
Reported By:                AdamW
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   986
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandrakelinux Cooker
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-12-2005 22:43 CET
Last Modified:              03-19-2005 08:17 CET
======================================================================
Summary:                    snd-ice1724 outputs white noise on rear surround
output of Chaintech AV-710
Description: 
A little background. The Chaintech AV-710 soundcard is a 7.1 soundcard
which uses this driver. It has two DACs. There's a standard DAC that
drives the first six channels. The rear surround channels, however, are
driven by a high-quality Wolfson DAC. Audio enthusiasts like to set the
card to drive the main two channels through this DAC instead in order to
get a very high quality stereo line-level output. The card's Windows
driver has an option to do just this, and in the past people have been
successful doing it on Linux. I am attaching an asound.state file which
owners of this card used with ALSA 1.0.7 to achieve this. However, I am
having trouble getting this to work with ALSA 1.0.8. The rear surround
output just produces white noise all the time. This is the case both with
this asound.state loaded and also with default levels (i.e., what I get if
I wipe /etc/asound.state and re-run alsaconf). It'd be nice to know what
changed between 1.0.7 and 1.0.8 that caused this to break, and how to fix
it. Thanks!
======================================================================

----------------------------------------------------------------------
 AdamW - 03-14-05 16:23 
----------------------------------------------------------------------
Some corrections and clarifications. ADS tells me the version of ALSA the
file worked on was earlier than 1.0.7, he thinks 1.0.6. I tried rolling my
ALSA back to 1.0.6 by installing an old MDK kernel, but no joy - still
white noise. I'll try and find a kernel with 1.0.5 later. ADS confirms my
problem with 1.0.8 (he has white noise too) and cannot find any mixer
settings to fix it. I tried the driver from 1.0.9rc1, same problem.
Thanks!

----------------------------------------------------------------------
 AdamW - 03-19-05 08:17 
----------------------------------------------------------------------
Further information:

http://www.hydrogenaudio.org/forums/lofiversion/index.php/t31667.html

Executive summary of that thread - someone is experiencing exactly the
same problem with 1.0.6. If they warm reboot to Windows, play some audio,
then warm reboot back to Linux, it works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 22:43 AdamW          New Issue                                    
03-12-05 22:43 AdamW          File Added: asound.state                     
03-12-05 22:43 AdamW          Distribution              => Mandrakelinux Cooker
03-12-05 22:43 AdamW          Kernel Version            => 2.6.11          
03-14-05 16:23 AdamW          Note Added: 0003904                          
03-19-05 08:17 AdamW          Note Added: 0004010                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
