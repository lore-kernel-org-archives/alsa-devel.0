From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000563]: No midi volume control
Date: Mon,  4 Oct 2004 09:07:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041004070753.2054A3F01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 78AEA285
	for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2004 09:07:53 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000563
======================================================================
Reported By:                keeron
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     563
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora core2
Kernel Version:             Linux-2.6.8.1
Resolution:                 fixed
======================================================================
Date Submitted:             10-03-2004 12:07 CEST
Last Modified:              10-04-2004 09:07 CEST
======================================================================
Summary:                    No midi volume control
Description: 
The internal midi generator seem to work - but its silent. Its not
availible in AC97/Nforce2 controls (alsamixer/amixer) nor when im locking
into the source.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-04-2004 09:07 CEST 
----------------------------------------------------------------------
Onboard AC'97 chips do not have a MIDI synthesizer.

The MIDI port can be used to communicate with external MIDI devices
connected to the game port.

To play MIDI, you have to use a software synthesizer like Timidity or
fluidsynth.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 12:07 keeron         New Bug                                      
10-03-04 12:07 keeron         Distribution              => Fedora core2    
10-03-04 12:07 keeron         Kernel Version            => Linux-2.6.8.1   
10-04-04 09:07 Clemens LadischBugnote Added: 0002009                       
10-04-04 09:07 Clemens LadischAssigned To               => Clemens Ladisch 
10-04-04 09:07 Clemens LadischResolution               open => fixed       
10-04-04 09:07 Clemens LadischStatus                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
