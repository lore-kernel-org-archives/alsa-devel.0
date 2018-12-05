From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 0/3] Add ALC294 quirks for ASUS laptops
Date: Wed,  5 Dec 2018 15:42:09 +0800
Message-ID: <20181205074212.31104-1-jian-hong@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add Realtek ALC294 quirks for ASUS X542UN, UX533FD and UX433FN laptops.

Chris Chiu (1):
  ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Jian-Hong Pan (2):
  ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
  ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN with ALC294

 sound/pci/hda/patch_realtek.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.11.0
