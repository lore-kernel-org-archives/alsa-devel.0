From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001455]: emu10k1: PCM through digital out cuts off after playing AC3
Date: Sun, 25 Sep 2005 11:45:34 +0200
Message-ID: <4919ae93bd536e41da1ee1349dab3842@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 13FC9189
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 11:45:34 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1455> 
======================================================================
Reported By:                eradicator
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1455
Category:                   PCI - emu10k1
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-25-2005 11:45 CEST
Last Modified:              09-25-2005 11:45 CEST
======================================================================
Summary:                    emu10k1: PCM through digital out cuts off after
playing AC3
Description: 
I first noticed this back around 1.0.0 and possibly back in the 0.9.x as
well, but I can't quite remember if it ever worked for me.  I've had the
problem on x86 and x86_64 with sblive, sblive5.1, audigy, and audigy2
cards using the livedrive and livedrive2 (both coax and optical digital
out).

The problem is that raw PCM out works sometimes, but not others.  Using
the ac3 passthrough still works when playing a movie through mplayer/xine,
but after the movie finishes, PCM is not output.  The first time I noticed
this, I was able to workaround the broblem by disabling raw pcm output (so
it's definitely not a problem with my sound system), but now neither raw
nor processed will output via coax or optical outs through the livedrive. 
I can still hear the audio fine through the analog out.  Additionally, I
can play AC3 just fine through mplayer or xine.  Rebooting does not
correct the situation.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 11:45 eradicator     New Issue                                    
09-25-05 11:45 eradicator     Distribution              => Gentoo          
09-25-05 11:45 eradicator     Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
