From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from external speakers (laptop)
Date: Wed, 22 Jun 2005 19:50:18 +0200
Message-ID: <d26f9182a7ab7a7fef43ca754944563a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F25E207
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 19:50:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14> 
======================================================================
Reported By:                user74
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
======================================================================
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              06-22-2005 19:50 CEST
======================================================================
Summary:                    No sound from external speakers (laptop)
Description: 
On my laptop (acer272xv) I can't use external output with my Creative 2.1,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000664 ac97_quirk with SIS 7012 [ALC202] don't...
======================================================================

----------------------------------------------------------------------
 wenton - 06-20-05 06:48 
----------------------------------------------------------------------
Greetings! Not sure if this hurts or helps.  I have been able to get this 
working in my laptop, but not sure about this behavior: everything appears
to 
be sound card 1 instead of 0; e.g. alsamiser -c 1 and everything works if
I use
things  like/dev/dsp1 and /dev/mixer1 and so on.  Trying to use alsamixer

without "-c 1" tells me, "no mixer elems found"  Trying to use /dev/dsp0 
et. al. seems to act like I am using a null device... device is connected
but 
has nothing physical connected to it.  I do not have another soundcard.  

However, there is a modem built into this chip (82801DB) that does not
seem to
be configured correctly; could this be causing the problem? How else can I
fix
this? I have changed the symbolic links (/dev/dsp->/dev/dsp1, 
dev/mixer->/dev/mixer1,etc.) but this seems more of a band-aid than a fix.

----------------------------------------------------------------------
 dale - 06-22-05 19:50 
----------------------------------------------------------------------
Hi wenton, do you have any more information on your configuration?
I only have /dev/dsp, not /dev/dsp0 /dev/dsp1 etc.  I am using UDEV if it
helps.

So are you saying you have actually managed to get the headphone port to
work with this configuration?

Many Thanks,

Dale

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-04 20:15 user74         New Issue                                    
01-29-04 20:15 user74         File Added: details.txt                      
01-30-04 12:44 tiwai          Note Added: 0000049                          
01-30-04 17:56 sparkyva       Note Added: 0000063                          
01-30-04 17:56 sparkyva       Issue Monitored: sparkyva                    
01-30-04 20:41 sparkyva       Note Added: 0000070                          
01-30-04 22:01 jorge2         Note Added: 0000071                          
02-02-04 19:37 jorge2         Note Added: 0000119                          
02-04-04 20:00 tiwai          Note Added: 0000165                          
02-04-04 20:01 tiwai          Note Added: 0000166                          
02-04-04 20:52 jorge2         Note Added: 0000169                          
02-04-04 20:52 jorge2         Note Added: 0000170                          
02-04-04 20:53 jorge2         Note Deleted: 0000169                        
02-05-04 13:52 matsgora       Note Added: 0000181                          
02-05-04 14:05 dale           Note Added: 0000182                          
02-26-04 13:07 rocco          Note Added: 0000347                          
02-26-04 18:16 matsgora       Note Added: 0000358                          
02-26-04 18:20 tiwai          Note Added: 0000359                          
03-01-04 10:31 dale           Note Added: 0000401                          
03-05-04 19:49 tiwai          Note Added: 0000513                          
03-05-04 20:37 jorge2         Note Added: 0000515                          
03-06-04 18:20 matsgora       Note Added: 0000520                          
03-07-04 16:30 dale           Note Added: 0000524                          
03-09-04 15:15 tiwai          Note Added: 0000547                          
03-09-04 18:12 matsgora       Note Added: 0000551                          
06-08-04 20:25 jorge2         Note Added: 0001296                          
06-15-04 15:00 mcbridematt    Note Added: 0001308                          
11-22-04 18:48 tiwai          Relationship added       has duplicate 0000664
02-02-05 14:25 dale           Note Added: 0003488                          
02-04-05 13:18 tiwai          Note Added: 0003504                          
02-04-05 13:19 tiwai          File Added: ac97-alc-fix.diff                    
02-04-05 18:03 jorge2         Note Added: 0003512                          
02-05-05 13:27 jorge2         Issue Monitored: jorge2                      
02-21-05 09:16 dale           Note Added: 0003678                          
02-23-05 09:54 dale           Issue Monitored: dale                        
06-14-05 21:20 graf_eichbaum  Issue Monitored: graf_eichbaum                    
06-20-05 06:48 wenton         Note Added: 0005093                          
06-22-05 19:50 dale           Note Added: 0005145                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
