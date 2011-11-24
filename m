From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] firmware: Sigma: Skip header during CRC
	generation
Date: Thu, 24 Nov 2011 13:48:21 +0100
Message-ID: <1322138908-32127-2-git-send-email-lars@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DB4A1037FC
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 13:47:47 +0100 (CET)
In-Reply-To: <1322138908-32127-1-git-send-email-lars@metafoo.de>
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
index 5b17966..b1ab32a6 100644
--- a/drivers/firmware/sigma.c
+++ b/drivers/firmware/sigma.c
@@ -124,7 +124,8 @@ int process_sigma_firmware(struct i2c_client *client, const char *name)
 	if (memcmp(ssfw_head->magic, SIGMA_MAGIC, ARRAY_SIZE(ssfw_head->magic)))
 		goto done;
 
-	crc = crc32(0, fw->data, fw->size);
+	crc = crc32(0, fw->data + sizeof(*ssfw_head),
+			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
 	if (crc != ssfw_head->crc)
 		goto done;
-- 
1.7.7.1
