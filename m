From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove bogus check for register validity
	in debugfs write
Date: Wed, 16 Mar 2011 18:19:30 +0000
Message-ID: <1300299570-20223-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE7F324548
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 19:19:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since not all registers need to be cached and the cache is entirely
optional anyway we shouldn't be checking that a register is in the
cached range. If the register is invalid then the actual I/O code
can determine that and report an error.

Similarly, the step size can and should be enforced by the lower level
code if it's important.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 17efacd..4dda589 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -259,8 +259,6 @@ static ssize_t codec_reg_write_file(struct file *file,
 	while (*start == ' ')
 		start++;
 	reg = simple_strtoul(start, &start, 16);
-	if ((reg >= codec->driver->reg_cache_size) || (reg % step))
-		return -EINVAL;
 	while (*start == ' ')
 		start++;
 	if (strict_strtoul(start, 16, &value))
-- 
1.7.4.1
