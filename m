From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000756]: ASRock k7vt4a+ with CMedia CMI9761 no mixer!
Date: Wed, 29 Dec 2004 01:18:12 +0100
Message-ID: <3d1eddd4126e65dea0424cd799393b89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 154732D6
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 01:18:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=756> 
======================================================================
Reported By:                wschrep
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   756
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian/knoppmyth
Kernel Version:             2.6.10
======================================================================
Date Submitted:             12-29-2004 01:15 CET
Last Modified:              12-29-2004 01:18 CET
======================================================================
Summary:                    ASRock k7vt4a+ with CMedia CMI9761 no mixer!
Description: 
Well on the website it states I have this chip:
CMedia CMI9761 6 channel AC'97 audio codec

When I do an lsmod I get this: 
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)

So I use the via82xx alsa sound driver module

I get sound but when I use the mixer settings only mute works I cannot
change the levels of the audio output neither master or pcm changes
anything.

I did have to use the 1.0.4 drivers instead of 1.0.5 release because of
compilation bug see other bugreport. The libs and utils from version 1.0.4
and 1.0.5 compile without problems but with neither can I get the controls
to work.


======================================================================

----------------------------------------------------------------------
 rlrevell - 12-29-04 01:18 
----------------------------------------------------------------------
Because this codec does not have a master volume control in the hardware. 
Please, check the alsa-user and alsa-devel archives before filing a bug
report!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 01:15 wschrep        New Issue                                    
12-29-04 01:15 wschrep        Distribution              => debian/knoppmyth
12-29-04 01:15 wschrep        Kernel Version            => 2.6.10          
12-29-04 01:18 rlrevell       Note Added: 0002989                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
