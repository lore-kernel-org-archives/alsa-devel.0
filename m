From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000818]: Web browsing in Mozilla causes ADAT clocks on HDSP 9652 to be invalid
Date: Thu, 29 Sep 2005 00:30:50 +0200
Message-ID: <9a45baed110dada2be9543a42ad97395@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B3F8163
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 00:30:51 +0200 (MEST)
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
Status:                     feedback
Distribution:               FC2
Kernel Version:             2.6.8.1-1.520.2vS7.ll.rhfc2.ccrma
======================================================================
Date Submitted:             01-14-2005 18:35 CET
Last Modified:              09-29-2005 00:30 CEST
======================================================================
Summary:                    Web browsing in Mozilla causes ADAT clocks on HDSP
9652 to be invalid
Description: 
In my setup I's using 3 computers:

1) PanetCCRMA with HDSP 9652 as the center of an audio hub

2) Win XP GigaStudio with Hammerfall Light - two ADAT outputs streaming to
HDSP 9652 (ADAT input for clock)

3) Win XP Pro Tools Digi 002 Rack receiving GigaStudio audio from PC #2

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
 jdthood - 09-19-05 09:58 
----------------------------------------------------------------------
> Thomas, could you check the patch I sent ago in alsa-devel ML?
> This adds 'sample clock lock' control like ice1712 driver.

charbonnel: Did you try the patch?

----------------------------------------------------------------------
 Mark Knecht - 09-29-05 00:30 
----------------------------------------------------------------------
As of recent kernels, ala 2.6.14-rc2 the problem still occurs. I've learned
to live with Jack running and the HDSP 9652 set ass the second card. I let
the onboard sound chip be the default device. All low-quality or OSS sound
goes through the on-board chip, out through a cable and back into the HDSP
9652 using a stereo input on an external A/D. This works great for me in
general.

I don't have an example right now but if I forget to turn on Jack then I
see the dmesg log filling up with messages about HDSP : unable to change
clock rate. Every time it tries that I get the horrible loud noise.

Anyway, it's not 'fixed' or 'patched' as far as I can tell.

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
02-01-05 22:07 charbonnel     Status                   assigned => resolved
02-01-05 22:07 charbonnel     Resolution               open => not an issue
02-01-05 22:07 charbonnel     Note Added: 0003472                          
02-01-05 22:12 Mark Knecht    Status                   resolved => feedback
02-01-05 22:12 Mark Knecht    Resolution               not an issue => reopened
02-01-05 22:12 Mark Knecht    Note Added: 0003474                          
02-02-05 10:20 tiwai          Note Added: 0003477                          
09-19-05 09:58 jdthood        Note Added: 0006277                          
09-29-05 00:30 Mark Knecht    Note Added: 0006411                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
