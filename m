From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001531]: PCM output is muted most of the time
Date: Mon, 13 Mar 2006 15:36:28 +0100
Message-ID: <817c87ff43b2131bd691aaef42ad97eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B388177
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 15:36:28 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001841.
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
Last Modified:              03-12-2006 20:32 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001841 Mixer not working  / fujitsu laptop V20...
======================================================================

----------------------------------------------------------------------
 fchevalier - 03-12-06 20:32 
----------------------------------------------------------------------
Thinks are moving under bug id #1841, which looks like a duplicate of this
bug.
Maybe you should try the patch and if it works, send your configuration
information under this bug report ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-06-05 19:04 sq5bpm         New Issue                                    
11-06-05 19:04 sq5bpm         Distribution              => Gentoo 2.6.13-r5
11-06-05 19:04 sq5bpm         Kernel Version            => 2.6.13          
02-08-06 13:16 simonckenyon   Issue Monitored: simonckenyon                    
03-12-06 20:32 fchevalier     Note Added: 0008435                          
03-13-06 15:36 tiwai          Relationship added       related to 0001841  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
