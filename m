From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000510]: Utilization of AC'97 on Aureon 7.1 Space
Date: Thu, 23 Sep 2004 20:45:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923184513.F3B9F3E010@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4435F326
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 20:45:14 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000510
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     510
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             3.1
======================================================================
Date Submitted:             09-21-2004 09:41 CEST
Last Modified:              09-23-2004 20:45 CEST
======================================================================
Summary:                    Utilization of AC'97 on Aureon 7.1 Space
Description: 
As of now, the Aureon driver lacks the capability to playback both analog
input channels and the PCM channel, and the input channels have no
seperate volume control, although the AC'97 chip on the board, STAC9744,
apparently has the capability.

I tried some commercial OSS drivers, and they worked properly, so I know
that it is possible.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-21-2004 11:54 CEST 
----------------------------------------------------------------------
Unfortunately, no information from terratec at all about this.

----------------------------------------------------------------------
 ungod - 09-23-2004 20:45 CEST 
----------------------------------------------------------------------
Which is sad. But I've tried some commercial OSS drivers, which actually
utilize the AC'97 chip.
Anyway, by looking at the GPIO pins after changing the volume of one of
the analog inputs, the exactly register value is stored on GPIO0 - GPIO7.
Not much help, but it gives an idear of how the XILINX chip is to be used.
You probably define the register address on the same pins, toggle one of
the other pins, and the puts the data on the pins and toggle another pin
again.

I don't know. Purely speculations...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 09:41 ungod          New Bug                                      
09-21-04 09:41 ungod          Distribution              => Debian GNU/Linux
09-21-04 09:41 ungod          Kernel Version            => 3.1             
09-21-04 11:54 tiwai          Bugnote Added: 0001796                       
09-23-04 20:45 ungod          Bugnote Added: 0001848                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
