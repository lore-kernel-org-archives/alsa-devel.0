From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: hdspmixer vs cvs
Date: Fri, 07 May 2004 13:56:16 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <409B16F0.8070601@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In the latest cvs snapshot the hdspmixer app returns this error when I 
try to use it.

hdspmixer

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for HDSP cards :
Card 0 : C-Media PCI CMI8738 (model 37) at 0x9800, irq 10
Card 1 : RME Hammerfall DSP + Multiface at 0xe9000000, irq 5
Multiface found !
1 Hammerfall DSP card found.
hdspmixer: async.c:56: snd_async_handler: Assertion `siginfo->si_code == 
SI_SIGI
O' failed.
Aborted



-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
