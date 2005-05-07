From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001078]: intel8x0 does not work on any (?) 2.6 kernel
Date: Sat, 7 May 2005 09:45:11 +0200
Message-ID: <af977ec05b5a2fc270e8ba1973d83cb1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 01B62226
	for <alsa-devel@alsa-project.org>; Sat,  7 May 2005 09:45:11 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1078> 
======================================================================
Reported By:                columbo
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   1078
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Slackware Linux 10.1
Kernel Version:             2.6.11.7
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-26-2005 21:29 CEST
Last Modified:              05-07-2005 09:45 CEST
======================================================================
Summary:                    intel8x0 does not work on any (?) 2.6 kernel
Description: 
After compilation of ALSA drivers, libs, utilities, and after alsaconf ALSA
modules loads correctly, they are visible in lsmod and so on, but all
programs can't see sound card, /dev/dsp and so on. With kernels 2.4.x
everything is OK.
======================================================================

----------------------------------------------------------------------
 gem7 - 05-06-05 19:04 
----------------------------------------------------------------------
> This means snd-intel8x0m is loading. 

Sure, that time.  As I said, I have tried it w/ and w/o intel8x0m and
loading the 2 intel drivers in different order.  Just to be sure I just
deleted the intel8x0m
module and did a cold reboot.  Same results.

> Are you sure, you don't have it compiled in kernel ?

Notice the modules was 1.0.9rc3?  No kernel has that yet.

Here is a fragment of /proc/config.gz:

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#


And here is my lsmod:

~# lsmod
Module                  Size  Used by
snd_intel8x0           29248  0 
snd_ac97_codec         79996  1 snd_intel8x0
snd_pcm                80004  2 snd_intel8x0,snd_ac97_codec
snd_timer              21124  1 snd_pcm
snd                    45796  4
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          7684  2 snd_intel8x0,snd_pcm

All the rest of my kernel is compiled in, not modules.

----------------------------------------------------------------------
 gem7 - 05-06-05 20:24 
----------------------------------------------------------------------
I have it working now.  Yes, the problem was the intel8x0m module. 
Removeing it
with modproebe -r is not enough to undo it's damage.  Only a power off
cold boot got my system to where if I only loaded the intel8x0, and not
intel8x0m module that things would work.  Thanks for pushing me to try
some more permutations of that.

Now the core problem remains, what broke intel8x0m after ALSA 1.0.4?  It
used to not break the intel8x0.  I can understand the intel8x0m not
working on my laptop but loading it shold not break other related
subsystems.  If it is not possible to fix it surely needs an obvious
warning in the doc, if not at boot time.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-05 21:29 columbo        New Issue                                    
04-26-05 21:29 columbo        Distribution              => Slackware Linux 10.1
04-26-05 21:29 columbo        Kernel Version            => 2.6.11.7        
04-29-05 21:06 columbo        Issue Monitored: columbo                     
05-06-05 08:50 gem7           Note Added: 0004590                          
05-06-05 08:59 pzad           Note Added: 0004591                          
05-06-05 09:00 pzad           Note Added: 0004592                          
05-06-05 09:13 gem7           Note Added: 0004593                          
05-06-05 09:33 pzad           Note Added: 0004594                          
05-06-05 19:04 gem7           Note Added: 0004595                          
05-06-05 20:24 gem7           Note Added: 0004596                          
05-07-05 09:45 jdthood        Status                   new => resolved     
05-07-05 09:45 jdthood        Resolution               open => not an issue
05-07-05 09:45 jdthood        Assigned To               => jdthood         
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
