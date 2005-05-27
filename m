From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001113]: application crash
Date: Fri, 27 May 2005 12:12:53 +0200
Message-ID: <612d07ef925c30c39b0c6d0802d8c458@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CBD6220D
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 12:12:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1113> 
======================================================================
Reported By:                Yota_VGA
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1113
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.8-gentoo-r9
======================================================================
Date Submitted:             05-16-2005 19:52 CEST
Last Modified:              05-27-2005 12:12 CEST
======================================================================
Summary:                    application crash
Description: 
Some applications crash when i listen a wave with aplay (and in some other
circostances, i've not be tested very well), like as xmms (when I use the
alsa plugin and I play a song) and alsamixer.
======================================================================

----------------------------------------------------------------------
 Stephan Wurm - 05-27-05 12:12 
----------------------------------------------------------------------
I can confirm that problem.

Since alsa version 1.0.8 I have recognized the same behaviour. Xmms
crashes everytime I start playing a soundfile with the alsa-plugin
choosen.
Other programs seem to have no problems. Maybe it's just a bug in Xmms'
output plugin, because all other programs run nice with Alsa...

PS: I run a 2.6.11.6 kernel on Gentoo with a "SB Live! 5.1 digital"
(emu10k1)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-16-05 19:52 Yota_VGA       New Issue                                    
05-16-05 19:52 Yota_VGA       Distribution              => gentoo          
05-16-05 19:52 Yota_VGA       Kernel Version            => 2.6.8-gentoo-r9 
05-27-05 12:12 Stephan Wurm   Note Added: 0004745                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
