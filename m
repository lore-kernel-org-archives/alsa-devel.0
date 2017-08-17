From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/15] ALSA: cmi8330: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:22 +0530
Message-ID: <1502964390-6927-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/cmi8330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index f64b29a..6b8c469 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -182,7 +182,7 @@ struct snd_cmi8330 {
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_cmi8330_pnpids[] = {
+static const struct pnp_card_device_id snd_cmi8330_pnpids[] = {
 	{ .id = "CMI0001", .devs = { { "@X@0001" }, { "@@@0001" }, { "@H@0001" }, { "A@@0001" } } },
 	{ .id = "CMI0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } } },
 	{ .id = "" }
-- 
2.7.4
