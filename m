From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001309]: hdsp 9632 w firmware 152 not working with Linux and ALSA 1.0.9
Date: Thu, 4 Aug 2005 09:04:15 +0200
Message-ID: <3dad86b5b74e5ad65cc068408388e6e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAC3B140
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 09:04:15 +0200 (MEST)
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


The issue 0001308 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1309> 
======================================================================
Reported By:                ado
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   1309
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             08-03-2005 23:35 CEST
Last Modified:              08-03-2005 23:35 CEST
======================================================================
Summary:                    hdsp 9632 w firmware 152 not working with Linux and
ALSA 1.0.9
Description: 
Hi,

today I got my new 9632. First I did a firmware (152) and driver (2.9.4)
update with the supplied windows software and studied the Totalmixer
and the other apllications for some hours under Windows - it's all very
impressive!!!

But my main goal is using the 9632 with Linux. And what a pitty: the
HDSPMixer application is totally unusable with the new firmware release.
The routing is mixed up (I couldn't find any rules for what was going
on) and I wasn't able to route the analog input signal to analog output!
Fortunately I found the old firmware on the RME server and that's it:
the routing is working now!

It would be very nice if anyone had time to answer my questions:
- will there be an ALSA update for the new firmware release?
- will there be an update to the Linux HDSPMixer including the
  features of the Windows release (selecting channels for common
  level adjustment, Switching monitoring to individual channels, ...)
  and the excelent Matrix window?
- when I'm starting a playback with audacity or xmms the signal is
  shown on all playback channels Out1 through Out12.
- does anybody have a working .asoundrc file for me?
- Can I use amixer to set routing and gain? What will I need to do this?

Thanks a lot for your patience and help

Ado Arnolds

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001308 hdsp 9632 w firmware 152 not working wi...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 23:35 ado            New Issue                                    
08-03-05 23:35 ado            Kernel Version            => 2.6.12.2        
08-03-05 23:38 ado            Issue Monitored: ado                         
08-04-05 09:04 perex          Relationship added       has duplicate 0001308
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
