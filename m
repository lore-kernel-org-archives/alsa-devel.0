From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 0/2] ALSA: hda: Widget memory fixes
Date: Wed, 26 Jun 2019 14:22:18 -0700
Message-ID: <20190626212220.239897-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org


This series fixes concurrency issues with the sysfs widget array. The first
function patches up the locking that was introduced recently to protect more
of the data structure. The second patch fixes a race between a reinit and the
initial population of the array which could result in a length and array
getting out of sync.


Changes in v2:
- Introduced widget_mutex relocation

Evan Green (2):
  ALSA: hda: Fix widget_mutex incomplete protection
  ALSA: hda: Use correct start/count for sysfs init

 sound/hda/hdac_device.c | 21 ++++++++++++++-------
 sound/hda/hdac_sysfs.c  | 18 ++++++++++--------
 sound/hda/local.h       |  3 ++-
 3 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.20.1
