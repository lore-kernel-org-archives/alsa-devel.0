From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/7] firmware: Sigma: Skip header during CRC
	generation
Date: Mon, 28 Nov 2011 09:44:15 +0100
Message-ID: <1322469860-8210-2-git-send-email-lars@metafoo.de>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) by alsa0.perex.cz (Postfix) with ESMTP id CA4CE24542
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 09:43:27 +0100 (CET)
In-Reply-To: <1322469860-8210-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

The firmware header is not part of the CRC, so skip it. Otherwise the firmware
will be rejected due to non-matching CRCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org
---
 drivers/firmware/sigma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/firmware/sigma.c b/drivers/firmware/sigma.c
index c780baa..36265de 100644
--- a/drivers/firmware/sigma.c
+++ b/drivers/firmware/sigma.c
@@ -130,7 +130,8 @@ int process_sigma_firmware(struct i2c_client *client, const char *name)
 	if (memcmp(ssfw_head->magic, SIGMA_MAGIC, ARRAY_SIZE(ssfw_head->magic)))
 		goto done;
 
-	crc = crc32(0, fw->data, fw->size);
+	crc = crc32(0, fw->data + sizeof(*ssfw_head),
+			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
 	if (crc != ssfw_head->crc)
 		goto done;
-- 
1.7.7.3
