From: lupus <de_lupus@pandora.be>
Subject: oss emulation gets loaded but doesn't work because alsa driver
 doesn't get loaded auto
Date: Thu, 11 Dec 2003 03:34:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071110057.2909.8.camel@d51521F77.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Got a strange problem. My oss emulation drivers get auto loaded but not
my alsa driver. oss emulation depends on this driver.

I have to manual modprobe it to make my sound work.

And my volume control is broken but it seems this is because of ac97 if
I have read your mailing list correctly. When will this be fixed?

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 60)

VT600 chipset

[root@d51521f77 lupus]# /sbin/lsmod
Module                  Size  Used by
snd_pcm_oss            45476  0
snd_pcm                84388  1 snd_pcm_oss
snd_page_alloc         11268  1 snd_pcm
snd_timer              21508  1 snd_pcm
snd_mixer_oss          16000  1 snd_pcm_oss
snd                    44260  4
snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7872  1 snd

[root@d51521f77 lupus]# cat /etc/modprobe.conf
include /etc/modprobe.conf.dist
alias eth0 ne2k-pci
alias eth1 b44
alias char-major-81* bttv
alias usb-controller ehci-hcd
 
# ALSA portion
alias char-major-116* snd
alias snd-card-0 snd-via82xx
# module options should go here
 
# OSS/Free portion
alias char-major-14* soundcore
alias sound-slot-0 snd-card-0
 
# card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
   
install snd-card-0 /sbin/modprobe --ignore-install snd-card-0 {
/usr/sbin/alsactl restore >/dev/null 2>&1 || : ; }
remove snd-card-0 { /usr/sbin/alsactl store >/dev/null 2>&1 || :; };
/sbin/modprobe -r --ignore-remove

Linux 2.6.0-0.test11.1.99 #1 Wed Nov 26 17:03:13 EST 2003 i686 athlon
i386 GNU/Linux
[root@d51521f77 lupus]#

[root@d51521f77 lupus]# rpm -q alsa-lib
alsa-lib-0.9.8-2.fr
[root@d51521f77 lupus]# rpm -q alsa-utils
alsa-utils-0.9.8-1.fr

Plz help me

Kristof Vansant





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
