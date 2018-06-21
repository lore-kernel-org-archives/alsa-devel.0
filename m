From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: hda/ca0132: make array ca0132_alt_chmaps static
Date: Thu, 21 Jun 2018 19:34:57 +0100
Message-ID: <20180621183457.31008-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The array ca0132_alt_chmaps is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
warning: symbol 'ca0132_alt_chmaps' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d62c56feaf7d..4ff5320378e2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5665,7 +5665,7 @@ static const char * const ca0132_alt_slave_pfxs[] = {
  * I think this has to do with the pin for rear surround being 0x11,
  * and the center/lfe being 0x10. Usually the pin order is the opposite.
  */
-const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
+static const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
 	{ .channels = 2,
 	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
 	{ .channels = 4,
-- 
2.17.0
