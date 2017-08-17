From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/15] ALSA: es18xx: constify pnp_device_id and
	pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:17 +0530
Message-ID: <1502964390-6927-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C6565267631
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:05 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id u185so9136128pgb.0
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:04 -0700 (PDT)
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

*_device_id are not supposed to change at runtime. All functions
working with *_device_id provided by <linux/pnp.h> work with
const *_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/es18xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index ae17a65..5d4a30a 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2017,7 +2017,7 @@ static int isa_registered;
 static int pnp_registered;
 static int pnpc_registered;
 
-static struct pnp_device_id snd_audiodrive_pnpbiosids[] = {
+static const struct pnp_device_id snd_audiodrive_pnpbiosids[] = {
 	{ .id = "ESS1869" },
 	{ .id = "ESS1879" },
 	{ .id = "" }		/* end */
@@ -2062,7 +2062,7 @@ static int snd_audiodrive_pnp(int dev, struct snd_es18xx *chip,
 	return 0;
 }
 
-static struct pnp_card_device_id snd_audiodrive_pnpids[] = {
+static const struct pnp_card_device_id snd_audiodrive_pnpids[] = {
 	/* ESS 1868 (integrated on Compaq dual P-Pro motherboard and Genius 18PnP 3D) */
 	{ .id = "ESS1868", .devs = { { "ESS1868" }, { "ESS0000" } } },
 	/* ESS 1868 (integrated on Maxisound Cards) */
-- 
2.7.4
