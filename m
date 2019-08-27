From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/6] ASoC: Intel: Skylake: Use correct function to access iomem space
Date: Tue, 27 Aug 2019 16:17:07 +0200
Message-ID: <20190827141712.21015-2-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

For copying from __iomem, we should use __ioread32_copy.

reported by sparse:
sound/soc/intel/skylake/skl-debug.c:437:34: warning: incorrect type in argument 1 (different address spaces)
sound/soc/intel/skylake/skl-debug.c:437:34:    expected void [noderef] <asn:2> *to
sound/soc/intel/skylake/skl-debug.c:437:34:    got unsigned char *
sound/soc/intel/skylake/skl-debug.c:437:51: warning: incorrect type in argument 2 (different address spaces)
sound/soc/intel/skylake/skl-debug.c:437:51:    expected void const *from
sound/soc/intel/skylake/skl-debug.c:437:51:    got void [noderef] <asn:2> *[assigned] fw_reg_addr

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 212370bf704c..3466675f2678 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -188,7 +188,7 @@ static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
 	memset(d->fw_read_buff, 0, FW_REG_BUF);
 
 	if (w0_stat_sz > 0)
-		__iowrite32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
+		__ioread32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
 
 	for (offset = 0; offset < FW_REG_SIZE; offset += 16) {
 		ret += snprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
-- 
2.17.1
