From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 11/15] ALSA: msnd: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:26 +0530
Message-ID: <1502964390-6927-12-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/msnd/msnd_pinnacle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index ad48973..86db009 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -1191,7 +1191,7 @@ static void snd_msnd_pnp_remove(struct pnp_card_link *pcard)
 static int isa_registered;
 static int pnp_registered;
 
-static struct pnp_card_device_id msnd_pnpids[] = {
+static const struct pnp_card_device_id msnd_pnpids[] = {
 	/* Pinnacle PnP */
 	{ .id = "BVJ0440", .devs = { { "TBS0000" }, { "TBS0001" } } },
 	{ .id = "" }	/* end */
-- 
2.7.4
