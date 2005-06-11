From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Sat, 11 Jun 2005 15:11:28 +0200
Message-ID: <9c42228367f052c4bb0b66fe463644ce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17CF31D2
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 15:11:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=724> 
======================================================================
Reported By:                sjberryman
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   724
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              06-11-2005 15:11 CEST
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

----------------------------------------------------------------------
 sjberryman - 06-11-05 13:34 
----------------------------------------------------------------------
Thanks

These are the results

2)
$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9.
Compiled on May 31 2005 for kernel 2.6.11-1.27_FC3.

3)
$ grep VERSION_STR /usr/include/alsa/version.h
#define SND_LIB_VERSION_STR     "1.0.9"

4)
$ cat /proc/asound/cards
0 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0413] at 0xc8e0 irq 3

# lspci | egrep audio
04:02.0 Multimedia audio controller: Creative Labs SB Audigy LS


#cat /proc/asound/oss/sndstat

Sound Driver:3.8.1a-980706 (ALSA v1.0.9 emulation code)
Kernel: Linux p3000.local 2.6.11-1.27_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue May 17 20:27:37 EDT
2005
i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
Live! 7.1 24bit [SB0413] at 0xc8e0 irq 3

Audio devices:
0: CA0106 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: mixer00



# lsmod
Module                  Size  Used by
fglrx                 234044  7
nfsd                  212097  9
exportfs                8641  1 nfsd
lockd                  63593  2 nfsd
md5                     4161  1
ipv6                  259201  10
parport_pc             28421  1
lp                     12489  0
parport                40201  2 parport_pc,lp
autofs4                26181  0
sunrpc                164485  19 nfsd,lockd
ipt_REJECT              7105  1
ipt_state               1857  1
ip_conntrack           40601  1 ipt_state
iptable_filter          2881  1
ip_tables              19777  3 ipt_REJECT,ipt_state,iptable_filter
vfat                   13505  1
fat                    43229  1 vfat
nls_utf8                2113  1
ntfs                  107760  1
dm_mod                 59221  0
video                  15813  0
button                  6609  0
battery                 9285  0
ac                      4805  0
pl2303                 23621  0
usbserial              28713  1 pl2303
uhci_hcd               33497  0
ehci_hcd               39501  0
i2c_i801                8653  0
i2c_core               21953  1 i2c_i801
snd_ca0106             28324  3
snd_ac97_codec         76924  1 snd_ca0106
snd_pcm_oss            50080  0
snd_mixer_oss          17536  2 snd_pcm_oss
snd_pcm                96392  3 snd_ca0106,snd_ac97_codec,snd_pcm_oss
snd_timer              30852  1 snd_pcm
snd                    54404  10
snd_ca0106,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10785  2 snd
snd_page_alloc          7940  2 snd_ca0106,snd_pcm
tg3                    97733  0
8139too                29505  0
mii                     4929  1 8139too
ext3                  131145  5
jbd                    82777  1 ext3
ata_piix                9285  8
libata                 46789  1 ata_piix
sd_mod                 19265  9
scsi_mod              139945  2 libata,sd_mod


alsamixer starts ok for non-root user.

----------------------------------------------------------------------
 jcdutton - 06-11-05 15:11 
----------------------------------------------------------------------
Ok, it looks like you have alsa-driver 1.0.9 and alsa-lib 1.0.9 installed.
To test sound try:
speaker-test -c2 -Dplug:front

Then while that is playing, go into alsamixer and adjust the volume of the
Analog Front control.
Also try toggling the SPDIF_OUT on and off a few times until it says [OFF]
again.
There was a bug in one version of the alsa-driver that told the user
SPDIF_OUT [OFF] when in fact it was on inside the driver, simply toggling
it a few times fixes the problem. The bug is fixed in the latest
alsa-driver 1.0.9b

I am assuming you are connecting your speakers via the analog socket and
not the spdif.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-04 09:21 sjberryman     New Issue                                    
12-13-04 09:21 sjberryman     Distribution              => Fedora Core1, Core2
and Suse 9.2
12-13-04 09:21 sjberryman     Kernel Version            => 2.6.9 2.4.28 2.6.8
12-13-04 09:26 sjberryman     Issue Monitored: sjberryman                    
12-13-04 10:07 pzad           Note Added: 0002821                          
12-16-04 18:28 tiwai          Status                   new => resolved     
12-16-04 18:28 tiwai          Resolution               open => not an issue
12-16-04 18:28 tiwai          Assigned To               => tiwai           
12-16-04 18:28 tiwai          Assigned To              tiwai =>            
01-19-05 09:08 sjberryman     Status                   resolved => feedback
01-19-05 09:08 sjberryman     Resolution               not an issue => reopened
01-19-05 09:08 sjberryman     Note Added: 0003263                          
01-19-05 14:27 tiwai          Note Added: 0003266                          
01-22-05 22:15 nadavkav       Note Added: 0003379                          
01-22-05 23:20 fmoraes        Note Added: 0003381                          
01-25-05 22:39 Kane32         Note Added: 0003411                          
01-26-05 13:18 nadavkav       Note Added: 0003416                          
02-08-05 23:26 sHINOBI        Issue Monitored: sHINOBI                     
02-08-05 23:32 sHINOBI        Note Added: 0003534                          
02-09-05 07:25 pzad           Note Added: 0003535                          
02-09-05 08:57 sHINOBI        Note Added: 0003536                          
02-09-05 13:25 nadavkav       Issue Monitored: nadavkav                    
02-09-05 13:25 nadavkav       Issue End Monitor: nadavkav                    
05-28-05 16:06 sjberryman     Note Added: 0004774                          
05-28-05 20:02 jcdutton       Status                   feedback => assigned
05-28-05 20:02 jcdutton       Assigned To               => jcdutton        
05-28-05 20:07 jcdutton       Note Added: 0004775                          
05-28-05 20:07 jcdutton       Status                   assigned => feedback
06-10-05 13:28 sjberryman     Note Added: 0004983                          
06-10-05 18:58 jcdutton       Note Added: 0004985                          
06-11-05 13:34 sjberryman     Note Added: 0004988                          
06-11-05 15:11 jcdutton       Note Added: 0004991                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
