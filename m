From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v3 0/3] Add ALC294 quirks for ASUS laptops
Date: Fri,  7 Dec 2018 17:17:10 +0800
Message-ID: <20181207091713.7483-1-jian-hong@endlessm.com>
References: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, josh@wtmec.com, Jian-Hong Pan <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add Realtek ALC294 quirks for ASUS X542UN, UX533FD, UX433FN and UX333FA laptops.

Chris Chiu (1):
  ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Jian-Hong Pan (2):
  ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
  ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with
    ALC294

 sound/pci/hda/patch_realtek.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- 
2.11.0
