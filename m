From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000853]: Clicks or pops are produced in Griffin USB iMic PCM output
Date: Thu, 15 Sep 2005 16:14:08 +0200
Message-ID: <2af3a5b3fc98fbbb3c87dfd62677a959@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D95A1178
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 16:14:08 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=853> 
======================================================================
Reported By:                vtowel
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   853
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10-gentoo-r2, with low latency patch
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-28-2005 08:28 CET
Last Modified:              09-15-2005 16:14 CEST
======================================================================
Summary:                    Clicks or pops are produced in Griffin USB iMic PCM
output
Description: 
I've been spending the longest time trying to figure out why FluidSynth has
been producing these inconsistent clicks while I play MIDI through it. I
finally determined that this behaviour is not specific to FluidSynth, but
to my USB iMic sound card, since the problem does not occur when I
configure FluidSynth to use my internal sound card. I am also able to hear
these clicks through the iMic by just playing an MP3 through them,
although it's not as frequent. It seems that the frequency of the clicks
is dependent on my CPU load; the more I stress my system, the easier it is
to hear these clicks/pops. But it's difficult to determine whether there's
a direct relationship there or not, because this behaviour is so
inconsistent. But I can always cause the clicks to happen within at most a
couple minutes, especially if I'm playing MIDI through FluidSynth.
======================================================================

----------------------------------------------------------------------
 vtowel - 09-15-05 15:48 
----------------------------------------------------------------------
Actually I found out that this also happened in Windows. I asked Griffin to
replace my iMic, which doesn't exhibit this problem quite as often (though
it still does occasionally - it's probably just crappy hardware). You can
close this.

----------------------------------------------------------------------
 jdthood - 09-15-05 16:14 
----------------------------------------------------------------------
Thanks for the info.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 08:28 vtowel         New Issue                                    
01-28-05 08:28 vtowel         Distribution              => Gentoo          
01-28-05 08:28 vtowel         Kernel Version            => 2.6.10-gentoo-r2,
with low latency patch
09-15-05 15:19 jdthood        Note Added: 0006208                          
09-15-05 15:48 vtowel         Note Added: 0006209                          
09-15-05 16:14 jdthood        Status                   assigned => resolved
09-15-05 16:14 jdthood        Resolution               open => not an issue
09-15-05 16:14 jdthood        Note Added: 0006213                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
