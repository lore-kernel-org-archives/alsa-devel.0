From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000818]: Web browsing in Mozilla causes ADAT clocks on HDSP 9652 to be invalid
Date: Tue, 1 Feb 2005 22:03:10 +0100
Message-ID: <95c4b570c0c2e69bf49f73ae217d3113@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C19F11E8
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2005 22:03:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=818> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   818
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC2
Kernel Version:             2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
======================================================================
Date Submitted:             01-14-2005 18:35 CET
Last Modified:              02-01-2005 22:03 CET
======================================================================
Summary:                    Web browsing in Mozilla causes ADAT clocks on HDSP
9652 to be invalid
Description: 
In my setup I's using 3 computers:

1) PanetCCRMA with HDSP 9652 as the center of an audio hub

2) Win XP GigaStudio with Hammerfall Light - two ADAT outputs streaming to
HDSP 9652 (ADAT input for clock)

3) Win XP Pro Tools Digi 002 Rack receiving GigaStudio audio from PC
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2

So the signal flow looks like:

XP         Linux           XP
GSt ====> HDSP 9652 ====> Pro Tools
   <=== (ADAT Clock)

The HDSP 9652 is the master clock for the network. Both XP machine sync to
the HDSP 9652.

When no specific audio apps are running on the Linux box then this
configuration will work for hours if not days with no problems. All audio
data from GSt flows through the HDSP 9652's hardware and the hardware
mixer sends it on to the Pro Tools box. It works perfectly.

When Mozilla is started and I switch from page to page, after a few
minutes I will receive a message on the Pro Tools box that the clock
supplied by the HDSP 9652 was invalid. I can browse the same web pages on
either XP box and I do not corrupt the clocks.
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 02-01-05 21:46 
----------------------------------------------------------------------
Hi Thomas,
   Interesting. Best I can tell these days (since I reported this a couple
of weeks ago) is that not all web sites cause Mozilla to do whatever it
does. Many, even most, cause me no problems with the current revision of
Alsa from PlanetCCRMA.

   We had some conversations about this on LAU or Alsa-devel - I don't
remember which. Seemed that folks there thought it was possible to extend
Alsa one fo these days to be able to lock down the card's sample rate
instead of letting any app change it. That would be fine with me. I don't
care about OSS audio quality. I just want hdspconf to be in total control
so that I set the card's sample rate and it doesn't change, but maybe
that's for some future date.

   Currently I do not use Mozilla when doing important audio stuff but
that forces me to do web browsing on a Windows box instead.

   Anyway, thanks for looking into this and thinking about future
improvements.

Cheers,
Mark

----------------------------------------------------------------------
 rlrevell - 02-01-05 22:03 
----------------------------------------------------------------------
Mark,

Your problem is not Mozilla per se but the Flash player plugin.  It uses
ALSA's OSS emulation.

A guaranteed workaround is to uninstall the Flash plugin.  Then mozilla
will *never* touch your audio device.  You could set up two browser
configs, one with Flash and one without, and use the Flash free config for
safe browsing while doing audio work.

Or, you could disable ALSA's OSS emulation.  You could even map /dev/dsp
to /dev/null, and configure "well behaved" OSS apps use /dev/dsp1.  Then
you could browse Flash pages, but Flash would not be able to make sounds
at all.

A side benefit is that you get less annoying ads with Flash removed.

Lee

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-05 18:35 Mark Knecht    New Issue                                    
01-14-05 18:35 Mark Knecht    Distribution              => FC2             
01-14-05 18:35 Mark Knecht    Kernel Version            =>
2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
02-01-05 21:35 charbonnel     Note Added: 0003466                          
02-01-05 21:46 Mark Knecht    Note Added: 0003470                          
02-01-05 22:03 rlrevell       Note Added: 0003471                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
