From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 00/11] Add ZxR support + bugfixes
Date: Sat, 29 Sep 2018 23:03:15 -0400
Message-ID: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch series adds support for the Sound Blaster ZxR, as well as a
few bug fixes. This should be the last ca0132 based Creative card that
needed support to be added.

Also, I did check to make sure each patch compiles properly this time,
but you can check yourself just to be sure. :)

Connor McAdams (11):
  ALSA: hda/ca0132 - Fix AE-5 control type
  ALSA: hda/ca0132 - Fix surround sound with output effects
  ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
  ALSA: hda/ca0132 - Add ZxR pincfg
  ALSA: hda/ca0132 - Add DBpro hda_codec_ops
  ALSA: hda/ca0132 - Add ZxR init commands
  ALSA: hda/ca0132 - Add ZxR DSP post-download commands
  ALSA: hda/ca0132 - Add ZxR input/output select commands
  ALSA: hda/ca0132 - Remove input select enum for ZxR
  ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
  ALSA: hda/ca0132 - Add ZxR exit commands

 sound/pci/hda/patch_ca0132.c | 369 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 345 insertions(+), 24 deletions(-)

-- 
2.7.4
