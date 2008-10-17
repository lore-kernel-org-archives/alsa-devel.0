From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] Fix debugfs_create_dir's error checking method for sound/soc/
Date: Fri, 17 Oct 2008 21:04:55 +0800
Message-ID: <48F88D77.2080106@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754845AbYJQNG1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

debugfs_create_dir() returns NULL if an error occurs, returns -ENODEV
when debugfs is not enabled in the kernel.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index efbd0b3..7351db9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -831,7 +831,7 @@ int snd_soc_dapm_sys_add(struct device *dev)
 		return ret;
 
 	asoc_debugfs = debugfs_create_dir("asoc", NULL);
-	if (!IS_ERR(asoc_debugfs))
+	if (!IS_ERR(asoc_debugfs) && asoc_debugfs)
 		debugfs_create_u32("dapm_pop_time", 0744, asoc_debugfs,
 				   &pop_time);
 	else
-- 
1.5.5.3
