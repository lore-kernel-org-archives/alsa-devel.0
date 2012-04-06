From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 0/6] ALSA: hda - CX20549 cleanup/fixes
Date: Fri,  6 Apr 2012 15:34:14 +0200
Message-ID: <1333719260-14504-1-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
References: <s5hk41ufe2j.wl%tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk41ufe2j.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is the revised patch series for the CX20549 (and related stuff)

Changes:
 Patch 1/6:
  - spec->single_adc_amp has been moved to codec->single_adc_amp
    to fix printing in /proc.
 Patch 2/6: 
  - "Line In" has been changed to "Line".
  - This change has also been performed on the Mixer Labels.
 Patch 4/6:
  - .num_items has been adjusted, too.
  - A comment about physical testing has been added to the commit message.
 Patch 5/6:
  - pin_amp_workaround is not set for CX20549 in auto-setup, too
