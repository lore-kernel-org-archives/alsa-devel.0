From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 15/15] ALSA: wavefront: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:30 +0530
Message-ID: <1502964390-6927-16-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/wavefront/wavefront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index da4e9a8..b1989fa 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(use_cs4232_midi, "Use CS4232 MPU-401 interface (inaccessibly lo
 static int isa_registered;
 static int pnp_registered;
 
-static struct pnp_card_device_id snd_wavefront_pnpids[] = {
+static const struct pnp_card_device_id snd_wavefront_pnpids[] = {
 	/* Tropez */
 	{ .id = "CSC7532", .devs = { { "CSC0000" }, { "CSC0010" }, { "PnPb006" }, { "CSC0004" } } },
 	/* Tropez+ */
-- 
2.7.4
