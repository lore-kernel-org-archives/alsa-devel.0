From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: multi-component - Fix ".-1" removal
	from device name
Date: Tue,  3 Aug 2010 09:26:58 +0300
Message-ID: <1280816818-10154-2-git-send-email-jhnikula@gmail.com>
References: <1280816818-10154-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 46CCA2414E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 08:26:19 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1460651ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 23:26:19 -0700 (PDT)
In-Reply-To: <1280816818-10154-1-git-send-email-jhnikula@gmail.com>
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

Function fmt_single_name returns empty name if device name is
"driver-name.-1".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Liam. This is a trivial fix. No need for separate patch, just embed to your
next multi-component update. Do we even have a case where name is "foo-bar.-1"?
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 300a9b3..db7ea1b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2807,7 +2807,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
 
 			/* discard ID from name if ID == -1 */
 			if (*id == -1)
-				*found = '\0';
+				found[strlen(dev->driver->name)] = '\0';
 		}
 
 	} else {
-- 
1.7.1
