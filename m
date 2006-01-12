From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000818]: Web browsing in Mozilla causes ADAT clocks on HDSP 9652 to be invalid
Date: Fri, 13 Jan 2006 00:54:09 +0100
Message-ID: <50039e8bed944038b6a24173687ed4d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD284120
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:54:09 +0100 (MET)
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
Last Modified:              01-13-2006 00:54 CET
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
 rlrevell - 01-13-06 00:17 
----------------------------------------------------------------------
Do you consider this bug resolved?

----------------------------------------------------------------------
 Mark Knecht - 01-13-06 00:54 
----------------------------------------------------------------------
The way I actually solved it was to run Jack all the time on the HDSP so
that no one can change sounds, and then use the internal sound chip for
system sounds so that I don't have to deal with this. I don't use the
feature as described in this bug report, although I *think* it does work.

I think it's safe to close as it doesn't seem to bother anyone else.

Thanks.

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
10-05-05 18:50 tiwai          Note Added: 0006436                          
10-12-05 14:17 tiwai          Note Added: 0006466                          
10-12-05 18:17 Mark Knecht    Note Added: 0006468                          
10-12-05 18:20 tiwai          Note Added: 0006469                          
10-12-05 18:50 Mark Knecht    Note Added: 0006470                          
10-12-05 18:55 tiwai          Note Added: 0006471                          
10-12-05 19:03 Mark Knecht    Note Added: 0006472                          
10-12-05 19:08 tiwai          Note Added: 0006473                          
10-16-05 16:24 Mark Knecht    Note Added: 0006482                          
10-16-05 22:25 Mark Knecht    Note Added: 0006484                          
01-13-06 00:17 rlrevell       Note Added: 0007599                          
01-13-06 00:54 Mark Knecht    Note Added: 0007608                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
