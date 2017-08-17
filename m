From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/15] ALSA: drivers: mpu401: constify
	pnp_device_id
Date: Thu, 17 Aug 2017 15:36:16 +0530
Message-ID: <1502964390-6927-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B9BF26762B
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:02 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 123so9096696pga.5
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:02 -0700 (PDT)
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

pnp_device_id are not supposed to change at runtime. All functions
working with pnp_device_id provided by <linux/pnp.h> work with
const pnp_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/drivers/mpu401/mpu401.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index 9b86e00..b671576 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -148,7 +148,7 @@ static struct platform_driver snd_mpu401_driver = {
 
 #define IO_EXTENT 2
 
-static struct pnp_device_id snd_mpu401_pnpids[] = {
+static const struct pnp_device_id snd_mpu401_pnpids[] = {
 	{ .id = "PNPb006" },
 	{ .id = "" }
 };
-- 
2.7.4
