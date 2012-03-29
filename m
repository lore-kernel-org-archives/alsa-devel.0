From: madhukesh s <madhukeshs@gmail.com>
Subject: Setting up the alsa configuration from scratch on imx
Date: Thu, 29 Mar 2012 12:27:41 +0000
Message-ID: <CADT92ybh0+g9s6a4ETd2cD8+fE2EO7ycLAxfOw71J70cv_6-EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 50849104417
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 14:27:42 +0200 (CEST)
Received: by laap9 with SMTP id p9so2509035laa.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 05:27:41 -0700 (PDT)
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

Hi All,

I am in an unfortunate position of developing ALSA kernel modules
separately(as a kernel build) and populating the necessary files to a
filesystem. I am able to install all the ALSA modules on the board I am
working on successfully. Can someone point me to how to start with the
configuration part on the board to populate /proc and /dev entries?

My config(as per the alsa diagnostic script) is:

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################
!!Script ran on: Fri Mar  2 01:17:47 UTC 2012

!!Linux Distribution
!!------------------

!!DMI Information
!!---------------

Manufacturer:
Product Name:
Product Version:

!!Kernel Information
!!------------------

Kernel release:    2.6.38.8+
Operating System:  GNU/Linux
Architecture:      armv7l
Processor:         unknown
SMP Enabled:       No

!!ALSA Version
!!------------
Driver version:     1.0.23
Library version:
Utilities version:  1.0.24.2

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

!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

!!Loaded sound module options
!!--------------------------

!!ALSA Device nodes
!!-----------------
crw-rw---- 1 root audio 116, 33 Mar  2 00:01 /dev/snd/timer

!!Aplay/Arecord output
!!------------
APLAY
aplay: device_list:240: no soundcards found...

ARECORD
arecord: device_list:240: no soundcards found...

!!Amixer output
!!-------------

!!Alsactl output
!!-------------
--startcollapse--
--endcollapse--

!!All Loaded Modules
!!------------------
Module
snd_soc_imx_sgtl5000
snd_soc_core
snd_pcm
snd_timer
snd
snd_page_alloc
ac97_bus

!!ALSA/HDA dmesg
!!------------------
udevd (1296): /proc/1296/oom_adj is deprecated, please use
/proc/1296/oom_score_adj instead.
Cirrus Logic CS42888 ALSA SoC Codec Driver
i2c-core: driver [cs42888] using legacy suspend method

Thanks,
Maas
