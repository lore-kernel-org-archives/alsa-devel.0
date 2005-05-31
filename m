From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000148]: Master volume only controls front output
Date: Tue, 31 May 2005 18:02:10 +0200
Message-ID: <d2c75b45b817cd107dcf21e2fa2c24ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D0DD1B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:10 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=148> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   148
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux 1.4
Kernel Version:             2.6.4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-22-2004 16:06 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    Master volume only controls front output
Description: 
Setting the alsamixer Master Volume slider only controls the front two
speakers. The rear speakers have to be controlled with the Wave Surround
setting. I'm not sure whether this is an alsamixer bug or a alsa-driver
bug. If I'm wrong putting it here, sorry.

It would be very convenient to be able to control all four speakers with
the Master Volume setting and to have a Front and Rear slider to control
the front and rear speakers individually.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001063 master volume change and mute only affe...
======================================================================

----------------------------------------------------------------------
 perex - 03-23-04 16:18 
----------------------------------------------------------------------
Please, make this report for the alsa-lib project. We need to design an
abstraction layer which will provide this "expected" behaviour.

Actually, we follow the hardware and rear output is totaly independent in
case
of SB Live.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-04 16:06 wzzrd          New Issue                                    
03-22-04 16:06 wzzrd          Distribution              => Gentoo Linux 1.4
03-22-04 16:06 wzzrd          Kernel Version            => 2.6.4           
03-23-04 16:18 perex          Status                   new => resolved     
03-23-04 16:18 perex          Resolution               open => not an issue
03-23-04 16:18 perex          Assigned To               => perex           
03-23-04 16:18 perex          Note Added: 0000665                          
04-18-05 20:18 rlrevell       Relationship added       has duplicate 0001063
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
