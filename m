From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Sun, 31 Jul 2005 15:59:26 +0800
Message-ID: <42EC84DE.4050306@netvigator.com>
References: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org


If there are 16 instances of aplay playing mono stream.

What error will be returned by snd_pcm_open() for the 17th instance of 
aplay ?



alsa-kernel/pci/au88x0/au8810.h

#define NR_ADB   0x10

alsa-kernel/pci/au88x0/au8830.h

#define NR_ADB   0x20


alsa-kernel/pci/au88x0/au88x0.c

	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
		snd_card_free(card);
		return err;
	}



bugtrack@alsa-project.org wrote:
> A NOTE has been added to this issue.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047> 
> ======================================================================
> Reported By:                alien999999999
> Assigned To:                mjander
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   1047
> Category:                   PCI - au88x0
> Reproducibility:            sometimes
> Severity:                   block
> Priority:                   normal
> Status:                     assigned
> Distribution:               Mandrake
> Kernel Version:             2.6.7
> ======================================================================
> Date Submitted:             04-12-2005 20:43 CEST
> Last Modified:              04-12-2005 20:51 CEST
> ======================================================================
> Summary:                    module hangs at seemingly random times
> Description: 
> sometimes i start playing a song, and it starts playing a few second or so
> and hangs, then i kill the application and modprobe -r all sound modules
> and modprobe them again to make it work again.
> 
> BUT: sometimes not only that happens, but also when i try to kill the apps
> it will not kill. when that happens, all kill, killall, top, ps aux
> commands hang at the command line and cannot be killed by CTRL-C or
> otherwise, i have been able to see that when i stopped my display
> managener I did an lsmod and it gave something like this:
> 
> snd-pcm-oss            59752  11
> snd-mixer-oss          20480  1 snd-pcm-oss
> snd-au8810             43760  220
> snd-ac97-codec         83408  1 snd-au8810
> snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
> snd-page-alloc         10384  1 snd-pcm
> gameport                3840  1 snd-au8810
> snd-mpu401-uart        11904  1 snd-au8810
> 
> 
> as you can see the snd-au8810 module seem to have an impossible number of
> "dependencies" (i think has to do with the number of unclosed sound-apps
> trying to be played; this could be since gaim is programmed to execute an
> 'aplay %s')
> 
> i've had this major crash below only 3 times; and the logs didn't detect
> anything specific at the time. the only thing the logs mentioned at that
> time was an ntpd sync going on; so the only thing i can think of is that
> at a certain moment when a sync is going on, some kind of lock is holding
> cause this to happen... the only thing that i can do to fix this is
> reset...
> 
> it is interesting to note that i also have an snd-emu10k1 as second card,
> which never gave problems like this, and i am always able to "modprobe -r
> snd-emu10k1" ...
> ======================================================================
> 
> ----------------------------------------------------------------------
>  alien999999999 - 04-12-05 20:48 
> ----------------------------------------------------------------------
> i forgot to note that i have the mdk 10.1 x86_64 distro and my version has
> a few 64bit fixes to get past kernel hangs and kernel oopses
> 
> ----------------------------------------------------------------------
>  alien999999999 - 04-12-05 20:51 
> ----------------------------------------------------------------------
> i have attached the changed files (since i don't have a CVS version of alsa
> to diff against)
> 
> these files are located in the alsa-driver-1.0.8/alsa-kernel/pci/au88x0/
> path
> 
> Issue History
> Date Modified  Username       Field                    Change              
> ======================================================================
> 04-12-05 20:43 alien999999999 New Issue                                    
> 04-12-05 20:43 alien999999999 Distribution              => Mandrake        
> 04-12-05 20:43 alien999999999 Kernel Version            => 2.6.7           
> 04-12-05 20:48 alien999999999 Note Added: 0004461                          
> 04-12-05 20:49 alien999999999 File Added: au88x0.c                         
> 04-12-05 20:49 alien999999999 File Added: au88x0.h                         
> 04-12-05 20:50 alien999999999 File Added: au88x0_core.c                    
> 04-12-05 20:50 alien999999999 File Added: au88x0_mixer.c                    
> 04-12-05 20:51 alien999999999 Note Added: 0004462                          
> ======================================================================
> 
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
