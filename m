From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000880]: ALSA lib pcm_hw.c:370:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
Date: Sat, 5 Feb 2005 17:17:55 +0100
Message-ID: <803551f93a3d07d0cb111bec0099478d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80F0E1F4
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2005 17:17:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=880> 
======================================================================
Reported By:                runtema
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   880
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 09:20 CET
Last Modified:              02-05-2005 17:17 CET
======================================================================
Summary:                    ALSA lib pcm_hw.c:370:(snd_pcm_hw_hw_free)
SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
Description: 
When accesing ALSA lib/module pcm trough application ogle (see
http://www.dtek.chalmers.se/groups/dvd/) it breaks down to the error given
in the summary.

Details for system/version/error:

see http://forums.gentoo.org/viewtopic.php?p=2050504
======================================================================

----------------------------------------------------------------------
 runtema - 02-05-05 12:10 
----------------------------------------------------------------------
Ok, after setting the message level of artsd manually lower than the
default from Control Center, i still run into errors, which support my
thesis, that I have a possible ALSA lib error:

> /usr/kde/3.3/bin/artsd -F 9 -S 4096 -s 10 -m artsmessage -c drkonqui -l
1
> ALSA lib pcm_hw.c <snip> SNDRV_PCM_IOCTL_START failed: Broken pipe



----------------------------------------------------------------------
 runtema - 02-05-05 17:17 
----------------------------------------------------------------------
Does either alsa or my application have problems with choosing the wrong
device?

OK, after some new information from the kde bug team I tried to put down
the suspend time in artsd, and retry playing, but nothing...

[code]runtema@jazz:~> artsshell
> status
server status: suspended
real-time status: not real-time
server buffer time: 46.4399 ms
buffer size multiplier: 1
minimum stream buffer time: 46.4399 ms
auto suspend time: 2 s
audio method: alsa
sampling rate: 44100
channels: 2
sample size: 16 bits
duplex: half
device: default
fragments: 2
fragment size: 4096[/code]

Ok, artsd suspends correctly, I found no application which should use my
sounddevice (besides perhaps mozilla itself), so I did a strace on my
application to see which sounddevice its using:

[code]
[pid 18130] 12:43:10.606278 stat64("/usr/share/alsa/alsa.conf",
{st_dev=makedev(
3, 7), st_ino=2927, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0,
st_blk
size=4096, st_blocks=24, st_size=8365, st_atime=2005/02/05-12:37:10,
st_mtime=20
05/01/03-19:51:17, st_ctime=2005/01/03-19:51:17}) = 0
[pid 18130] 12:43:10.606565 open("/usr/share/alsa/alsa.conf", O_RDONLY) =
3
[pid 18130] 12:43:10.606744 fstat64(3, {st_dev=makedev(3, 7), st_ino=2927,
st_mo
de=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096,
st_blocks=24,
st_size=8365, st_atime=2005/02/05-12:37:10, st_mtime=2005/01/03-19:51:17,
st_cti
me=2005/01/03-19:51:17}) = 0
[pid 18130] 12:43:10.606902 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVA
TE|MAP_ANONYMOUS, -1, 0) = 0x400c8000
[pid 18130] 12:43:10.607024 read(3, "#\n#  ALSA library configuration
"..., 4096
) = 4096
[pid 18130] 12:43:10.611756 read(3, " FORMAT ]\n\t@args.FILE {\n\t\ttype
s"...,
4096) = 4096
[pid 18130] 12:43:10.615136 read(3, "\n\tcard {\n\t\t@func refer\n\t\tname
de"..
., 4096) = 173
[pid 18130] 12:43:10.615395 read(3, "", 4096) = 0
[pid 18130] 12:43:10.615490 read(3, "", 4096) = 0
[pid 18130] 12:43:10.615629 close(3)    = 0
[pid 18130] 12:43:10.615722 munmap(0x400c8000, 4096) = 0
[pid 18130] 12:43:10.617738 access("/etc/asound.conf", R_OK) = -1 ENOENT
(No suc
h file or directory)
[pid 18130] 12:43:10.617968 access("/home/runtema/.asoundrc", R_OK) = -1
ENOENT
(No such file or directory)
[pid 18130] 12:43:10.618694 open("/dev/snd/controlC0", O_RDONLY) = 3
[pid 18130] 12:43:10.618864 close(3)    = 0
[pid 18130] 12:43:10.619000 open("/dev/snd/controlC0", O_RDWR) = 3
[pid 18130] 12:43:10.619136 ioctl(3, USBDEVFS_CONTROL, 0xbfffc99c) = 0
[pid 18130] 12:43:10.619261 ioctl(3, 0x40045532, 0xbfffc9c4) = 0
[pid 18130] 12:43:10.619350 open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) =
4
[pid 18130] 12:43:10.619696 close(3)    = 0
[pid 18130] 12:43:10.619800 ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY,
0xbfffc8
a0) = 0
[pid 18130] 12:43:10.619910 fcntl64(4, F_GETFL) = 0x802 (flags
O_RDWR|O_NONBLOCK
)
[pid 18130] 12:43:10.620001 ioctl(4, AGPIOC_INFO, 0xbfffc89c) = 0
[pid 18130] 12:43:10.620084 ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND,
0xbfffc8
98) = 0
[pid 18130] 12:43:10.620221 old_mmap(NULL, 4096, PROT_READ, MAP_SHARED, 4,
0x800
00000) = 0x400c8000
[pid 18130] 12:43:10.620355 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_SHARE
D, 4, 0x81000000) = 0x400c9000
[pid 18130] 12:43:10.620606 ioctl(4, 0xc25c4110, 0xbfffc7f0) = 0
[pid 18130] 12:43:10.620772 ioctl(4, 0xc25c4110, 0xbfffc3f0) = 0
[/code]

