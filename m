From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 3/5] ALSA: hda: add register offset for
	stripe control
Date: Mon, 14 Jan 2019 23:51:10 +0530
Message-ID: <1547490072-30940-4-git-send-email-spujar@nvidia.com>
References: <1547490072-30940-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 703C0266AD7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 19:21:48 +0100 (CET)
In-Reply-To: <1547490072-30940-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

bits 16:17 in SD_CTL register refer to stripe control. Added an
offset register(AZX_REG_SD_CTL_3B) to have exclusive read/write
of corresponding register byte. This helps to avoid unnecessary
32-bit read/write of SD_CTL whenever only stripe or other bits of
corresponding byte need to be updated. Also HD audio spec defines
SD_CTL as 3 byte register.

SD_CTL_STRIPE_MASK(0x3) can be used for stripe control programming
and when updating AZX_REG_SD_CTL_3B.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hda_register.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 2ab39fb..0fd3929 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -79,6 +79,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 
 /* stream register offsets from stream base */
 #define AZX_REG_SD_CTL			0x00
+#define AZX_REG_SD_CTL_3B		0x02 /* 3rd byte of SD_CTL register */
 #define AZX_REG_SD_STS			0x03
 #define AZX_REG_SD_LPIB			0x04
 #define AZX_REG_SD_CBL			0x08
@@ -165,6 +166,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define SD_INT_COMPLETE		0x04	/* completion interrupt */
 #define SD_INT_MASK		(SD_INT_DESC_ERR|SD_INT_FIFO_ERR|\
 				 SD_INT_COMPLETE)
+#define SD_CTL_STRIPE_MASK	0x3	/* stripe control mask */
 
 /* SD_STS */
 #define SD_STS_FIFO_READY	0x20	/* FIFO ready */
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
