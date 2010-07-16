From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] uda134x: properly free allocated memory if
	uda134x_soc_probe fail with unknown codec type
Date: Fri, 16 Jul 2010 10:42:46 +0800
Message-ID: <1279248166.10112.9.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If uda134x_soc_probe fail with unknown codec type, it should properly free
allocated memory before return -EINVAL.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This case won't be executed in current implementation because there is a
model checking in the begin of uda134x_soc_probe.
But since the code is there, I think it's good to make it correct.
Otherwise, we can simply remove the default case.

 sound/soc/codecs/uda134x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 28aac53..9bff3c6 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -566,9 +566,10 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 					ARRAY_SIZE(uda1345_snd_controls));
 	break;
 	default:
+		ret = -EINVAL;
 		printk(KERN_ERR "%s unknown codec type: %d",
 			__func__, pd->model);
-	return -EINVAL;
+	break;
 	}
 
 	if (ret < 0) {
-- 
1.5.4.3
