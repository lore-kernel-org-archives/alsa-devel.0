From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 08/15] ALSA: cs4236: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:23 +0530
Message-ID: <1502964390-6927-9-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E898C267665
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:18 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 123so9098024pga.5
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:18 -0700 (PDT)
In-Reply-To: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, dhowells@redhat.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pnp_card_device_id are not supposed to change at runtime. All functions
working with pnp_card_device_id provided by <linux/pnp.h> work with
const pnp_card_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/cs423x/cs4236.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 1f9a3b2..14bba64 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -149,7 +149,7 @@ static const struct pnp_device_id snd_cs423x_pnpbiosids[] = {
 MODULE_DEVICE_TABLE(pnp, snd_cs423x_pnpbiosids);
 
 #define CS423X_ISAPNP_DRIVER	"cs4232_isapnp"
-static struct pnp_card_device_id snd_cs423x_pnpids[] = {
+static const struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* Philips PCA70PS */
 	{ .id = "CSC0d32", .devs = { { "CSC0000" }, { "CSC0010" }, { "PNPb006" } } },
 	/* TerraTec Maestro 32/96 (CS4232) */
-- 
2.7.4
