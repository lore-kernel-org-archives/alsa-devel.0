From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Tue, 11 Apr 2006 18:54:38 +0200
Message-ID: <8a9eb23981a0bfa225d1501751889e6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E45FD166
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 18:54:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047> 
======================================================================
Reported By:                alien999999999
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1047
Category:                   PCI - au88x0
Reproducibility:            sometimes
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.6.7
======================================================================
Date Submitted:             04-12-2005 20:43 CEST
Last Modified:              04-11-2006 18:54 CEST
======================================================================
Summary:                    module hangs at seemingly random times
Description: 
sometimes i start playing a song, and it starts playing a few second or so
and hangs, then i kill the application and modprobe -r all sound modules
and modprobe them again to make it work again.

BUT: sometimes not only that happens, but also when i try to kill the apps
it will not kill. when that happens, all kill, killall, top, ps aux
commands hang at the command line and cannot be killed by CTRL-C or
otherwise, i have been able to see that when i stopped my display
managener I did an lsmod and it gave something like this:

snd-pcm-oss            59752  11
snd-mixer-oss          20480  1 snd-pcm-oss
snd-au8810             43760  220
snd-ac97-codec         83408  1 snd-au8810
snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
snd-page-alloc         10384  1 snd-pcm
gameport                3840  1 snd-au8810
snd-mpu401-uart        11904  1 snd-au8810


as you can see the snd-au8810 module seem to have an impossible number of
"dependencies" (i think has to do with the number of unclosed sound-apps
trying to be played; this could be since gaim is programmed to execute an
'aplay %s')

i've had this major crash below only 3 times; and the logs didn't detect
anything specific at the time. the only thing the logs mentioned at that
time was an ntpd sync going on; so the only thing i can think of is that
at a certain moment when a sync is going on, some kind of lock is holding
cause this to happen... the only thing that i can do to fix this is
reset...

it is interesting to note that i also have an snd-emu10k1 as second card,
which never gave problems like this, and i am always able to "modprobe -r
snd-emu10k1" ...
======================================================================

----------------------------------------------------------------------
 Raymond - 04-11-06 18:36 
----------------------------------------------------------------------
There are may fuctions called by vortex_core_init(), so why only
vortex_eq_init() need __devinit ?

static int __devinit vortex_core_init(vortex_t * vortex)
{
...
	vortex_codec_init(vortex);
	vortex_adbdma_init(vortex);
	hwwrite(vortex->mmio, VORTEX_ENGINE_CTRL, 0x0);	//, 0xc83c7e58,
0xc5f93e58
	vortex_adb_init(vortex);
	/* Init processing blocks. */
	vortex_fifo_init(vortex);
	vortex_mixer_init(vortex);
	vortex_srcblock_init(vortex);
#ifndef CHIP_AU8820
	vortex_eq_init(vortex);
	vortex_spdif_init(vortex, 48000, 1);
	vortex_Vort3D(vortex, 1);
#endif
#ifndef CHIP_AU8810
	vortex_wt_init(vortex);
#endif

----------------------------------------------------------------------
 tiwai - 04-11-06 18:54 
----------------------------------------------------------------------
That patch just fixed a wrong use of __devinit in the header file. 
__devinit was declared in header but not used in the function definition. 
__devinit must be in function definitions.  So, it was moved from header
to *.c.  That's all.

And, what is your point?  How can it be relevant with *THIS* bug report??

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-05 20:43 alien999999999 New Issue                                    
04-12-05 20:43 alien999999999 Distribution              => Mandrake        
04-12-05 20:43 alien999999999 Kernel Version            => 2.6.7           
04-12-05 20:48 alien999999999 Note Added: 0004461                          
04-12-05 20:49 alien999999999 File Added: au88x0.c                         
04-12-05 20:49 alien999999999 File Added: au88x0.h                         
04-12-05 20:50 alien999999999 File Added: au88x0_core.c                    
04-12-05 20:50 alien999999999 File Added: au88x0_mixer.c                    
04-12-05 20:51 alien999999999 Note Added: 0004462                          
08-24-05 11:13 Raymond        Note Added: 0005928                          
10-27-05 02:27 Raymond        Note Added: 0006564                          
01-03-06 04:04 Raymond        Note Added: 0007397                          
01-04-06 22:08 alien999999999 Note Added: 0007455                          
01-05-06 07:21 Raymond        Note Added: 0007462                          
01-05-06 20:32 shurick        Issue Monitored: shurick                     
01-06-06 17:17 alien999999999 Note Added: 0007488                          
01-06-06 17:33 alien999999999 File Added: alsa-cvs-2006-01-04.patch             
      
01-13-06 13:51 Raymond        Note Added: 0007639                          
01-13-06 18:18 tiwai          Note Added: 0007648                          
01-14-06 04:53 Raymond        Note Added: 0007653                          
01-14-06 05:00 Raymond        Note Edited: 0007653                         
01-17-06 12:27 Raymond        Note Added: 0007697                          
01-18-06 15:51 Raymond        Note Added: 0007710                          
01-18-06 15:52 Raymond        File Added: au88x0_codec.patch                    
01-19-06 13:51 Raymond        Note Added: 0007719                          
02-05-06 05:20 Raymond        Note Edited: 0007710                         
02-05-06 05:28 Raymond        Note Added: 0007930                          
02-13-06 16:38 Raymond        Note Deleted: 0006564                        
02-13-06 16:41 Raymond        Note Added: 0008054                          
03-01-06 07:39 Raymond        Note Added: 0008273                          
03-18-06 12:28 Raymond        Note Deleted: 0008273                        
03-20-06 17:54 Raymond        File Added: au88x0_conf.patch                    
03-21-06 02:02 Raymond        Note Added: 0008734                          
03-21-06 18:01 tiwai          Note Added: 0008754                          
03-22-06 02:05 Raymond        File Added: au88x0_mpu401.patch                   

03-22-06 02:28 Raymond        Note Added: 0008779                          
03-22-06 02:31 Raymond        Note Edited: 0008779                         
03-22-06 02:38 rlrevell       Note Added: 0008782                          
03-22-06 04:00 Raymond        Note Added: 0008836                          
03-22-06 04:09 rlrevell       Note Added: 0008839                          
03-26-06 09:55 Raymond        Note Added: 0008967                          
03-29-06 17:48 Raymond        Note Added: 0008995                          
03-31-06 06:52 Raymond        Note Edited: 0008995                         
04-02-06 07:01 Raymond        Note Edited: 0008995                         
04-10-06 16:07 Raymond        Note Added: 0009190                          
04-10-06 16:39 tiwai          Note Added: 0009192                          
04-10-06 16:43 Raymond        Note Added: 0009194                          
04-10-06 16:45 tiwai          Note Added: 0009195                          
04-10-06 19:01 Raymond        Note Added: 0009215                          
04-10-06 19:04 Raymond        Note Edited: 0009215                         
04-10-06 19:05 tiwai          Note Added: 0009216                          
04-11-06 18:36 Raymond        Note Added: 0009234                          
04-11-06 18:54 tiwai          Note Added: 0009235                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
