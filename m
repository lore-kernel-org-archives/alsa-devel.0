From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001051]: 'Headphones', 'PCM', 'Master' control names misassigned
Date: Thu, 15 Sep 2005 16:04:52 +0200
Message-ID: <9b7e7c0ede8801ec9467dd2bb5a8ee00@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31D11178
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 16:04:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1051> 
======================================================================
Reported By:                kayandus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1051
Category:                   PCI - via82xx
Reproducibility:            N/A
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.10-5-k7
======================================================================
Date Submitted:             04-13-2005 21:16 CEST
Last Modified:              09-15-2005 16:04 CEST
======================================================================
Summary:                    'Headphones', 'PCM', 'Master' control names
misassigned
Description: 
Hello,

I bought a Targa Traveller 811 laptop a couple of months ago with an
onboard 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50) audio controller. It
works fine with the via82xx driver, but there's only one minor problem.
Let me explain my problem.

There are 3 major volume controls for me:

Master: Controls the volume of the internal laptop speaker, so when there
is a plug/earphones in my LINE IN, it changes nothing. (!!)
Headphones: Controls volume of the LINE IN, so does nothing when there is
nothing my LINE IN.
PCM: Controls both internal speaker and LINE IN, so volume goes up and
down whether im using the internal speaker or not.

Probably the problem is clear already to you. Most programs control only
Master, so when I have my laptop attached to my stereo, those programs
don't change my volume =(
I hope you guys can fix this, I suggest by making an option to exchange
Master with PCM.

Thanks in advance, Harm te Hennepe
======================================================================

----------------------------------------------------------------------
 Nafallo - 09-14-05 04:11 
----------------------------------------------------------------------
Rather than to bind Master and PCM, we should bind Master and Headphones
no? And it's not LINE IN, it's the headphonejack :-).

ac97_quirk=hp_only didn't make a difference here (Targa Visionary 811).



----------------------------------------------------------------------
 tiwai - 09-15-05 16:04 
----------------------------------------------------------------------
ac97_quirk=hp_only binds Master and Headphone volume controls.
You *must* see the difference with this option.  With this option, there
will be no longer "Headphone" control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:16 kayandus       New Issue                                    
04-13-05 21:16 kayandus       Distribution              => Ubuntu          
04-13-05 21:16 kayandus       Kernel Version            => 2.6.10-5-k7     
04-13-05 21:20 kayandus       Issue Monitored: kayandus                    
04-19-05 17:46 kayandus       Issue End Monitor: kayandus                    
04-19-05 18:26 tiwai          Note Added: 0004535                          
04-21-05 20:59 kayandus       Note Added: 0004552                          
09-14-05 04:09 Nafallo        Note Added: 0006156                          
09-14-05 04:10 Nafallo        Note Edited: 0006156                         
09-14-05 04:10 Nafallo        Issue Monitored: Nafallo                     
09-14-05 04:11 Nafallo        Note Edited: 0006156                         
09-14-05 15:45 jdthood        Summary                  Master <--> PCM =>
'Headphones', 'PCM', 'Master' control names misassigned
09-14-05 15:45 jdthood        Description Updated                          
09-15-05 16:04 tiwai          Note Added: 0006211                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
