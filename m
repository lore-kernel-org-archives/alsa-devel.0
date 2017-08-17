From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 14/15] ALSA: sscape: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:29 +0530
Message-ID: <1502964390-6927-15-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/sscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 1cd2908..733adee 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(joystick, "Enable gameport.");
 static int isa_registered;
 static int pnp_registered;
 
-static struct pnp_card_device_id sscape_pnpids[] = {
+static const struct pnp_card_device_id sscape_pnpids[] = {
 	{ .id = "ENS3081", .devs = { { "ENS0000" } } }, /* Soundscape PnP */
 	{ .id = "ENS4081", .devs = { { "ENS1011" } } },	/* VIVO90 */
 	{ .id = "" }	/* end */
-- 
2.7.4
