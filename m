From: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Subject: Using Alsa for AD1981b on 9263
Date: Tue, 28 Jul 2009 16:59:12 +0530
Message-ID: <33A0EEB8D50198449794A1AB9DEB1E01866417CA0C@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from colaex01.coreobjects.com (mailus.coreobjects.com [67.89.120.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 8138F24663
	for <Alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 13:34:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Addition to my earlier post:

We are using AT91SAM9263 evaluation kit with on-board AD1981b codec. We are using Linux kernel version 2.6.27 with patches available on http://linux4sam.com. We found from the forum that we need to use ALSA for playing and recording audio using this codec.

So we downloaded
Alsa-lib-1.0.20
Alsa-oss-1.0.20
Alsa-utils-1.0.20

We installed above using:
./configure && make && make install

We then downloaded alsa-driver-1.0.20 and installed it using below:
./configure --with-cards=atmel-ac97c --with-kernel=../../linux-2.6.27 --with-build=../../linux-2.6.27 && make ARCH=arm && make install-modules

Driver was compiled and installed successfully.

We found following:
# cat /proc/asound/cards
 0 [AC97           ]: ac97c - Atmel AC97
                      Atmel AC97 Controller at 0xfffa0000, irq 18

# lsmod
Module                  Size  Used by    Not tainted
snd_at91_ac97           8420  0
snd_ac97_codec         99904  1 snd_at91_ac97
snd_soc_atmel_pcm       4484  0
snd_soc_core           30852  1 snd_soc_atmel_pcm
snd_pcm                60772  4 snd_at91_ac97,snd_ac97_codec,snd_soc_atmel_pcm,s
nd_soc_core
snd_page_alloc          6056  1 snd_pcm
snd_timer              19588  1 snd_pcm
snd                    47700  5 snd_at91_ac97,snd_ac97_codec,snd_soc_core,snd_pc
m,snd_timer
soundcore               6052  1 snd
ac97_bus                1568  1 snd_ac97_codec

# cat /home/.asoundrc
pcm.!default { type hw card 0 } ctl.!default { type hw card 0 }

We have following devices in /dev/snd
# cat /dev/snd/
/dev/snd/controlC0  /dev/snd/controlC3  /dev/snd/hwC0D2     /dev/snd/timer
/dev/snd/controlC1  /dev/snd/hwC0D0     /dev/snd/hwC0D3
/dev/snd/controlC2  /dev/snd/hwC0D1     /dev/snd/seq

# aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:2700:(snd_config_hooks_call) Cannot open shared library (null)
ALSA lib conf.c:3079:(snd_config_update_r) hooks failed, removing configuration
aplay: device_list:232: control open (0): No such file or directory

We are not able to get if module is getting loaded, then why aplay doesn't list the device?

Please help us to get the audio codec working.

Regards,
--Shilpa.
