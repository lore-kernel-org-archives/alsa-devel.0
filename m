From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/15] ALSA: gus: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:25 +0530
Message-ID: <1502964390-6927-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/gus/interwave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 0687b7e..a6fc26b 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -136,7 +136,7 @@ struct snd_interwave {
 static int isa_registered;
 static int pnp_registered;
 
-static struct pnp_card_device_id snd_interwave_pnpids[] = {
+static const struct pnp_card_device_id snd_interwave_pnpids[] = {
 #ifndef SNDRV_STB
 	/* Gravis UltraSound Plug & Play */
 	{ .id = "GRV0001", .devs = { { .id = "GRV0000" } } },
-- 
2.7.4
