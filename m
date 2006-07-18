From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000394]: Master/PCM don't control
	optical-spdif out
Date: Tue, 18 Jul 2006 20:23:00 +0200
Message-ID: <bab2d9b603a7929d07b42ae7e2202fa4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 49BAB199
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:23:00 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=394> 
======================================================================
Reported By:                msc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   394
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian/unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-16-2004 16:12 CEST
Last Modified:              07-18-2006 20:22 CEST
======================================================================
Summary:                    Master/PCM don't control optical-spdif out
Description: 
I can't control volume/mute with master/pcm mixer controls for spdif
out.(analog out works fine)
Only Wave Playback change volume.

======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-04 17:41 
----------------------------------------------------------------------
Master and PCM are the volume controls for AC97 codec, so they
are really independent from SPDIF.

----------------------------------------------------------------------
 pzad - 08-02-04 09:56 
----------------------------------------------------------------------
Problem is, that there isn't any control on SB Live which control spdif
volume.
If I have this card ....

----------------------------------------------------------------------
 msc - 08-02-04 10:39 
----------------------------------------------------------------------
perhaps i can help you with this problem?
i'm a programmer too and if it's possible we can try to find together this
problem.

i think the routing to/from the dsp should be the problem?
i'm not really familiar with soundcard programming, but perhaps you can
explain the minimal neccessary stuff to use/tweak some test code.

can you make a small code snipplet for testing some (dsp?) code which
change routing to/from dsp (loopback to ac97 or something like this)?

----------------------------------------------------------------------
 pzad - 08-06-04 14:51 
----------------------------------------------------------------------
I hope, new week I will release new version of ld10k1 and there will be GUI
part too. Still limited (there is not save and load of whole DSP config),
but you will by able to setup your own mixer (which can contain volume
control for spdif out too) and than save DSP dump to file and load this
dump at any time (for example at boot).

Then only problem will by master volume, because you need control analog
volume and digital volume at same time. This will be solved later.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 16:12 msc            New Issue                                    
07-16-04 16:12 msc            Distribution              => debian/unstable 
07-16-04 16:12 msc            Kernel Version            => 2.6.7           
07-16-04 16:13 msc            Issue Monitored: msc                         
07-30-04 17:41 tiwai          Note Added: 0001503                          
08-02-04 09:56 pzad           Note Added: 0001518                          
08-02-04 10:39 msc            Note Added: 0001519                          
08-06-04 14:51 pzad           Note Added: 0001539                          
01-04-05 21:57 visit0r        Issue Monitored: visit0r                     
07-18-06 20:22 pzad           Assigned To              pzad =>             
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
