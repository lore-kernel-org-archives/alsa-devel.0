From: Prince John <princejohnm@yahoo.com>
Subject: ALSA Driver Testing
Date: Wed, 16 Jul 2003 07:40:08 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030716144008.56034.qmail@web11702.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I'm facing some problems while testing a driver
developed for a Hitachi SH4 based board. The board has
an AC97 codec and codec controller.
I'm working as 'root'. The devices are created with
'snddevices' and all modules are loaded properly.

When tried to test the driver by running 'amixer' and
'aplay' but it fails during 'snd_ctl_open_noupdate'
call
in library. 

# ./aplay -D hw:0,0
ALSA lib pcm.c:1906:(snd_pcm_open_noupdate) Unknown
PCM hw:0,0
aplay: main:480: audio open error: No such file or
directory

# ./aplay -D Aspen
ALSA lib pcm.c:1906:(snd_pcm_open_noupdate) Unknown
PCM Aspen
aplay: main:480: audio open error: No such file or
directory

# ./amixer
ALSA lib control.c:612:(snd_ctl_open_noupdate) Invalid
CTL default
amixer: Mixer attach default error: No such file or
directory

---------------------
Looks like, both utilities are looking for some config
files. The error happens during the search of some
sound
config files in conf.c file of ALSA lib. 

The .asoundrc file is kept at / and /root. The
alsa.conf file is placed in /alsa and /usr/share/alsa

# cat /root/.asoundrc
pcm.Aspen {
  type hw
  card 0
}

ctl.Aspen {
  type hw
  card 0
}
#

# ls -l /alsa/
-rwxrwxrwx    1 root     audio        7329 Jul 14 
2003 alsa.conf
drwxrwxrwx    2 root     audio        1024 Jul 15 
2003 cards
drwxrwxrwx    2 root     audio        1024 Jul 15 
2003 pcm


# ls -l /dev/snd
lrwxrwxrwx    1 root     root           16 Jun  7
14:48 /dev/snd -> /proc/asound
/dev


# cat /proc/asound/card0/id
Aspen

# cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
#
# ls -l  /proc/asound/dev/
crw-rw-rw-    1 root     root     116,   0 Jun  7
15:43 controlC0
crw-rw-rw-    1 root     root     116,  24 Jun  7
15:43 pcmC0D0c
crw-rw-rw-    1 root     root     116,  16 Jun  7
14:30 pcmC0D0p
crw-rw-rw-    1 root     root     116,   1 Jun  7
15:43 seq
crw-rw-rw-    1 root     root     116,  33 Jun  7
15:43 timer

-----------------------

Am I missing any config files or path settings ? Can
somebody please give the info on how & where to setup
the config files for a new driver?

Thanks and regards,
Prince



__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
