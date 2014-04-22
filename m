From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix audio crash due to negative
	address offset
Date: Tue, 22 Apr 2014 16:38:54 +0300
Message-ID: <1398173934-20095-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A81A264F09
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 15:39:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Wenkai Du <wenkai.du@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Wenkai Du <wenkai.du@intel.com>

There were occasional ADSP crash during reboot testing:

[   11.883364] BUG: unable to handle kernel paging request at ffffc90121700000
[   11.883380] IP: [<ffffffffc024d8bc>] sst_module_insert_fixed_block+0x24f/0x26d [snd_soc_sst_dsp]
[   11.883397] PGD 7800b067 PUD 0
[   11.883405] Oops: 0002 [#1] SMP
[   11.886418] gsmi: Log Shutdown Reason 0x03

The virtual address, ffffc90121700000, was out of range. The virtual
address is calculated by adding LPE base address with an offset:

sst_memcpy32(dsp->addr.lpe + data->offset, data->data, data->size);

The offset is calculated in sst_byt_parse_module, by subtraction of
two virtual addresses dsp->addr.fw_ext and dsp->addr.lpe:

block_data.offset = block->ram_offset + (dsp->addr.fw_ext - dsp->addr.lpe);

These virtual addresses are assigned by kernel from ioremap:

sst->addr.lpe = ioremap(pdata->lpe_base, pdata->lpe_size);
sst->addr.fw_ext = ioremap(pdata->fw_base, pdata->fw_size);

In current driver code, offset is defined as unsigned int32:

struct sst_module_data {
...
	u32 offset;		/* offset in FW file */
};

Most of the time kernel assigned virtual addresses with addr.fw_ext
greater than addr.lpe. But sometimes it was the other way round.

Fix the problem by declaring offset as signed int32_t.

Signed-off-by: Wenkai Du <wenkai.du@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index fe8e81aad646..30ca14a6a835 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -136,7 +136,7 @@ struct sst_module_data {
 	enum sst_data_type data_type;	/* type of module data */
 
 	u32 size;		/* size in bytes */
-	u32 offset;		/* offset in FW file */
+	int32_t offset;		/* offset in FW file */
 	u32 data_offset;	/* offset in ADSP memory space */
 	void *data;		/* module data */
 };
-- 
1.9.2
