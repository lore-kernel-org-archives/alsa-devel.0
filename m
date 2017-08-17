From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/15] ALSA: es1688: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:24 +0530
Message-ID: <1502964390-6927-10-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/es1688/es1688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 36320e7..a826c13 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -321,7 +321,7 @@ static int snd_es968_pnp_resume(struct pnp_card_link *pcard)
 }
 #endif
 
-static struct pnp_card_device_id snd_es968_pnpids[] = {
+static const struct pnp_card_device_id snd_es968_pnpids[] = {
 	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
 	{ .id = "ESS0968", .devs = { { "ESS0968" }, } },
 	{ .id = "", } /* end */
-- 
2.7.4
