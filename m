From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH asoc-dev 2/2] ASoC: Cover also Nokia N810 WiMAX
	Edition in N810 machine driver
Date: Wed, 11 Jun 2008 11:52:50 +0300
Message-ID: <1213174370-29568-2-git-send-email-jarkko.nikula@nokia.com>
References: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C75D6244ED
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 10:53:09 +0200 (CEST)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5B8qqH3017815
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2008 11:53:08 +0300
In-Reply-To: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index c32487b..c168a64 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -265,7 +265,7 @@ static int __init n810_soc_init(void)
 	int err;
 	struct device *dev;
 
-	if (!machine_is_nokia_n810())
+	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 		return -ENODEV;
 
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.5.5.3
