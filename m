From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH v11 0/3] Huawei laptops
Date: Wed, 12 Dec 2018 18:07:56 -0500
Message-ID: <20181212230802.21140-1-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
Cc: ayman.bagabas@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch set is based on the new audio LED triggers in topic/leds-trigger branch from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes in v11:
* Minor code changes

Changes in v10:
* Use ec_get_handle instead of acpi_get_handle since we are using the ec device
* Switch to WMI0_EXPENSIVE_GUID and wmi_query_block to fetch keycode when WMI0 is used

Changes in v9:
* Explicitly use NULL in acpi_get_handle
* Drop __initconst from huawei_wmi_keymap

Changes in v8:
* Switch to wmi_driver
* Use devm to allocate and manage devices
* Skip registering LED subsystem if a ACPI controller method was not found

Changes in v7:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Changes in v6:
* Review tags

Changes in v5:
* Consistency in file names
* How module would be enabled (Kconfig)
* Match license in SPDX and MODULE_LICENSE 

Changes in v4:
* Code formatting

Changes in v3:
* Support for Huawei MBX
* Style and formatting issues

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  17 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 208 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 ++++
 4 files changed, 248 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.2
