From: Mark Brown <broonie@opensource.wolfsonmciro.com>
Subject: [PATCH] ASoC: Taint the kernel if debugfs is used to
	write directly to CODECs
Date: Thu,  6 Jan 2011 16:05:50 +0000
Message-ID: <1294329950-3881-1-git-send-email-broonie@opensource.wolfsonmciro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B747244A9
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 17:07:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmciro.com>
List-Id: alsa-devel@alsa-project.org

Since direct register writes may confuse the drivers and are supposed
to be used only in diagnostic situations discourage their use in
production by tainting the kernel when we do a write.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmciro.com>
---
 sound/soc/soc-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a233607..dbca5023 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -209,6 +209,10 @@ static ssize_t codec_reg_write_file(struct file *file,
 		start++;
 	if (strict_strtoul(start, 16, &value))
 		return -EINVAL;
+
+	/* Userspace has been fiddling around behind the kernel's back */
+	add_taint(TAINT_USER);
+
 	snd_soc_write(codec, reg, value);
 	return buf_size;
 }
-- 
1.7.2.3
