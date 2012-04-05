From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 0/6] sound/pci/hda: CX20549 cleanup/fixes
Date: Thu, 05 Apr 2012 15:29:37 +0200
Message-ID: <1333632577.4159.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This series of patches fixes recording on a Gigabyte W551N laptop that
seems to be identical to the BenW R55E. The Audio Codec uses the same
subsystem ID, which is assigned to Quanta. The Gigabyte laptop is based
on the Quanta TW3 ODM.

(for the whole series)
Signed-Off-By: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
