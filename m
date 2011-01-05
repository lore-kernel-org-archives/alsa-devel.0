From: Nirbheek Chauhan <nirbheek.chauhan@gmail.com>
Subject: [bisected] snd_hda_intel, 2.6.37: automuting on headphone connect
 broken; headphone connecter no longer shown in userspace
Date: Wed, 5 Jan 2011 13:07:41 +0530
Message-ID: <AANLkTi=Fza-mJyAKtsryAUMMgPoXur4oQ6F2keBmxF6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, arun@accosted.net
List-Id: alsa-devel@alsa-project.org

Hello,

Upon upgrading to 2.6.37,
auto-muting-laptop-speakers-on-headphone-connect stopped working, and
the headphone connector completely disappeared from alsamixer as well
as the pulseaudio volume control panel. The headphone jack was still
transmitting sound, though.

I bisected the problem, with 'good' being v2.6.36, and found the
commit below as the first bad commit. Reverting it on v2.6.37 fixes
the problem. I also tried the latest alsa-kernel master git tree,
which had the same problem.

alsa-info when 'good':

http://www.alsa-project.org/db/?f=a0b5c95f764a0b01746be46f989685996e1f9210

alsa-info when 'bad':

http://www.alsa-project.org/db/?f=30f30ca5461f03b98ab6c7c611cf24ea4526f537

Note: both were taken without X running, before pulseaudio came up.

================
03642c9a444079aa13f0864383a8f9ca04bfd198 is the first bad commit
commit 03642c9a444079aa13f0864383a8f9ca04bfd198
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Sep 8 15:28:19 2010 +0200

    ALSA: hda - Clear left-over hp_pins in snd_hda_parse_pin_def_config()

    In snd_hda_parse_def_config(), some unused values may remain in hp_pins[]
    array during the headphone-reassignment workaround.  This patch clears
    the unused array members.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 34724336a75f74263423f28d64450d65e5ed948d
8d136fce8661ad2df35ac3c4a9ca1c712c9833ed M	sound

================

The patch was:

================
>From 03642c9a444079aa13f0864383a8f9ca04bfd198 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 8 Sep 2010 15:28:19 +0200
Subject: [PATCH] ALSA: hda - Clear left-over hp_pins in
snd_hda_parse_pin_def_config()

In snd_hda_parse_def_config(), some unused values may remain in hp_pins[]
array during the headphone-reassignment workaround.  This patch clears
the unused array members.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2980c27..bfdde7b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4558,6 +4558,8 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
                        memmove(sequences_hp + i, sequences_hp + i + 1,
                                sizeof(sequences_hp[0]) * (cfg->hp_outs - i));
                }
+               memset(cfg->hp_pins + cfg->hp_outs, 0,
+                      sizeof(hda_nid_t) * (AUTO_CFG_MAX_OUTS - cfg->hp_outs));
        }

        /* sort by sequence */
-- 
1.7.2.2
================

-- 
~Nirbheek Chauhan

Gentoo GNOME+Mozilla Team
