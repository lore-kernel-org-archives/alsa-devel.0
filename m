From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: fix SND_PCM_TIMER Kconfig text
Date: Wed, 27 Jan 2016 18:04:10 -0800
Message-ID: <56A9771A.1000508@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jie Yang <yang.jie@intel.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix spelling and typos for SND_PCM_TIMER.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jie Yang <yang.jie@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/core/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-45-rc1.orig/sound/core/Kconfig
+++ lnx-45-rc1/sound/core/Kconfig
@@ -97,11 +97,11 @@ config SND_PCM_TIMER
 	bool "PCM timer interface" if EXPERT
 	default y
 	help
-	  If you disable this option, pcm timer will be inavailable, so
-	  those stubs used pcm timer (e.g. dmix, dsnoop & co) may work
+	  If you disable this option, pcm timer will be unavailable, so
+	  those stubs that use pcm timer (e.g. dmix, dsnoop & co) may work
 	  incorrectlly.
 
-	  For some embedded device, we may disable it to reduce memory
+	  For some embedded devices, we may disable it to reduce memory
 	  footprint, about 20KB on x86_64 platform.
 
 config SND_SEQUENCER_OSS
