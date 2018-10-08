From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 0/4] Various cleanup + Mic Fix
Date: Mon,  8 Oct 2018 15:39:56 -0400
Message-ID: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set fixes the microphone inconsistency issue, which means
the microphone now works all the time on all of the cards I've tested
(ZxR, Z, AE-5), along with the input effects.

It also includes changes suggested by Takashi Sakamoto, I believe I did
what he asked properly, but if I messed it up I'm sure you guys will
let me know.

This should finish up most of the ca0132 work, with all inputs and
outputs working on the desktop cards.

Connor McAdams (4):
  ALSA: hda/ca0132 - Fix microphone inconsistency issues
  ALSA: hda/ca0132 - Clean up patch_ca0132()
  ALSA: hda/ca0132 - Add error checking in ca0132_build_controls()
  ALSA: hda/ca0132 - Fix input effect controls for desktop cards

 sound/pci/hda/patch_ca0132.c | 75 +++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 21 deletions(-)

-- 
2.7.4
