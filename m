From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000660]: No sound output  despite unmuting and maximizing all volume settings
Date: Sun, 21 Nov 2004 03:19:11 +0100
Message-ID: <ca99a2b66c16bfdc7abe4c588de3c88d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB8CF26B
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2004 03:19:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=660> 
======================================================================
Reported By:                bji
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   660
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-21-2004 02:53 CET
Last Modified:              11-21-2004 03:19 CET
======================================================================
Summary:                    No sound output  despite unmuting and maximizing all
volume settings
Description: 
I get no sound output from any program I have tried (xmms, play, aplay, cat
> /dev/audio) with no error messages or any other indication that there is
a problem which would cause sound to not occur.

I have already run alsamixer many times and tried every combination of
muted and unmuted settings with all volumes maximized.  With no volume
settings muted, and all volume settings at maximum level, I still get no
sound.

Everything *looks* like it's working - output in the kernel log, xmms's
display, everything.  But I get no sound out of the built-in speaker or
the headphone jack.

I have tried the following:

* Default install of Fedora Core 3; it recognized the sound card and
installed module settings in /etc/modprobe.conf to load snd-intel8x0.  But
I never got any sound out of this default install no matter what I tried.

* Custom compiled the 2.6.9 kernel with no patches except the software
suspend 2 patch.  This built the version of the ALSA drivers that come
with 2.6.9.  Still no sound.

* Downloaded and compiled version 1.0.7 of the ALSA drivers and installed
them.  Still no sound.

======================================================================

----------------------------------------------------------------------
 bji - 11-21-04 03:16 
----------------------------------------------------------------------
Here's my /etc/modprobe.conf if it helps:

# Ethernet
alias eth0 8139too

# USB
alias usb-controller ehci-hcd
alias usb-controller1 uhci-hcd

# ALSA
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=0
install snd-intel8x0 /sbin/modprobe --ignore-install snd-intel8x0 &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd-intel8x0 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-slot 1 snd-card-1

# Intel Sound
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

----------------------------------------------------------------------
 bji - 11-21-04 03:19 
----------------------------------------------------------------------
Here are the modules that are installed after my system boots:

Module                  Size  Used by
snd_pcm_oss            55208  0 
snd_mixer_oss          19712  1 snd_pcm_oss
snd_intel8x0           36924  1 
snd_ac97_codec         76896  1 snd_intel8x0
snd_pcm               111240  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              34948  1 snd_pcm
snd                    61156  8
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              11360  1 snd
snd_page_alloc         10504  2 snd_intel8x0,snd_pcm
uhci_hcd               34960  0 
ehci_hcd               37380  0 
ipw2100               146372  0 
ieee80211              35908  1 ipw2100
i915                   86788  3 
md5                     4608  1 
ipv6                  272320  8 
ds                     19204  2 
ipt_REJECT              7296  1 
ipt_state               2176  1 
ip_conntrack           45876  1 ipt_state
iptable_filter          3200  1 
ip_tables              18048  3 ipt_REJECT,ipt_state,iptable_filter
dm_mod                 62740  0 
button                  6928  0 
battery                 9220  0 
ac                      5124  0 
yenta_socket           20864  0 
pcmcia_core            67396  2 ds,yenta_socket
arc4                    2176  1 
ieee80211_crypt_wep     5376  1 
ieee80211_crypt         7684  2 ieee80211,ieee80211_crypt_wep
8139too                30336  0 
mii                     5504  1 8139too
ext3                  121576  1 
jbd                    90392  1 ext3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 02:53 bji            New Issue                                    
11-21-04 02:53 bji            Distribution              => Fedora Core 3   
11-21-04 02:53 bji            Kernel Version            => 2.6.9           
11-21-04 02:55 bji            Note Added: 0002481                          
11-21-04 02:56 bji            File Added: proc_asound.txt                    
11-21-04 03:16 bji            Note Added: 0002483                          
11-21-04 03:19 bji            Note Added: 0002484                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
