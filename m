From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000986]: snd-ice1724 outputs white noise on rear surround output of Chaintech AV-710
Date: Fri, 29 Apr 2005 15:24:59 +0200
Message-ID: <42f92aed220fabbe56bcbd5e51c03295@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7EC7720B
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2005 15:24:59 +0200 (MEST)
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
Last Modified:              04-29-2005 15:24 CEST
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
 AdamW - 03-19-05 08:17 
----------------------------------------------------------------------
Further information:

http://www.hydrogenaudio.org/forums/lofiversion/index.php/t31667.html

Executive summary of that thread - someone is experiencing exactly the
same problem with 1.0.6. If they warm reboot to Windows, play some audio,
then warm reboot back to Linux, it works.

----------------------------------------------------------------------
 jamesferguson - 04-29-05 15:24 
----------------------------------------------------------------------
Just a quick note to say there are others very interested in this issue for
reasons given by AdamW, in particular in the MythTv/KnoppMyth community. 
I would be happy to lend my card to a developer who can help, though
postage outside the USA would probably not be worthwhile... 
Alternatively, I'd club up with some others to buy a card for a developer
(they're cheap). 
<alsa.wjcf at xoxy.net>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 22:43 AdamW          New Issue                                    
03-12-05 22:43 AdamW          File Added: asound.state                     
03-12-05 22:43 AdamW          Distribution              => Mandrakelinux Cooker
03-12-05 22:43 AdamW          Kernel Version            => 2.6.11          
03-14-05 16:23 AdamW          Note Added: 0003904                          
03-19-05 08:17 AdamW          Note Added: 0004010                          
04-29-05 15:18 jamesferguson  Issue Monitored: jamesferguson                    
04-29-05 15:24 jamesferguson  Note Added: 0004579                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
