From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002320]: Almost no sound on Asus
	laptop with Realtek ALC861
Date: Sat, 5 Aug 2006 13:26:24 +0200
Message-ID: <3b09a818db955d98113854b8cf3800a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D727A16B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:26:24 +0200 (MEST)
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
Last Modified:              08-05-2006 13:26 CEST
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
 michaldemin - 08-03-06 15:41 
----------------------------------------------------------------------
Mine isnt Asus, it is the one known as uniwill e31ei1 (made some chineese
producer for various resellers).

----------------------------------------------------------------------
 mario_7 - 08-05-06 13:26 
----------------------------------------------------------------------
I wrote an email to Realtek... Hope someone will amswer it. :) 
Now I'm thinking about writing an email to Asus too.

The Realtek driver for Windows works fine. I don't know if it is possible
but maybe you could get some informations from that driver?

Michaldemin, does the sound you got was like mine, described in bug
report, or was it clear and good quality?

Tiwai, if there would be some HowTo or HandBook... I know nothing about
programming drivers but if it is similar to creating PHP scripts, then
maybe I would be able to do something... :)

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
07-31-06 23:52 mario_7        Note Added: 0011354                          
08-03-06 14:58 michaldemin    Note Added: 0011401                          
08-03-06 15:04 tiwai          Note Added: 0011402                          
08-03-06 15:41 michaldemin    Note Added: 0011403                          
08-05-06 13:26 mario_7        Note Added: 0011428                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
