From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH v7 0/3] Huawei laptops
Date: Mon, 26 Nov 2018 21:57:46 -0500
Message-ID: <20181127025752.6459-1-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
Cc: ayman.bagabas@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch set is based on new audio LED triggers in branch topic/leds-trigger from
	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes from v6:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  15 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 247 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 285 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.1
