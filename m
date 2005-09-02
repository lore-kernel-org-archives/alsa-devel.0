From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001387]: Modem problem
Date: Fri, 2 Sep 2005 23:58:48 +0200
Message-ID: <e4588fdc2acd1183cf1d5ad99caa9f4c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 557D5171
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 23:58:48 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1387> 
======================================================================
Reported By:                kzelma
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1387
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11, 2.6.12, 2.6.13
======================================================================
Date Submitted:             09-01-2005 14:54 CEST
Last Modified:              09-02-2005 23:58 CEST
======================================================================
Summary:                    Modem problem
Description: 
I found the problem with the module snd-intel8x0m.ko - modem support
particulary. I use on my laptop slmodemd ver.2.9.10 with alsa support -
http://www.smlink.com. Slmodemd works fine with kernel 2.6.9 - witout any
problem. With te kernels: 2.6.11, 2.6.12 and 2.6.13 there is problem
working with modem. Typical answer from the kppp or from wvdial is 'NO
DIALTONE". 

The solution for me was so: I compiled kernel 2.6.13 with the source code
of intel8x0m.c from 2.6.9 kernel and the modem started working. (During
compilation was few warnings.) 

Of course, during testing snd-intel8x0m is loaded.

The laptop is Toshiba Tecra S1 and  lspci -v shows:

00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
Modem Controller (rev 03) (prog-if 00 [Generic])
    Subsystem: Toshiba America Info Systems: Unknown device 0001
    Flags: bus master, medium devsel, latency 0, IRQ 11
    I/O ports at e200 [size=256]
    I/O ports at e300 [size=128]
    Capabilities: [50] Power Management version 

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 14:54 kzelma         New Issue                                    
09-01-05 14:54 kzelma         Distribution              => Fedora Core 3   
09-01-05 14:54 kzelma         Kernel Version            => 2.6.11, 2.6.12,
2.6.13
09-02-05 19:37 tiwai          Category                 PCI - intel8x0 => PCI -
intel8x0m
09-02-05 23:58 sashak         Status                   new => assigned     
09-02-05 23:58 sashak         Assigned To               => sashak          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
