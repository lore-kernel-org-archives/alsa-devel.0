From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Fix I2C component device id number
	creation
Date: Tue, 19 Oct 2010 11:10:45 +0300
Message-ID: <1287475845-16230-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F749103942
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 10:10:16 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1363535ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 01:10:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Use bitwise AND instead of logical AND when masking.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Random note, not known to cause any problems at the moment as id field of
codec seems to be unused.
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8751efd..fe9f20b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2892,7 +2892,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
 			char tmp[NAME_SIZE];
 
 			/* create unique ID number from I2C addr and bus */
-			*id = ((id1 && 0xffff) << 16) + id2;
+			*id = ((id1 & 0xffff) << 16) + id2;
 
 			/* sanitize component name for DAI link creation */
 			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name, name);
-- 
1.7.1
