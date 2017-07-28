From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 3/5] ALSA: pci: constify snd_timer_hardware structures
Date: Fri, 28 Jul 2017 18:38:28 +0530
Message-ID: <1501247311-19803-4-git-send-email-bhumirks@gmail.com>
References: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structures as const as their only usage
is during a copy operation. As they are not modified anywhere, they
can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/emu10k1/timer.c      | 2 +-
 sound/pci/ymfpci/ymfpci_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/timer.c b/sound/pci/emu10k1/timer.c
index b69a7f8..cf43908 100644
--- a/sound/pci/emu10k1/timer.c
+++ b/sound/pci/emu10k1/timer.c
@@ -66,7 +66,7 @@ static int snd_emu10k1_timer_precise_resolution(struct snd_timer *timer,
 	return 0;
 }
 
-static struct snd_timer_hardware snd_emu10k1_timer_hw = {
+static const struct snd_timer_hardware snd_emu10k1_timer_hw = {
 	.flags = SNDRV_TIMER_HW_AUTO,
 	.resolution = 20833, /* 1 sample @ 48KHZ = 20.833...us */
 	.ticks = 1024,
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 1114166..39b1d11 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1938,7 +1938,7 @@ static int snd_ymfpci_timer_precise_resolution(struct snd_timer *timer,
 	return 0;
 }
 
-static struct snd_timer_hardware snd_ymfpci_timer_hw = {
+static const struct snd_timer_hardware snd_ymfpci_timer_hw = {
 	.flags = SNDRV_TIMER_HW_AUTO,
 	.resolution = 10417, /* 1 / 96 kHz = 10.41666...us */
 	.ticks = 0x10000,
-- 
1.9.1
