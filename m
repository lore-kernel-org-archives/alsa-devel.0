From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000498]: audigyls plays sound 1.5 times fast
Date: Mon, 13 Sep 2004 15:40:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913134006.3831712009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8BDAB178
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 15:40:06 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000498
======================================================================
Reported By:                andii
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Bug ID:                     498
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.2
Kernel Version:             linux-2.6.7-gentoo-r11
======================================================================
Date Submitted:             09-12-2004 06:23 CEST
Last Modified:              09-13-2004 15:40 CEST
======================================================================
Summary:                    audigyls plays sound 1.5 times fast
Description: 
audigyls plays sound 1.5 times faster then it should.

Example:
andy@gordon andy $ time plaympeg 01-radio_moscow.mp3
01-radio_moscow.mp3: MPEG audio stream
        Audio MPEG-1 Layer 3 128kbit/s 44100Hz stereo
        Size: 404165
        Total time: 25.260312

real    0m17.163s
user    0m0.374s
sys     0m0.015s

1st thought it might just be mp3s but also wav files and games,
everything!

Note: I downloaded and installed alsa-lib, alsa-drivers and alsa-utils by
hand, I did not use gentoo's emerge.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:40 CEST 
----------------------------------------------------------------------
Does it happen with 48kHz samples?
Did you test OSS apps or ALSA native apps?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-12-04 06:23 andii          New Bug                                      
09-12-04 06:23 andii          Distribution              => Gentoo 2004.2   
09-12-04 06:23 andii          Kernel Version            => linux-2.6.7-gentoo-r11
09-13-04 15:40 tiwai          Bugnote Added: 0001746                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
