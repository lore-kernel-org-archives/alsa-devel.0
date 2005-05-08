From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000986]: snd-ice1724 outputs white noise on rear surround output of Chaintech AV-710
Date: Sun, 8 May 2005 20:49:37 +0200
Message-ID: <b1d609a23999116dbe40fe9e2f5f84db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 38A40248
	for <alsa-devel@alsa-project.org>; Sun,  8 May 2005 20:49:38 +0200 (MEST)
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
Last Modified:              05-08-2005 20:49 CEST
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
 jamesferguson - 04-29-05 15:24 
----------------------------------------------------------------------
Just a quick note to say there are others very interested in this issue for
reasons given by AdamW, in particular in the MythTv/KnoppMyth community. 
I would be happy to lend my card to a developer who can help, though
postage outside the USA would probably not be worthwhile... 
Alternatively, I'd club up with some others to buy a card for a developer
(they're cheap). 
<alsa.wjcf at xoxy.net>

----------------------------------------------------------------------
 jaanusk_ - 05-08-05 20:49 
----------------------------------------------------------------------
Uploaded patch which fixes this issue for me. Alsa didn't initialize
wolfson codec , added rudimentary init code to amp.[c, h]. WM8728 and
vt1721 are connected using I2C, wm has address 0x36, audio transport using
24bit I2S.

Summary: Add WM8728 initialization to amp2000

This patch makes it possible to use the higher quality wolfson dac.

Signed-off-by: Jaanus Kivistik <jaanus@no.spam.ee>

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
05-08-05 20:46 jaanusk_       File Added: amp2000_wm8728.patch                  
 
05-08-05 20:49 jaanusk_       Note Added: 0004619                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
