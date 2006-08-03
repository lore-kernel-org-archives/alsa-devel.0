From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002328]: Absolutely no sound
	whatsoever on PB A8550 w/ Intel 82801 (ICH6)
Date: Thu, 3 Aug 2006 07:43:40 +0200
Message-ID: <9cf25d004d5d825f8ef734d14247d375@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6058C195
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Aug 2006 07:43:40 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2328> 
======================================================================
Reported By:                Illarane
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2328
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15-1
======================================================================
Date Submitted:             08-03-2006 07:43 CEST
Last Modified:              08-03-2006 07:43 CEST
======================================================================
Summary:                    Absolutely no sound whatsoever on PB A8550 w/ Intel
82801 (ICH6)
Description: 
No matter what I have tried, there is absolutely no sound coming from
either the built-in speakers or the headphones jack on this laptop. 
alsaconf correctly identifies the sound card, however it sets it up
exactly how I did, and thus doesn't fix the problem, all the correct
modules are identified and installed at boot, everything is unmuted and
turned right up, and the External Amplifier switch is OFF.  The OSS
drivers (i810_audio) do not work either.  I can't even get noise from
catting /bin/bash to /dev/dsp.

For all intents and purposes, this is working fine; there are no errors,
no warnings, I literally get nothing, not even sound.

Apparently there is a software 'jacksense' switch which controls the
output somehow?  I cannot see this in any of the mixers, so is there a
patch somewhere with which it can be added?

The last point to note is that when I cat /proc/asound/cards, I get this:
0 [ICH6           ]: ICH4 - Intel ICH6
                     Intel ICH6 with unknown codec at 0xb0040800, irq 169
Unknown codec?

I've included the relevant outputs below.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-06 07:43 Illarane       New Issue                                    
08-03-06 07:43 Illarane       File Added: asound.state                     
08-03-06 07:43 Illarane       Distribution              => Debian          
08-03-06 07:43 Illarane       Kernel Version            => 2.6.15-1        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
