From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 03/15] ALSA: opl3sa2: constify pnp_device_id and pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:18 +0530
Message-ID: <1502964390-6927-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

*_device_id are not supposed to change at runtime. All functions
working with *_device_id provided by <linux/pnp.h> work with
const *_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/opl3sa2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 4098e3e0..7cce4cd 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -141,7 +141,7 @@ struct snd_opl3sa2 {
 
 #ifdef CONFIG_PNP
 
-static struct pnp_device_id snd_opl3sa2_pnpbiosids[] = {
+static const struct pnp_device_id snd_opl3sa2_pnpbiosids[] = {
 	{ .id = "YMH0021" },
 	{ .id = "NMX2210" },	/* Gateway Solo 2500 */
 	{ .id = "" }		/* end */
@@ -149,7 +149,7 @@ static struct pnp_device_id snd_opl3sa2_pnpbiosids[] = {
 
 MODULE_DEVICE_TABLE(pnp, snd_opl3sa2_pnpbiosids);
 
-static struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
+static const struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
 	{ .id = "YMH0020", .devs = { { "YMH0021" } } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-- 
2.7.4
