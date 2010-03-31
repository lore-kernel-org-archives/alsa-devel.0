From: Wu Fengguang <fengguang.wu@intel.com>
Subject: pulseaudio module-udev-detect failure on 2.6.34-rc1
Date: Wed, 31 Mar 2010 12:40:16 +0800
Message-ID: <20100331044016.GA17684@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FB1F103814
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 06:40:20 +0200 (CEST)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

Greetings,

Pulseaudio can no longer detect sound cards on kernel 2.6.34-rc1.
Note that 2.6.33 is OK.

I noticed that the related sysfs directories/files changed.
Note that the card0/ directory is gone in new kernel:

2.6.33
wfg@hp ~% ll /sys/class/sound                          
total 0
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 timer -> ../../devices/virtual/sound/timer
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 pcmC0D1p -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/pcmC0D1p
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 pcmC0D0p -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/pcmC0D0p
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 pcmC0D0c -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/pcmC0D0c
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 mixer5 -> ../../devices/platform/thinkpad_acpi/sound/card5/mixer5
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 mixer -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/mixer
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 hwC0D0 -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 dsp -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/dsp
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 controlC5 -> ../../devices/platform/thinkpad_acpi/sound/card5/controlC5
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 controlC0 -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/controlC0
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 card5 -> ../../devices/platform/thinkpad_acpi/sound/card5
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 card0 -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 audio -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/audio
lrwxrwxrwx 1 root root 0 2010-03-31 12:23 adsp -> ../../devices/pci0000:00/0000:00:1b.0/sound/card0/adsp

2.6.34-rc1
wfg@hp ~% ll /sys/class/sound                          
total 0
drwxr-xr-x 3 root root 0 2010-03-31 19:27 timer
drwxr-xr-x 3 root root 0 2010-03-31 19:27 pcmC0D7p
drwxr-xr-x 3 root root 0 2010-03-31 19:27 pcmC0D3p
drwxr-xr-x 3 root root 0 2010-03-31 19:27 pcmC0D0p
drwxr-xr-x 3 root root 0 2010-03-31 19:27 pcmC0D0c
drwxr-xr-x 3 root root 0 2010-03-31 19:27 hwC0D3
drwxr-xr-x 3 root root 0 2010-03-31 19:27 hwC0D0
drwxr-xr-x 3 root root 0 2010-03-31 19:27 controlC0

Any ideas?

Thanks,
Fengguang
