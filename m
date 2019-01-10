From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/5] ALSA: hda: add register offset for stripe
	control
Date: Thu, 10 Jan 2019 22:33:23 +0530
Message-ID: <1547139805-1904-3-git-send-email-spujar@nvidia.com>
References: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF1B267548
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 18:03:53 +0100 (CET)
In-Reply-To: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
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

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
---
 include/sound/hda_register.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 2ab39fb..5b1f5d8 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -79,6 +79,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 
 /* stream register offsets from stream base */
 #define AZX_REG_SD_CTL			0x00
+#define AZX_REG_SD_CTL_3B		0x02 /* 3rd byte of SD_CTL register */
 #define AZX_REG_SD_STS			0x03
 #define AZX_REG_SD_LPIB			0x04
 #define AZX_REG_SD_CBL			0x08
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
