From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002320]: Almost no sound on Asus
	laptop with Realtek ALC861
Date: Mon, 31 Jul 2006 19:16:17 +0200
Message-ID: <6f48d4d4b4c60700b1a45265d1a7beb7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 56C13106
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 19:16:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2320> 
======================================================================
Reported By:                mario_7
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2320
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             kernel-2.6.17.7
======================================================================
Date Submitted:             07-31-2006 00:41 CEST
Last Modified:              07-31-2006 19:16 CEST
======================================================================
Summary:                    Almost no sound on Asus laptop with Realtek ALC861
Description: 
I have almost no sound on my Asus A6RP-AP002 laptop. Almost because it can
be said that the sound is... 

But let me start from the beginning. 

I tried many things to get sound on my laptop. I tried alsa drivers from
realtek website, alsa 1.0.11 and latest drivers from HG. Alsa 1.0.11
examined my chipset properly - ALC861, other found it as ALC660. None of
them were working (no sound). 

2 days ago I downloaded latest 2.6.17.7 kernel and compiled it with
included alsa drivers (1.0.11rc4), sound chipset was examined properly,
but still nothing... 

I started using various options with snd-hda-intel module. 
Built-in speakers are not working with any of options
(model=3stack/3stack-dig/6stack-dig) but headphones are almost working...

With model=3stack I can hear sound with headphones but only when I plug
them into line-in jack. The sound is very very quiet and it's also with
crackling noise... (Volume is set to maximum level). 

With model=6stack-dig situation is almost the same, except that the
headphones are plugged into headphone jack and the same sound can be heard
in only one headphone (the second one is just silent).

The built-in microphone is working quite well (there is only not too loud
squeal during records).

Other options like posotion_fix=1/2 or single_cmd=1 are not changing
anything (with posotion_fix=2 Ubuntu is not loading, X hangs when the
login sound should be played).  

If anyone would like to help me and need any other information than those
placed in this post and in attached file, just ask for them and I'll
answer :)

Hope someone smart will know how to fix everything :)
======================================================================

----------------------------------------------------------------------
 tiwai - 07-31-06 17:47 
----------------------------------------------------------------------
Exactly.  As default, the driver reads the pin configuration set up by BIOS
and assigns the basic mixer elements according to that unless the
predefined configuration is given in the driver code.  Unfortunately, in
many cases, the BIOS setup is broken, and in other many cases, the
auto-configuration isn't perfectly matching with the actual state.  In
such a case, we have to write up the proper support code.

BTW, the datasheet of ALC861 is available on Realtek's web site.

----------------------------------------------------------------------
 michaldemin - 07-31-06 19:16 
----------------------------------------------------------------------
I had the datasheet for a long time, i just never had a look in it. The
tricky part is to determine which jack is connected to which port
Would the Pin sense have any use ? I mean there could be utility to chceck
which port is connected, and it would give me much less options to try.
And also the impendance measured could be used to recognize some devices
as well.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-06 00:41 mario_7        New Issue                                    
07-31-06 00:41 mario_7        File Added: info                             
07-31-06 00:41 mario_7        Kernel Version            => kernel-2.6.17.7 
07-31-06 11:12 michaldemin    Note Added: 0011341                          
07-31-06 13:59 michaldemin    Note Edited: 0011341                         
07-31-06 16:44 michaldemin    Note Edited: 0011341                         
07-31-06 17:47 tiwai          Note Added: 0011344                          
07-31-06 19:16 michaldemin    Note Added: 0011346                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
