From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Sat, 25 Sep 2010 09:16:41 +0100
Message-ID: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23DC2243B4
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 10:16:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since Jassi is doing so much good work and can offer such good review
for the Samsung CPU support add an entry for the Samsung ASoC drivers
to MAINTAINERS listing him.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5b8baa..f51409b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4965,6 +4965,12 @@ F:	drivers/media/common/saa7146*
 F:	drivers/media/video/*7146*
 F:	include/media/*7146*
 
+SAMSUNG AUDIO (ASoC) DRIVERS
+M:	Jassi Brar <jassi.brar@samsung.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/s3c24xx
+
 TLG2300 VIDEO4LINUX-2 DRIVER
 M:	Huang Shijie <shijie8@gmail.com>
 M:	Kang Yong <kangyong@telegent.com>
-- 
1.7.1
