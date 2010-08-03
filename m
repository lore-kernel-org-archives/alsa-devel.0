From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: multi-component - Fix DAI ID
	scanning from device name
Date: Tue,  3 Aug 2010 09:26:57 +0300
Message-ID: <1280816818-10154-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 77CD32414E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 08:26:17 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1460651ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 23:26:14 -0700 (PDT)
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

Format string specifier ".%d" for sscanf cannot scan integer from a string
"driver-name.123". Fix this by starting the scan from a position after
"driver-name".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Liam. This is a trivial fix. No need for separate patch, just embed to your
next multi-component update. I noticed this because dai->id in mcbsp_dai_probe
was always zero.
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5c10439..300a9b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2803,7 +2803,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
 	found = strstr(name, dev->driver->name);
 	if (found) {
 		/* get ID */
-		if (sscanf(found,".%d", id) == 1) {
+		if (sscanf(&found[strlen(dev->driver->name)], ".%d", id) == 1) {
 
 			/* discard ID from name if ID == -1 */
 			if (*id == -1)
-- 
1.7.1
