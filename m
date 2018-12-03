From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH v9 0/3] Huawei laptops
Date: Mon,  3 Dec 2018 13:53:37 -0500
Message-ID: <20181203185344.3521-1-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
Cc: ayman.bagabas@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch set is based on new audio LED triggers in branch topic/leds-trigger from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes from v8:
* Explicitly use NULL in acpi_get_handle
* Drop __initconst from huawei_wmi_keymap

Changes from v7:
* Switch to wmi_driver
* Use devm to allocate and manage devices
* Skip registering LED subsystem if a ACPI controller method was not found

Changes from v6:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Changes from v5:
* Review tags

Changes from v4:
* Consistency in file names
* How module would be enabled (Kconfig)
* Match license in SPDX and MODULE_LICENSE 

Changes from v3:
* Code formatting

Changes from v2:
* Support for Huawei MBX
* Style and formatting issues

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  16 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 265 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.2
