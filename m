From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 12/15] ALSA: opti9xx: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:27 +0530
Message-ID: <1502964390-6927-13-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/opti9xx/miro.c           | 2 +-
 sound/isa/opti9xx/opti92x-ad1848.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index bcbff56..3f760b3 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -143,7 +143,7 @@ static int snd_miro_pnp_is_probed;
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_miro_pnpids[] = {
+static const struct pnp_card_device_id snd_miro_pnpids[] = {
 	/* PCM20 and PCM12 in PnP mode */
 	{ .id = "MIR0924",
 	  .devs = { { "MIR0000" }, { "MIR0002" }, { "MIR0005" } }, },
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index ceddb39..040f06f 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -151,7 +151,7 @@ static int snd_opti9xx_pnp_is_probed;
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_opti9xx_pnpids[] = {
+static const struct pnp_card_device_id snd_opti9xx_pnpids[] = {
 #ifndef OPTi93X
 	/* OPTi 82C924 */
 	{ .id = "OPT0924",
-- 
2.7.4
