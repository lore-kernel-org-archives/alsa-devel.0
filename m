From: Dan Carpenter <error27@gmail.com>
Subject: [patch] oxygen: change || to &&
Date: Wed, 3 Mar 2010 10:08:18 +0300
Message-ID: <20100303070818.GD5086@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the original code the condition was always true (hopefully) because
WM8776_HPLVOL is zero.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 7754db1..dbc4b89 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -68,7 +68,7 @@ static void wm8776_write(struct oxygen *chip,
 			 OXYGEN_SPI_CEN_LATCH_CLOCK_LO,
 			 (reg << 9) | value);
 	if (reg < ARRAY_SIZE(data->wm8776_regs)) {
-		if (reg >= WM8776_HPLVOL || reg <= WM8776_DACMASTER)
+		if (reg >= WM8776_HPLVOL && reg <= WM8776_DACMASTER)
 			value &= ~WM8776_UPDATE;
 		data->wm8776_regs[reg] = value;
 	}
