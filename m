From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002088]: Too many xruns with jack in
	full-duplex mode.
Date: Mon, 31 Jul 2006 08:40:57 +0200
Message-ID: <982546049bbf84a38892a998b5637c47@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5831118C
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 08:40:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2088> 
======================================================================
Reported By:                AnarSoul
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2088
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.2
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             05-01-2006 02:10 CEST
Last Modified:              07-31-2006 08:40 CEST
======================================================================
Summary:                    Too many xruns with jack in full-duplex mode.
Description: 
Hundrends of xruns with JACK (jackit.sf.net) in fullduplex mode with
snd-ca0106 (audigy se). But my onboard sound (intel-8x0) works fine.

Please, do something with this annoying thing :(

======================================================================

----------------------------------------------------------------------
 Raymond - 07-11-06 06:10 
----------------------------------------------------------------------
Post the output when you start running jackd

----------------------------------------------------------------------
 sergiusz - 07-31-06 08:40 
----------------------------------------------------------------------
Exactly the same issue here, playback-only mode works. Here ist the jackd
output:

08:40:09.609 JACK is starting...
08:40:09.611 /usr/bin/jackd -R -dalsa -dhw:0 -r48000 -p256 -n2 -S
08:40:09.620 JACK was started with PID=5579 (0x15cb).
jackd 0.100.0
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 48000
creating alsa driver ... hw:0|hw:0|256|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 256 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
08:40:11.833 Server configuration saved to "/home/sur/.jackdrc".
08:40:11.836 Statistics reset.
08:40:11.841 Client activated.
08:40:11.844 Audio connection change.
08:40:11.856 Audio connection graph change.
08:40:11.914 XRUN callback (1).
08:40:13.880 XRUN callback (198 skipped).
jackd watchdog: timeout - killing jackd
zombified - calling shutdown handler
08:40:15.096 Shutdown notification.
08:40:15.098 Client deactivated.
08:40:15.103 JACK was stopped successfully.
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-01-06 02:10 AnarSoul       New Issue                                    
05-01-06 02:10 AnarSoul       Distribution              => Slackware 10.2  
05-01-06 02:10 AnarSoul       Kernel Version            => 2.6.16.1        
05-01-06 02:11 AnarSoul       Issue Monitored: AnarSoul                    
05-01-06 02:12 AnarSoul       Note Added: 0009552                          
07-11-06 06:10 Raymond        Note Added: 0010966                          
07-31-06 08:40 sergiusz       Note Added: 0011337                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
