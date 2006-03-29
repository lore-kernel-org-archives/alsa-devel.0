From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Wed, 29 Mar 2006 17:48:53 +0200
Message-ID: <e307b149a59d7f5c2ac2f5a49f07262d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C64B199
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 17:48:53 +0200 (MEST)
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
Last Modified:              03-29-2006 17:48 CEST
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
 Raymond - 03-26-06 09:55 
----------------------------------------------------------------------
For au88x0 with stereo codec, instead of using vdownmix plugin 1.0.11rc4 

       pcm.!surround51 {
                type vdownmix
                slave.pcm "default"
       }

you can use multi plugin and hardware mixing, the drawback is 6 sample
rate convertors are used 


<confdir:pcm/surround51.conf>

AU8810.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.AU8810.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8810.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8810.pcm.front.0:CARD=" $CARD
				]
			}
			channels 1
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8810.pcm.front.0:CARD=" $CARD
				]
			}
			channels 1
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
		{ slave 2 channel 0 }
		{ slave 3 channel 0 }
	]
}

----------------------------------------------------------------------
 Raymond - 03-29-06 17:48 
----------------------------------------------------------------------
Sorry, there is no need to add the channel parameter 4 to "surround40"
device in AU8810.conf or AU8830.conf, the device 0 of au88x0 driver
already use the hardware mixer to perform those upmix plugin functions :
upmix_1_to_2, upmix_1_to_4, upmix_2_to_4 

The upmix plugin use 2 SRC of au88x0 for upmix_1_to_2 and 4 SRC for
upmix_1_to_4, but au88x0 only use 1 SRC when using the hardware mixer to
perform the upmix.

In fact, adding the channel parameter 4 to "surround40" will lead to a
more complex "surround51" config using "multi" and hardware mixing to
downmix 5.1 to 2.0/4.0 

A "rear" device can be implemented using the "subdevice playback volume"
as described in  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
