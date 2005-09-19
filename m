From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000882]: Sound stops working in two scenarios with snd-via82xx module
Date: Mon, 19 Sep 2005 10:00:41 +0200
Message-ID: <ea6c7ac79d5e478968c525171623b1b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8B5C147
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:00:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=882> 
======================================================================
Reported By:                rob
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   882
Category:                   PCI - via82xx
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 9
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-03-2005 18:59 CET
Last Modified:              09-19-2005 10:00 CEST
======================================================================
Summary:                    Sound stops working in two scenarios with
snd-via82xx module
Description: 
Sound normally works fine, but we have problems a large percentage of the
time when booting after a day or two of the systems being off, or less
frequently if I unplug/replug or turn on/off amplified speakers.  It seems
to vary from machine to machine even with identical hardware.

This is a major annoyance for us as we have many of these systems which
we're trying to use in an educational setting with audio.  We can work
around it, but it's not ideal.  If only it had showed up in our initial
testing!


======================================================================

----------------------------------------------------------------------
 rob - 02-04-05 18:29 
----------------------------------------------------------------------
"Sound stops working" means I hear silence.  If I turn up the speakers
really loud I hear a hum/growling sound.

When this happens I don't see any errors anywhere either from apps or the
kernel and the modules are still loaded, at least in the second scenario. 
So far I haven't been able to verify this on the first scenario, since it
is harder to reproduce where I can work on the system.

I'm using xine to play video with audio with either the alsa or OSS xine
driver (via alsa) with the same results.

----------------------------------------------------------------------
 jdthood - 09-19-05 10:00 
----------------------------------------------------------------------
rob: Do you have anything new to report about this problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 18:59 rob            New Issue                                    
02-03-05 18:59 rob            Distribution              => Redhat 9        
02-03-05 18:59 rob            Kernel Version            => 2.4.22          
02-04-05 13:08 tiwai          Note Added: 0003500                          
02-04-05 18:29 rob            Note Added: 0003513                          
09-19-05 10:00 jdthood        Note Added: 0006280                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
