From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000553]: Experimental feature for dual codecs produce choppy sound
Date: Thu, 30 Sep 2004 07:51:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040930055112.AFFC1B0A0@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3822208
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2004 07:51:12 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id B989227A9B
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2004 07:51:12 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000553
======================================================================
Reported By:                cgdef
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     553
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-30-2004 07:51 CEST
Last Modified:              09-30-2004 07:51 CEST
======================================================================
Summary:                    Experimental feature for dual codecs produce choppy sound
Description: 
I first discovered this feature in the 2.6.9-rc2 kernel. There is a option
which allows you to enable support for dual codecs in the cs-46xx driver.
I have a Turtle Beach Santa Cruz card and it does come with dual codecs
(CS 4297A-JQ and CS 4294-JQ) and a dsp (CS 4630). If the alsa driver is
compiled with support for dual codecs the sound produced is often choppy
and way bellow ~90dB SNR (specs provided by the manufacturer and verified
by several reviewers). 
However, if the alsa driver is compiled without the experimental code and
support for only one codec the sound problems disapear compleatelly.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 07:51 cgdef          New Bug                                      
09-30-04 07:51 cgdef          Distribution              => Gentoo          
09-30-04 07:51 cgdef          Kernel Version            => 2.6.9-rc2       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
