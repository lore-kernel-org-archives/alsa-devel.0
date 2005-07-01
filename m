From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001227]: Audio output to headphone changes mapping when JACKD XRUN
Date: Sat, 2 Jul 2005 01:37:38 +0200
Message-ID: <58b7d8d56befab2b75e18f8cfb43ac7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A16E1AB
	for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2005 01:37:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1227> 
======================================================================
Reported By:                rfonseca
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1227
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3 with real time smp kernel from ccrma
Kernel Version:             2.6.10-2.1.ll.rhfc3.ccrmasmp
======================================================================
Date Submitted:             07-02-2005 01:24 CEST
Last Modified:              07-02-2005 01:37 CEST
======================================================================
Summary:                    Audio output to headphone changes mapping when JACKD
XRUN
Description: 
When running jack and there is an XRUN, the mapping of which output goes to
the headphone jack changes. For example, suppose there is an app connected
(via JACK) to playback_1 and playback_2 (controlled by mixer PCM).
Sometimes when there is an XRUN, the output will stop. Suddenly, the
output jack  (the headphones) is now fed by the surround channel. If I
connect the same application to playback_3 and playback_4, I can hear the
output, and the volume is controlled by mixer "Surround". Furhter XRUNS
will move the output to playback_5 and playback_6, and even other
combinations.
======================================================================

----------------------------------------------------------------------
 rfonseca - 07-02-05 01:37 
----------------------------------------------------------------------
I forgot to mention the soundcard is a ATI onboard with a SoundMax
chipset.
Modules loaded (relevant):

snd_seq                64272  3 snd_seq_dummy
snd_seq_device         13324  2 snd_seq_dummy,snd_seq
snd_atiixp             25568  10 
snd_ac97_codec         83064  1 snd_atiixp
snd_pcm_oss            67488  0 
snd_mixer_oss          25344  2 snd_pcm_oss
snd_pcm               111492  3 snd_atiixp,snd_ac97_codec,snd_pcm_oss
snd_timer              32004  2 snd_seq,snd_pcm
snd                    73092  29
snd_seq_dummy,snd_seq,snd_seq_device,snd_atiixp,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              13792  2 snd
snd_page_alloc         14724  2 snd_atiixp,snd_pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-05 01:24 rfonseca       New Issue                                    
07-02-05 01:24 rfonseca       Distribution              => Fedora Core 3 with
real time smp kernel from ccrma
07-02-05 01:24 rfonseca       Kernel Version            =>
2.6.10-2.1.ll.rhfc3.ccrmasmp
07-02-05 01:37 rfonseca       Note Added: 0005345                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
