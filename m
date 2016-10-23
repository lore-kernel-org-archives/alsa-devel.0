From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: Intel: Atom: add terminate entry for dmi_system_id tables
Date: Sun, 23 Oct 2016 11:41:09 +0000
Message-ID: <1477222869-31970-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Colin Ian King <colin.king@canonical.com>, Sachin Mokashi <sachinx.mokashi@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Make sure dmi_system_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index ba5c0d7..0a88537 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -416,6 +416,7 @@ static const struct dmi_system_id cht_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
 		},
 	},
+	{ }
 };
 
 
