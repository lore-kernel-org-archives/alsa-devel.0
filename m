From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001319]: MIDI I/O (MPU-401) works for output only, not input
Date: Fri, 12 Aug 2005 16:38:57 +0200
Message-ID: <07e82b0ed85727c813d65c8595c4aa50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4D531EE
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 16:38:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1319> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1319
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-08-2005 05:38 CEST
Last Modified:              08-12-2005 16:38 CEST
======================================================================
Summary:                    MIDI I/O (MPU-401) works for output only, not input
Description: 
I have a Sound Blaster PCI 512, and MIDI interfacing with external devices,
such as keyboards, only works for output (from the soundcard to other
devices). When I try to do input (from those devices to the soundcard) no
events get through at all.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 08-12-05 16:30 
----------------------------------------------------------------------
Try to load the driver with the enable_ir=1 option.

----------------------------------------------------------------------
 roothorick - 08-12-05 16:38 
----------------------------------------------------------------------
Passing the option enable_ir=1 had no effect whatsoever.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 05:38 roothorick     New Issue                                    
08-11-05 14:31 tiwai          Note Added: 0005759                          
08-11-05 17:41 roothorick     Note Added: 0005761                          
08-12-05 15:53 tiwai          Note Added: 0005776                          
08-12-05 16:17 roothorick     Note Added: 0005779                          
08-12-05 16:30 Clemens LadischNote Added: 0005780                          
08-12-05 16:38 roothorick     Note Added: 0005781                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
