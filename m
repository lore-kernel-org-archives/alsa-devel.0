From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Thu, 31 Mar 2005 11:34:51 +0200
Message-ID: <e48bd521e635b0fe7258c581fe8d822d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 64BAE254
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 11:34:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
======================================================================
Reported By:                Osiris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1025
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             03-30-2005 22:50 CEST
Last Modified:              03-31-2005 11:34 CEST
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 mjander - 03-31-05 11:34 
----------------------------------------------------------------------
Hi,

I need more info. What kind of computer are you using (32bits, 64bits,
x86, Sparc, x64) ? What kind other peripherals, CPU, amount of RAM,
mainboard, etc ?

Could also please indicate what kind of messages you get when your
computer gets that kernel panic ? I know you may need to write it on
paper, but i neeed that info to further assist you. Please be accurate on
that.

Another thing: Are you 100% sure your computer hardware is OK ? Does it
work flawless without the aureal soundcard ? Does the aureal soundcard
work with kernel 2.6.10 for example (which i know should work OK) ? Either
your soundcard or computer may be broken, please proof/discard that cases
first.
Thanks.

Best Regards
Manuel Jander

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 22:50 Osiris         New Issue                                    
03-30-05 22:50 Osiris         Distribution              => Debian          
03-30-05 22:50 Osiris         Kernel Version            => 2.6.11.6        
03-31-05 11:34 mjander        Note Added: 0004278                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
