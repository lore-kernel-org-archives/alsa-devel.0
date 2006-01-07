From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001548]: "alsa-play: xrun of at least 0.009 msecs. resetting stream" : inopportune small pauses while playing
Date: Sat, 7 Jan 2006 21:10:05 +0100
Message-ID: <ed3ce3746117c6409b64bead118bf11e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A76E116
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 21:10:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1548> 
======================================================================
Reported By:                moncnam
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1548
Category:                   PCI - intel8x0m
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian sarge 3.1
Kernel Version:             2.6.13-rc7
======================================================================
Date Submitted:             11-12-2005 10:58 CET
Last Modified:              01-07-2006 21:10 CET
======================================================================
Summary:                    "alsa-play: xrun of at least 0.009 msecs. resetting
stream" : inopportune small pauses while playing
Description: 
whatever the player i use (alsaplayer, xmms, mplayer) i experience small
pause while playing (half of a second)
using mplayer, i can see the following message appearing when the pause
occur
<<alsa-play: xrun of at least 0.009 msecs. resetting stream>>
the playing doesn't stop, it continue well, just a small pause
i have no other messages in `dmesg` or in syslog
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-07-06 20:54 
----------------------------------------------------------------------
/proc/asound/version only tells you the version of the ALSA kernel drivers.
 You need to make sure your alsa-lib packages are also at least 1.0.9.

What is the output of:

grep -l dmix /usr/share/alsa/cards/*

----------------------------------------------------------------------
 moncnam - 01-07-06 21:10 
----------------------------------------------------------------------
okay, thanx for the trick

here is the output you ask for : 
<<
$ grep -l dmix /usr/share/alsa/cards/*
/usr/share/alsa/cards/Azalia.conf
/usr/share/alsa/cards/ICH4.conf
/usr/share/alsa/cards/ICH.conf
/usr/share/alsa/cards/NFORCE.conf
>>
, plus one extra output, under debian, tells what alsa package is install
in which version : 
<<
<code>
$ dlocate -l alsa | grep ii
ii  alsa-base           1.0.8-7             ALSA driver configuration
files
ii  alsa-oss            1.0.8-1             ALSA wrapper for OSS
applications
ii  alsa-utils          1.0.8-4             ALSA utilities
ii  alsamixergui        0.9.0rc2-1-7        graphical soundcard mixer for
ALSA soundcard driver
ii  alsaplayer          0.99.76-0.3         PCM player designed for ALSA
ii  alsaplayer-alsa     0.99.76-0.3         PCM player designed for ALSA
(ALSA output module)
ii  alsaplayer-common   0.99.76-0.3         PCM player designed for ALSA
(common files)
ii  alsaplayer-esd      0.99.76-0.3         PCM player designed for ALSA
(ESD output module)
ii  alsaplayer-gtk      0.99.76-0.3         PCM player designed for ALSA
(GTK version)
ii  alsaplayer-oss      0.99.76-0.3         PCM player designed for ALSA
(OSS output module)
ii  alsaplayer-text     0.99.76-0.3         PCM player designed for ALSA
(text version)
ii  alsaplayer-xosd     0.99.76-0.3         PCM player designed for ALSA
(osd version)
ii  gnome-alsamixer     0.9.6-1             ALSA sound mixer for GNOME
ii  gstreamer0.8-alsa   0.8.8-2             ALSA plugin for GStreamer
ii  libesd-alsa0        0.2.35-2            Enlightened Sound Daemon
(ALSA) - Shared libraries
</code>
>>

with this output, i can guess i am using alsa 1.0.8 (-7 is only a debian
revision add)

when i check my card : 
<<
$ cat /proc/asound/cards
0 [ICH6           ]: ICH4 - Intel ICH6
                     Intel ICH6 with STAC9750,51 at 0xdffffe00, irq 169
1 [Modem          ]: ICH-MODEM - Intel ICH Modem
                     Intel ICH Modem at 0xee00, irq 201
>>
i guess my card ICH6 should be managed by /usr/share/alsa/cards/ICH4.conf
file

i like debian because it aim to be stable, 
i won't install alsa-lib 109 now - i don't have time meanwhile i would
love to play with all that stuff

if you mind :)

my last ~/.asoundrc file
<<
ste@station:~$ cat /home/ste/.asoundrc
pcm.!default { type plug slave.pcm "dmix" }
pcm.!dmix {
        type dmix
        ipc_key 1
#       ipc_perm 0660
        ipc_key_add_uid true
        slave {
                pcm "hw:0,0"
                format  S16_LE
#                rate    48000
                rate    44100
                channels        2
                period_time 0
                period_time 1024
#                buffer_size 4096
                # buffer_size 1024
                # periods 1024
#               periods 4096
                # periods 2048
#               buffer_size 4096
buffer_size 2048
                # buffer_size 8192
                # buffer_size 16384
                # periods 16384
        #       period_size     2048
        period_size     1024
        }
        bindings { 0 0 1 1 }
}

# ctl.mixer0 { type hw card 0 }

>>
this is the only way i can make works : xmms, wmsoundserver, esd, artsd,
thunderbird notification sound

the last step i would love to would be to output a copy of my sound to a
special device in order to being able to record it without recording my
system sounds, but i would need to become an alsahacker, - around july
perhaps 

you can still ask me things if you like
see you

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 10:58 moncnam        New Issue                                    
11-12-05 10:58 moncnam        Distribution              => debian sarge 3.1
11-12-05 10:58 moncnam        Kernel Version            => 2.6.13-rc7      
11-21-05 23:56 sashak         Note Added: 0006779                          
11-22-05 00:04 moncnam        Note Added: 0006781                          
11-22-05 00:31 sashak         Note Added: 0006783                          
11-22-05 00:31 sashak         Assigned To              sashak =>           
11-22-05 00:43 moncnam        Note Added: 0006784                          
01-04-06 22:38 moncnam        Note Added: 0007456                          
01-07-06 02:14 sashak         Note Added: 0007503                          
01-07-06 03:58 moncnam        Note Added: 0007505                          
01-07-06 04:04 moncnam        Note Added: 0007506                          
01-07-06 09:00 rlrevell       Note Added: 0007509                          
01-07-06 16:57 moncnam        Note Added: 0007516                          
01-07-06 20:54 rlrevell       Note Added: 0007519                          
01-07-06 21:10 moncnam        Note Added: 0007521                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
