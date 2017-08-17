From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 05/15] ALSA: als100: constify pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:20 +0530
Message-ID: <1502964390-6927-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D4A2267640
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:12 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id 83so9124062pgb.4
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:11 -0700 (PDT)
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
 sound/isa/als100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index bc9ea30..dde6ba4 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -79,7 +79,7 @@ struct snd_card_als100 {
 	struct snd_sb *chip;
 };
 
-static struct pnp_card_device_id snd_als100_pnpids[] = {
+static const struct pnp_card_device_id snd_als100_pnpids[] = {
 	/* DT197A30 */
 	{ .id = "RWB1688",
 	  .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } },
-- 
2.7.4
