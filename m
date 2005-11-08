From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001534]: Mixer channel problems
Date: Tue, 8 Nov 2005 17:48:00 +0100
Message-ID: <947b20832c77f82dd9b0368234804c05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7BF91A8
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 17:48:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1534> 
======================================================================
Reported By:                mrblur
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1534
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-08-2005 08:41 CET
Last Modified:              11-08-2005 17:48 CET
======================================================================
Summary:                    Mixer channel problems
Description: 
I'm using Acer AS5002WLMi with SiS 7012 soundcard. It works quite good,
but... unfortunately if I would like to change sound volume I have to do
it on headphones channel, master channel stereo/mona are not working.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-08-05 17:48 
----------------------------------------------------------------------
Check /proc/asound/card0/codec97#0/* file.  If your ac97 codec is C-Media
one, it's not a bug.  The codec has no volume control at all.

In such a case, as long as you use the default PCM with ALSA apps, the
softvol is enabled automatically.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 08:41 mrblur         New Issue                                    
11-08-05 08:41 mrblur         Kernel Version            => 2.6.14          
11-08-05 17:48 tiwai          Note Added: 0006628                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
