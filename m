From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001827]: cannot set rate to 44100 Hz
	with full duplex
Date: Sat, 22 Jul 2006 05:20:15 +0200
Message-ID: <0bbbcc84e4f90dc0a5d4603fa8049b86@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1F051AC
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 05:20:15 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1827> 
======================================================================
Reported By:                mdeboer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1827
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-07-2006 11:12 CET
Last Modified:              07-22-2006 05:20 CEST
======================================================================
Summary:                    cannot set rate to 44100 Hz with full duplex
Description: 
I try to run the alsa-lib/test/latency.c test, and it exits with

  Rate doesn't match (requested 44100Hz, get 0Hz)
  Unable to set parameters for playback stream: Invalid argument

If I force the application to continue at this point (commenting the
return -EINVAL; line), it seems to work ok. But what I find strange is
that the exact rates for I/O are not identical:

  Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
  Its setup is:
    stream       : PLAYBACK
    ...
    exact rate   : 44101 (1445100000/32768)
    ...
  Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
  Its setup is:
    stream       : CAPTURE
    ...
    exact rate   : 44099.8 (1572864000/35666)
    ...

======================================================================

----------------------------------------------------------------------
 Raymond - 07-22-06 05:20 
----------------------------------------------------------------------
It seem that supported rates are not integer, just fraction

static struct snd_ratnum es1371_adc_clock = {
	.num = 48000 << 15,
	.den_min = 32768, 
	.den_max = 393216,
	.den_step = 1,
};

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-07-06 11:12 mdeboer        New Issue                                    
07-22-06 05:20 Raymond        Note Added: 0011165                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
