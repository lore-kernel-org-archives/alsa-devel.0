From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH v1 0/2] Huawei WMI laptop extras driver
Date: Mon, 13 May 2019 16:30:04 -0400
Message-ID: <20190513203009.28686-1-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Jian-Hong Pan <jian-hong@endlessm.com>, Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>, Hui Wang <hui.wang@canonical.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: ayman.bagabas@gmail.com
List-Id: alsa-devel@alsa-project.org

Using the WMI BIOS management interface found on Huawei laptops, extra features
such as micmute LED, charging thresholds, and fn-lock can be controlled.

A platform driver has been implemented along with the existing WMI driver. The
platform driver controls the LED, battery charging thresholds, and fn-lock.

We enable sound micmute hooks to platform driver on Huawei laptops to get the
LED to work.

Ayman Bagabas (2):
  platform/x86: Huawei WMI laptop extras driver update
  sound: Enable micmute led for Huawei laptops

 drivers/platform/x86/Kconfig      |   8 +-
 drivers/platform/x86/huawei-wmi.c | 578 +++++++++++++++++++++++++-----
 sound/pci/hda/patch_realtek.c     |   9 +-
 3 files changed, 504 insertions(+), 91 deletions(-)

-- 
2.20.1
