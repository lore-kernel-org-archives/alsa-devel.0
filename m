From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002088]: Too many xruns with jack in
	full-duplex mode.
Date: Tue, 11 Jul 2006 06:10:25 +0200
Message-ID: <5901953811dc6ce7a955b11949bc3b9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C56C8233
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 06:10:29 +0200 (MEST)
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
Last Modified:              07-11-2006 06:10 CEST
======================================================================
Summary:                    Too many xruns with jack in full-duplex mode.
Description: 
Hundrends of xruns with JACK (jackit.sf.net) in fullduplex mode with
snd-ca0106 (audigy se). But my onboard sound (intel-8x0) works fine.

Please, do something with this annoying thing :(

======================================================================

----------------------------------------------------------------------
 AnarSoul - 05-01-06 02:12 
----------------------------------------------------------------------
P.S. Jack works fine in capture-only or playback-only mode, but I need
full-duplex :)

----------------------------------------------------------------------
 Raymond - 07-11-06 06:10 
----------------------------------------------------------------------
Post the output when you start running jackd

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-01-06 02:10 AnarSoul       New Issue                                    
05-01-06 02:10 AnarSoul       Distribution              => Slackware 10.2  
05-01-06 02:10 AnarSoul       Kernel Version            => 2.6.16.1        
05-01-06 02:11 AnarSoul       Issue Monitored: AnarSoul                    
05-01-06 02:12 AnarSoul       Note Added: 0009552                          
07-11-06 06:10 Raymond        Note Added: 0010966                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
