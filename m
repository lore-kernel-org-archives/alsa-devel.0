From: Mark Knecht <markknecht@attbi.com>
Subject: Re: aplay: pcm_write:1025: write error &
	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: 29 May 2003 21:43:39 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054269819.1697.20.camel@Wizard.knechthome.com>
References: <1053302732.1749.6.camel@Wizard.knechthome.com>
	 <s5haddgv9n5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5haddgv9n5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sorry this is a bit long. Mostly just data. I hope it helps figure this
out. Sort of strange that the chip is identified in one place as a
VIA8233 and in another place as a VIA8235....

On Wed, 2003-05-21 at 04:09, Takashi Iwai wrote:
> At 18 May 2003 17:05:32 -0700,
> Mark Knecht wrote:
> > 
> > Hi,
> >    I brought up Alsa Friday on a Gentoo platform and used it for most of
> > Friday evening and Saturday in one form or another. Along the way I was
> > building some new kernels to fix some SCSI issues and a few other items,
> > which required that Alsa get rebuilt also as per the Gentoo Alsa
> > instructions. This process went on for most of the day. Later Saturday
> > evening, following who knows how many 'unrelated' changes, Alsa stopped
> > working. The error messages look like this:
> > 
> > Wizard root # aplay wave/sequen~1.wav 
> > Playing WAVE 'wave/sequen~1.wav' : Signed 16 bit Little Endian, Rate
> > 44100 Hz, Mono
> > aplay: pcm_write:1025: write error: Input/output error
> > Wizard root # 
> > 
> > or when trying to play a game like frozen-bubble, that app locks up hard
> > and in my console I see:
> > 
> > ALSA Lib pcm_hw.c:467:(snd_pcm_hw_prepare)SNDRV_PCM_IOCTL_PREPARE
> > failed:device or resource busy
> > 
> > alsaplayer starts to run, sees the CD (I.e. - shows track length) and
> > then won't play the CD.
> > 
> > I'll attach a bit of data, but can anyone point me toward what might be
> > causing this? 
> 
> the chip looks like a VIA8235, so the (first) pcm device supports
> multiple playbacks but with the same sample rate.
> please check whether there is any other app running and using the pcm
> device and if it uses different sample rates (e.g. 48kHz)...
> 
> 
> Takashi

Takashi-san,
   To the best of my knowledge there are no other apps using sound in
any way. The environment is fluxbox, which doesn't use sound. I get the
same results in a console after a cold boot before starting fluxbox
also. I've tried playing 48KHz and 44.1KHz wave files and get the same
results.

   There is a strange thing I noticed about how the chip is set up
though. I've loaded the via82xx driver. In /proc/pci the chip identifies
itself as an VIA8233:

Wizard root # grep audio /proc/pci
    Multimedia audio controller: Xilinx, Inc. RME Hammerfall DSP (rev
104).
    Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 80).
Wizard root # 

However, in aplay it identifies itself as a VIA 8235:


bash-2.05b$ aplay -l    
**** List of PLAYBACK Hardware Devices ****
card 0: 8235 [VIA 8235], device 0: VIA 8235 [VIA 8235]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
card 0: 8235 [VIA 8235], device 1: VIA 8235 [VIA 8235]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
bash-2.05b$ 


There are no processes running that are obviously usign audio, as far as
I can see:


bash-2.05b$ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.2  0.0  1352  496 ?        S    20:54   0:04 init
root         2  0.0  0.0     0    0 ?        SW   20:54   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  20:54   0:00
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   20:54   0:00 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   20:54   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   20:54   0:00
[kupdated]
root         8  0.0  0.0     0    0 ?        SW   20:54   0:00 [khubd]
root        12  0.0  0.0     0    0 ?        SW   20:54   0:00
[kjournald]
root        36  0.0  0.1  1748  916 ?        S    20:54   0:00
/sbin/devfsd /dev
root       843  0.0  0.1  1428  572 ?        S    20:54   0:00
/usr/sbin/syslogd -m 0
root       846  0.0  0.1  1472  576 ?        S    20:54   0:00
/usr/sbin/klogd -c 3 -2
root       849  0.0  0.1  1472  568 ?        S    20:54   0:00
/usr/sbin/crond
root      1089  0.0  0.2  2732 1284 ?        S    20:54   0:00
/usr/sbin/sshd
xfs       1242  0.0  0.9  6264 4772 ?        S    20:54   0:00 [xfs]
root      1252  0.0  0.2  2288 1236 ?        S    20:54   0:00 [login]
root      1253  0.0  0.0  1336  424 vc/2     S    20:54   0:00
/sbin/agetty 38400 tty2 linux
root      1254  0.0  0.0  1336  424 vc/3     S    20:54   0:00
/sbin/agetty 38400 tty3 linux
mark      1322  0.0  0.2  2292 1372 vc/1     S    20:54   0:00 -bash
mark      1331  0.0  0.1  2036  976 vc/1     S    20:55   0:00 /bin/sh
/usr/X11R6/bin/startx
mark      1342  0.0  0.1  2324  624 vc/1     S    20:55   0:00 xinit
/home/mark/.xinitrc -- -deferglyphs 16
root      1343  0.3  2.5 92644 13356 ?       R    20:55   0:06 [X]
mark      1361  0.0  0.5  5212 2648 vc/1     S    20:55   0:00
/usr/bin/fluxbox
mark      1560  0.0  0.3  3692 1832 ?        S    21:13   0:00
/usr/bin/gconfd-1 12
mark      1628  0.0  0.8  6928 4332 ?        R    21:21   0:00 [xterm]
mark      1629  0.0  0.2  2312 1396 pts/0    S    21:21   0:00 bash
mark      1638  0.0  0.1  2664  800 pts/0    R    21:23   0:00 ps aux



My .asoundrc file is as per the web page I Think:

bash-2.05b$ more .asoundrc 
pcm.via82xx {
type hw
card 0
}

ctl.via82xx {
type hw
card 0
}


The error again:

bash-2.05b$ aplay jazztrap-5-4-groove-28.wav 
Playing WAVE 'jazztrap-5-4-groove-28.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo
aplay: pcm_write:1025: write error: Input/output error


bash-2.05b$ su -
Password: 
Wizard root # lsmod
Module                  Size  Used by    Not tainted
radeon                101572   1 
agpgart                11920   3  (autoclean)
ide-cd                 27080   0  (autoclean)
cdrom                  25984   0  (autoclean) [ide-cd]
snd-via82xx            11692   0 
snd-ac97-codec         34624   0  [snd-via82xx]
snd-mpu401-uart         3456   0  [snd-via82xx]
snd-rawmidi            14432   0  [snd-mpu401-uart]
snd-seq-device          4192   0  [snd-rawmidi]
snd-pcm                60928   0  [snd-via82xx]
snd-timer              15240   0  [snd-pcm]
snd                    30852   0  [snd-via82xx snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device snd-pcm snd-timer]
snd-page-alloc          4908   0  [snd-via82xx snd-pcm]
Wizard root # 


### modules-update: start processing /etc/modules.d/alsa
# Alsa 0.9.X kernel modules' configuration file.
# $Header:
/home/cvsroot/gentoo-x86/media-sound/alsa-driver/files/alsa-modules.conf-rc,v 1.1 2002/12/21 06:31:52 agenkin Exp $

# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##
##  ALSA portion
alias snd-card-0 snd-via82xx
## alias snd-card-1 snd-ens1371
##  OSS/Free portion
alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
##  OSS/Free portion - card #2
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.
options snd cards_limit=1

### modules-update: end processing /etc/modules.d/alsa





-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
