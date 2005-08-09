From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000986]: snd-ice1724 outputs white noise on rear surround output of Chaintech AV-710
Date: Tue, 9 Aug 2005 13:44:22 +0200
Message-ID: <9f51239e7fd5769380cd40721d738fc7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A14BF1E6
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=986> 
======================================================================
Reported By:                AdamW
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   986
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Mandrakelinux Cooker
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-12-2005 22:43 CET
Last Modified:              08-09-2005 13:44 CEST
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
 jaanusk_ - 05-24-05 21:35 
----------------------------------------------------------------------
Seems so, at least all av710-s seem to be detected as audio2000-s. From my
AV710:

EEPROM:
  Subvendor        : 0x12142417
  Size             : 28 bytes
  Version          : 1
  System Config    : 0x2
  ACLink           : 0x2
  I2S              : 0x10
  S/PDIF           : 0xc1
  GPIO direction   : 0xff
  GPIO mask        : 0xff
  GPIO state       : 0xff
  Extra #18        : 0x1
  Extra #19        : 0x0
  Extra #20        : 0x0
  Extra #21        : 0x0
  Extra #22        : 0x0
  Extra #23        : 0x0
  Extra #24        : 0x0
  Extra #25        : 0x0
  Extra #26        : 0x0
  Extra #27        : 0x0

----------------------------------------------------------------------
 tiwai - 05-27-05 17:26 
----------------------------------------------------------------------
Fixed on CVS, aka 1.0.9-final.  Thanks.

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
05-08-05 20:50 jaanusk_       Issue Monitored: jaanusk_                    
05-09-05 07:42 AdamW          Note Added: 0004621                          
05-09-05 10:43 jaanusk_       Note Added: 0004623                          
05-09-05 18:09 AdamW          Note Added: 0004628                          
05-24-05 12:23 tiwai          Note Added: 0004716                          
05-24-05 21:35 jaanusk_       Note Added: 0004729                          
05-27-05 17:26 tiwai          Status                   new => resolved     
05-27-05 17:26 tiwai          Resolution               open => fixed       
05-27-05 17:26 tiwai          Assigned To               => tiwai           
05-27-05 17:26 tiwai          Note Added: 0004754                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
