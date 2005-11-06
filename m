From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001531]: PCM output is muted most of the time
Date: Sun, 6 Nov 2005 19:04:34 +0100
Message-ID: <add4c64e7d2d95c343b8bba7d1ac908a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0FE3173
	for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2005 19:04:34 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1531> 
======================================================================
Reported By:                sq5bpm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1531
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2.6.13-r5
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-06-2005 19:04 CET
Last Modified:              11-06-2005 19:04 CET
======================================================================
Summary:                    PCM output is muted most of the time
Description: 
The soundcard's PCM output is silent in normal use, no errors are reported
by the snd-hda-intel module. 

The only way I found to hear something is to use gstreamer. This
application seems to do something extra during initialization, something
that allows the pass-through of the PCM output (both with alsasink and
osssink). However, touching anything in the alsamixer during gstreamer
playback causes the soundcard to become silent immediately (including the
all other outputs). The sound can be turned on again only by closing the
application using gstreamer and subsequently muting/unmuting all relevant
outputs. 

As for the CD playback, apart from the above problem with muting, the CD
player output works well.

This is somehow related to
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1478 , though here
the output is disabled by default. The same AD1986A soundcard chip. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-06-05 19:04 sq5bpm         New Issue                                    
11-06-05 19:04 sq5bpm         Distribution              => Gentoo 2.6.13-r5
11-06-05 19:04 sq5bpm         Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
