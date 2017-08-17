From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/15] ALSA: ad1816a: constify
	pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:19 +0530
Message-ID: <1502964390-6927-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C538026763C
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:09 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 123so9097212pga.5
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:09 -0700 (PDT)
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
 sound/isa/ad1816a/ad1816a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 7692265..4be6c12 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -63,7 +63,7 @@ MODULE_PARM_DESC(enable, "Enable ad1816a based soundcard.");
 module_param_array(clockfreq, int, NULL, 0444);
 MODULE_PARM_DESC(clockfreq, "Clock frequency for ad1816a driver (default = 0).");
 
-static struct pnp_card_device_id snd_ad1816a_pnpids[] = {
+static const struct pnp_card_device_id snd_ad1816a_pnpids[] = {
 	/* Analog Devices AD1815 */
 	{ .id = "ADS7150", .devs = { { .id = "ADS7150" }, { .id = "ADS7151" } } },
 	/* Analog Device AD1816? */
-- 
2.7.4
