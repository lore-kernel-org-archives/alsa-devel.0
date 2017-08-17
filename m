From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/15] ALSA: azt2320: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:21 +0530
Message-ID: <1502964390-6927-7-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/azt2320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index fff186f..4e6fad4 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -79,7 +79,7 @@ struct snd_card_azt2320 {
 	struct snd_wss *chip;
 };
 
-static struct pnp_card_device_id snd_azt2320_pnpids[] = {
+static const struct pnp_card_device_id snd_azt2320_pnpids[] = {
 	/* PRO16V */
 	{ .id = "AZT1008", .devs = { { "AZT1008" }, { "AZT2001" }, } },
 	/* Aztech Sound Galaxy 16 */
-- 
2.7.4
