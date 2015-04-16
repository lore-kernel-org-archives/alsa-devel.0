From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: Intel: sst_byt: remove kfree for
	memory allocated with devm_kzalloc
Date: Thu, 16 Apr 2015 21:46:29 +0800
Message-ID: <1429191989-25919-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C16261497
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 15:46:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jin Yao <yao.jin@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jie Yang <yang.jie@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 1efb33b..a839dbf 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -759,7 +759,6 @@ fw_err:
 dsp_new_err:
 	sst_ipc_fini(ipc);
 ipc_init_err:
-	kfree(byt);
 
 	return err;
 }