And there it starves... (many, many ioctls and much more of

[quote]<... msgrcv resumed> 524288, {5, "\0\0\0\0\7\0\0\0\5
\0\210\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...}, 4116, 7, IPC_NOWAIT) = -1
ENOMSG (No
message of desired type)[/quote] )

[code]
[pid 18130] 12:43:11.997904 write(2, "ERROR[ogle_audio]: drain
failed:"..., 66ER
ROR[ogle_audio]: drain failed: Resource temporarily unavailable
) = 66
[pid 18130] 12:43:11.998041 ioctl(4, 0x4140, 0x58) = -1 EBUSY (Device or
resourc
e busy)
[pid 18130] 12:43:11.998178 write(2, "ALSA lib
pcm_hw.c:535:(snd_pcm_h"..., 43AL
SA lib pcm_hw.c:535:(snd_pcm_hw_prepare) ) = 43
[pid 18130] 12:43:11.998330 write(2, "SNDRV_PCM_IOCTL_PREPARE failed",
30SNDRV_P
CM_IOCTL_PREPARE failed) = 30
[pid 18130] 12:43:11.998479 write(2, ": Device or resource busy", 25:
Device or
resource busy) = 25
[pid 18130] 12:43:11.998620 write(2, "\n", 1
) = 1
[pid 18130] 12:43:11.998753 write(2, "ERROR[ogle_audio]: prepare
faile"..., 59ER
ROR[ogle_audio]: prepare failed: Device or resource busy
) = 59
[/code]

[code]
[pid 18130] 12:43:12.009287 ioctl(4, 0x4112, 0) = -1 EBADFD (File
descriptor in
bad state)
[pid 18130] 12:43:12.009423 write(2, "ALSA lib
pcm_hw.c:382:(snd_pcm_h"..., 43AL
SA lib pcm_hw.c:382:(snd_pcm_hw_hw_free) ) = 43
[pid 18130] 12:43:12.009574 write(2, "SNDRV_PCM_IOCTL_HW_FREE failed",
30SNDRV_P
CM_IOCTL_HW_FREE failed) = 30
[pid 18130] 12:43:12.009722 write(2, ": File descriptor in bad state", 30:
File
descriptor in bad state) = 30
[pid 18130] 12:43:12.009851 write(2, "\n", 1
) = 1
[pid 18130] 12:43:12.009988 write(2, "ERROR[ogle_audio]: Unable to
set"..., 86ER
ROR[ogle_audio]: Unable to set hw params for playback: File descriptor in
bad st
ate
) = 86
[pid 18130] 12:43:12.010135 write(2, "ERROR[ogle_audio]: Setting of
hw"..., 76ER
ROR[ogle_audio]: Setting of hwparams failed: File descriptor in bad state
) = 76
[pid 18130] 12:43:12.010276 write(2, "FATAL[ogle_audio]:
ogle_ao_init:"..., 33FA
TAL[ogle_audio]: ogle_ao_init: ) = 33
[pid 18130] 12:43:12.010453 write(2, "\n", 1
) = 1
[pid 18130] 12:43:12.011349 gettimeofday({1107603792, 11392}, NULL) = 0
[pid 18130] 12:43:12.011521 write(2, "ogle_audio: pcm.c:911:
snd_pcm_d"..., 69og
le_audio: pcm.c:911: snd_pcm_delay: Assertion `pcm->setup' failed.
) = 69
[pid 18130] 12:43:12.011657 rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) =
0
[pid 18130] 12:43:12.011801 kill(18130, SIGABRT) = 0
[pid 18130] 12:43:12.011888 --- SIGABRT (Aborted) @ 0 (0) ---
Process 18130 detached
[/code]

Any new ideas? I'll post my /etc/modules.d/alsa her and my /dev/ because I
find it amazing I have two dev trees for sound (/dev/sound and /dev/snd
(last ogle wants to use, see above code from strace).

[code]cat /etc/modules.d/alsa
# Alsa 0.9.X kernel modules' configuration file.
# $Header:
/var/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-modules.conf-rc,v
1.2 2004/07/18 03:40:55 dragonheart Exp $

# ALSA portion
# OSS/Free portion

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##
##  ALSA portion
## alias snd-card-1 snd-ens1371
##  OSS/Free portion
## alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
##  OSS/Free portion - card
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.

# --- BEGIN: Generated by ALSACONF, do not edit. ---
# --- ALSACONF verion 1.0.6 ---
alias char-major-116 snd
alias char-major-14 soundcore
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
options snd  device_mode=0666
alias snd-card-0 snd-es1938
alias sound-slot-0 snd-es1938
# --- END: Generated by ALSACONF, do not edit. ---[/code]

[code]ls -lrt /dev | tail -n 10 | head -n 9
lr-xr-xr-x  1 root    root      8 Feb  5 09:49 rtc -> misc/rtc
lr-xr-xr-x  1 root    root     16 Feb  5 12:30 sequencer2 ->
sound/sequencer2
lr-xr-xr-x  1 root    root     15 Feb  5 12:30 sequencer ->
sound/sequencer
lr-xr-xr-x  1 root    root     11 Feb  5 12:30 mixer -> sound/mixer
lr-xr-xr-x  1 root    root     12 Feb  5 12:30 midi00 -> sound/midi00
lr-xr-xr-x  1 root    root      9 Feb  5 12:30 dsp -> sound/dsp
lr-xr-xr-x  1 root    root     12 Feb  5 12:30 dmmidi -> sound/dmmidi
lr-xr-xr-x  1 root    root     10 Feb  5 12:30 dmfm -> sound/dmfm
lr-xr-xr-x  1 root    root     11 Feb  5 12:30 audio ->
sound/audio[/code]

[code]ls -ld /dev/s[eno]*
lr-xr-xr-x  1 root root 15 Feb  5 12:30 /dev/sequencer -> sound/sequencer
lr-xr-xr-x  1 root root 16 Feb  5 12:30 /dev/sequencer2 ->
sound/sequencer2
drwxr-xr-x  1 root root  0 Jan  1  1970 /dev/snd
drwxr-xr-x  1 root root  0 Jan  1  1970 /dev/sound
/dev/sound:
total 0
crw-------  1 runtema root 14,  8 Jan  1  1970 sequencer2
crw-------  1 runtema root 14,  1 Jan  1  1970 sequencer
crw-------  1 runtema root 14,  0 Jan  1  1970 mixer
crw-------  1 runtema root 14,  2 Jan  1  1970 midi00
crw-------  1 runtema root 14,  3 Jan  1  1970 dsp
crw-------  1 runtema root 14,  9 Jan  1  1970 dmmidi
crw-------  1 runtema root 14, 10 Jan  1  1970 dmfm
crw-------  1 runtema root 14,  4 Jan  1  1970 audio

/dev/snd:
total 0
crw-------  1 runtema root 116, 33 Jan  1  1970 timer
crw-------  1 runtema root 116,  1 Jan  1  1970 seq
crw-------  1 runtema root 116, 16 Jan  1  1970 pcmC0D0p
crw-------  1 runtema root 116, 24 Jan  1  1970 pcmC0D0c
crw-------  1 runtema root 116,  8 Jan  1  1970 midiC0D0
crw-------  1 runtema root 116,  4 Jan  1  1970 hwC0D0
crw-------  1 runtema root 116,  0 Jan  1  1970 controlC0
[/code]

And here my stuff out of devfsd.conf:

[code]# ALSA/OSS stuff
# Comment/change these if you want to change the permissions on
# the audio devices
LOOKUP          snd          MODLOAD ACTION snd
LOOKUP          dsp          MODLOAD
LOOKUP          mixer        MODLOAD
LOOKUP          midi         MODLOAD
REGISTER        sound/.*     PERMISSIONS root.audio 660
REGISTER        snd/.*       PERMISSIONS root.audio 660[/code]

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 09:20 runtema        New Issue                                    
02-05-05 10:58 runtema        Note Added: 0003519                          
02-05-05 11:20 runtema        Note Added: 0003520                          
02-05-05 12:06 runtema        Note Added: 0003521                          
02-05-05 12:10 runtema        Note Edited: 0003521                         
02-05-05 17:17 runtema        Note Added: 0003522                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
