From: "Robas, Teodor" <teodor.robas@gmail.com>
Subject: ALSA-SOC support for OpenRD Client/Ultimate
Date: Thu, 11 Nov 2010 08:45:54 +0200
Message-ID: <4CDB9122.20706@gmail.com>
Reply-To: teodor.robas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7622E24406
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 07:45:58 +0100 (CET)
Received: by bwz8 with SMTP id 8so1595023bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 22:45:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello everyone,


I am writing to this list in the hope that somebody can clear me out
if this platform is supported and I am doing something wrong, or if
it is still work in progress.

The drivers that I think should work with my hardware (OpenRD ultimate)
are located in sound/soc/kirkwood/*.

Sound on this device worked (partially) with the default software
it came but not with the latest about 10 kernels I have tried.

I added bellow the output of alsa-info.sh script. If needed I can look
for more or try to fix it (with some help).


Best Regards,
Teodor



!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Thu Nov 11 06:27:39 UTC 2010


!!Linux Distribution
!!------------------

Debian GNU/Linux squeeze/sid \n \l


!!DMI Information
!!---------------

Manufacturer:
Product Name:


!!Kernel Information
!!------------------

Kernel release:    2.6.37-rc1
Operating System:  GNU/Linux
Architecture:      armv5tel
Processor:         unknown
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.23
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

--- no soundcards ---


!!PCI Soundcards installed in the system
!!--------------------------------------



!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------



!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-pcsp: index=-2
snd-usb-audio: index=-2


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 33 Nov 11 08:23 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:235: no soundcards found...

ARECORD

arecord: device_list:235: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_soc_kirkwood
snd_soc_core
snd_pcm
snd_timer
snd
snd_page_alloc
bridge
stp
llc
nfsd
lockd
nfs_acl
auth_rpcgss
sunrpc
exportfs
loop
xgifb
fb
cfbcopyarea
mv_cesa
cfbimgblt
aes_generic
cfbfillrect
sd_mod
crc_t10dif
usb_storage
sata_mv
libata
ehci_hcd
scsi_mod
usbcore
mv643xx_eth
libphy
nls_base


!!ALSA/HDA dmesg
!!------------------


PS: please note that none of the snd* modules are loaded by default.

PPS: Somewhere in the code (sound/soc/kirkwood/kirkwood-openrd.c)
there is a check: machine_is_openrd_client() but in my case it should
be machine_is_openrd_ultimate(). I removed this check anyway.


-- 
  _
( )   ascii ribbon campaign - against html e-mail
  X    www.asciiribbon.org   - against proprietary attachments
/ \
