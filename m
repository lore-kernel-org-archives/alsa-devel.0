From: noreply@alsa-project.org
Subject: [ALSA - driver 0000186]: rear, iec958, and center lfe missing
Date: Fri, 16 Jul 2004 11:58:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716095828.DD62326008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 38625254
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 11:58:29 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000186
======================================================================
Reported By:                epyon
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     186
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.4-gentoo-r1
Resolution:                 fixed
======================================================================
Date Submitted:             04-05-2004 05:28 CEST
Last Modified:              07-16-2004 11:58 CEST
======================================================================
Summary:                    rear, iec958, and center lfe missing
Description: 
With 1.0.4, I can not play multiple sounds at once like with 1.0.3 and I'm
missing rear, iec958, and center lfe. 
Also, in 1.0.3, in alsamixer, the chip listed was Cirrus Logic CS4297A rev
4,Cirrus Logic CS4294 rev 5 and in 1.0.4 it's only Cirrus Logic CS4297A
rev 4. 

======================================================================

----------------------------------------------------------------------
 tiwai - 04-14-2004 15:18 CEST 
----------------------------------------------------------------------
CS46xx.conf has rear, surround40 and iec958 definitions.
no center/lfe, though.

i suspect the driver doesn't support the surround and/or spdif
on your board indeed.

----------------------------------------------------------------------
 epyon - 04-14-2004 20:14 CEST 
----------------------------------------------------------------------
Ok but thats not my main problem. With this version of ALSA I can only get
one sound playing at a time when with the older versions I could have
multiple sounds at once.

----------------------------------------------------------------------
 tiwai - 04-16-2004 11:51 CEST 
----------------------------------------------------------------------
did you enabled CONFIG_CS46XX_NEW_DSP kenrel config?
it needs also CONFIG_EXPERIMENTAL.

----------------------------------------------------------------------
 epyon - 04-16-2004 16:01 CEST 
----------------------------------------------------------------------
Um thats a good question. I'm not sure what the alsa gentoo ebuild
selected. I have to check into that.

----------------------------------------------------------------------
 JStevens - 05-01-2004 02:35 CEST 
----------------------------------------------------------------------
I am using Fedora Core 1 with the stock kernel (2.4.22-1.2115.nptl) and am
having the same problems that are listed. The 1.0.3 drivers have the
IEC958 and surround mixing in alsamixer, but are missing from 1.0.4.

My card's spdif out is supported in the 1.0.1 and 1.0.3 versions, and I
don't have enough info to say what's different from 1.0.3 and 1.0.4 that
they don't show up other than what the previous bugtracker listed.

----------------------------------------------------------------------
 Picomp314 - 07-05-2004 22:39 CEST 
----------------------------------------------------------------------
i also can not locate the iec958 defs. running alsa 1.0.4
can not play multiple sounds (i tried software mixing, so far to no
avail)
i really would like to be able to use the Rca and Toslink outputs on the
card, right now i have to use headphones

i looked in the /etc/asound.state file and tried to change some settings
for the IEC958 output, but it also did not work.

Running FC2 on custom 2.6.7 kernel; not using New DSP; will try to compile
with New DSP enabled

----------------------------------------------------------------------
 Picomp314 - 07-10-2004 16:10 CEST 
----------------------------------------------------------------------
ok i fixed this problem, i patched kernel-2.6.7 with the latest alsa-kernel
patch
i recompiled and rebooted
all the missing entries are now back in alsamixer
haven't actually tested the sound through the digital outputs yet, i
report back later

----------------------------------------------------------------------
 Picomp314 - 07-15-2004 02:05 CEST 
----------------------------------------------------------------------
the sound from the digital outputs works flawlessly indeed

----------------------------------------------------------------------
 tiwai - 07-16-2004 11:58 CEST 
----------------------------------------------------------------------
Ok now closing this bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-05-04 05:28 epyon          New Bug                                      
04-05-04 05:28 epyon          Distribution              => Gentoo          
04-05-04 05:28 epyon          Kernel Version            => 2.6.4-gentoo-r1 
04-14-04 15:18 tiwai          Bugnote Added: 0000805                       
04-14-04 20:14 epyon          Bugnote Added: 0000809                       
04-16-04 11:51 tiwai          Bugnote Added: 0000831                       
04-16-04 16:01 epyon          Bugnote Added: 0000839                       
05-01-04 02:35 JStevens       Bugnote Added: 0000986                       
05-01-04 02:35 JStevens       Bug Monitored: JStevens                      
07-05-04 22:39 Picomp314      Bugnote Added: 0001383                       
07-10-04 16:10 Picomp314      Bugnote Added: 0001402                       
07-15-04 02:05 Picomp314      Bugnote Added: 0001423                       
07-16-04 11:58 tiwai          Bugnote Added: 0001442                       
07-16-04 11:58 tiwai          Assigned To               => tiwai           
07-16-04 11:58 tiwai          Resolution               open => fixed       
07-16-04 11:58 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
