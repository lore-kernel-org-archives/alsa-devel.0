From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000711]: Sound still bad with alsa on sb audigyls / ca0106
Date: Tue, 7 Dec 2004 21:53:36 +0100
Message-ID: <95b43cc0fbd3fab2ea281324763a6c73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7C1B41B5
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 21:53:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=711> 
======================================================================
Reported By:                scorpion77
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   711
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-1.6_FC2custom
======================================================================
Date Submitted:             12-07-2004 18:12 CET
Last Modified:              12-07-2004 21:53 CET
======================================================================
Summary:                    Sound still bad with alsa on sb audigyls / ca0106
Description: 
Sound is choppy and at wrong speed with both the snd-audigyls from alsa
1.0.7 and snd-ca0106 from alsa CVS. CVS seems worse, which bugs me since
last bug report was closed woth a "Use snd-ca0106 from CVS remark"!
Workaround seems to select (Threaded)OSS as artsd backend instead of Alsa.
Esd as artsd backend only works / fixes things in 1.0.7, it crashes when
the CVS version is used.
======================================================================

----------------------------------------------------------------------
 scorpion77 - 12-07-04 21:40 
----------------------------------------------------------------------
Well should have said 'kind of bugs me' then ;) You have to do quite some
work just to find out it's probably wise to just stick with the 1.0.7
snd-audigyls driver because it works better and there doesn't seem to be
much changes when it comes to features.

Most important question would be, is this work in progress and if it is,
when can I / we expect decent support for this chip, soon or rather on the
longterm? I can still return the thing and get a better card u know ;)

----------------------------------------------------------------------
 jcdutton - 12-07-04 21:53 
----------------------------------------------------------------------
You don't really give me much information do you.
How about some useful info, like:
cat /proc/asound/card0/cards
cat /proc/asound/version
etc.

I suspect you are trying to play a file at 44.1khz, and the sound card
does not support that rate(hardware limitation), so alsa-lib tries to
resample 44.1khz to 48khz.
That, together with badly written applications that you might be using is
bound to fail.
If the media file plays fine in xine, this is not an alsa bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:12 scorpion77     New Issue                                    
12-07-04 18:12 scorpion77     Distribution              => Fedora Core 2   
12-07-04 18:12 scorpion77     Kernel Version            => 2.6.9-1.6_FC2custom
12-07-04 20:24 rlrevell       Note Added: 0002764                          
12-07-04 21:40 scorpion77     Note Added: 0002765                          
12-07-04 21:53 jcdutton       Note Added: 0002766                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
