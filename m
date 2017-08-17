From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 13/15] ALSA: sb16: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:28 +0530
Message-ID: <1502964390-6927-14-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pnp_card_device_id are not supposed to change at runtime. All functions
working with pnp_card_device_id provided by <linux/pnp.h> work with
const pnp_card_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/sb/sb16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 917a93d..8f9ebeb 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -145,7 +145,7 @@ struct snd_card_sb16 {
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_sb16_pnpids[] = {
+static const struct pnp_card_device_id snd_sb16_pnpids[] = {
 #ifndef SNDRV_SBAWE
 	/* Sound Blaster 16 PnP */
 	{ .id = "CTL0024", .devs = { { "CTL0031" } } },
-- 
2.7.4
