From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001888]: MIDI external output
	occasionally freezes the machine
Date: Mon, 19 Jun 2006 15:38:36 +0200
Message-ID: <f47d70209a3ef7c82827a46cad4700dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A694E8
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jun 2006 15:38:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1888> 
======================================================================
Reported By:                pigeon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1888
Category:                   PCI - ymfpci
Reproducibility:            random
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.14.4 SMP, self-built
======================================================================
Date Submitted:             03-02-2006 09:59 CET
Last Modified:              06-19-2006 15:38 CEST
======================================================================
Summary:                    MIDI external output occasionally freezes the
machine
Description: 

Since I've upgraded my kernel from 2.4 to 2.6.14.4, I'm having random
machine freezes when using the external MIDI port on my ymf soundcard. It
can happen just by playing midi using "pmidi -p 64:0 <midi file>". It
freezes sometimes when I simply ctrl-c it. Rosegarden also suffers from
the same behavior while starting and/or stopping a playback.

My external MIDI is connected to a Yamaha digital piano.

I do not have this problem when I was using a 2.4 kernel, and a self built
alsa driver (possibly version 1.0.9).

The snd-ymfpci driver is loaded with the follow options:
mpu_port=1 fm_port=1 joystick_port=1

Thanks.

======================================================================

----------------------------------------------------------------------
 Raymond - 06-19-06 15:38 
----------------------------------------------------------------------
http://www.alsa-project.org/changes/v1-0-9--v1-0-10.txt


If you sure that midi still work on ALSA 1.0.9, you may need to find out
which patch cause the problem

http://hg-mirror.alsa-project.org/alsa-kernel?fl=25ac64e78c4c;file=pci/ymfpci/ymfpci_main.c;style=gitweb

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-06 09:59 pigeon         New Issue                                    
03-02-06 09:59 pigeon         Distribution              => Debian testing  
03-02-06 09:59 pigeon         Kernel Version            => 2.6.14.4 SMP,
self-built
06-19-06 15:38 Raymond        Note Added: 0010314                          
======================================================================
