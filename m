From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/12] ASoC: SSM2602: Add entry for the ssm2603
	to the device id table
Date: Thu,  5 May 2011 16:59:18 +0200
Message-ID: <1304607560-15083-10-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 6C97B103A16
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:48 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

The SSM2603 is mostly register compatible with the SSM2602 and can be supported by
the current driver without any changes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index b36bfd1..ca57d93 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -682,6 +682,7 @@ static int __devexit ssm2602_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id ssm2602_i2c_id[] = {
 	{ "ssm2602", SSM2602 },
+	{ "ssm2603", SSM2602 },
 	{ "ssm2604", SSM2604 },
 	{ }
 };
@@ -732,6 +733,6 @@ static void __exit ssm2602_exit(void)
 }
 module_exit(ssm2602_exit);
 
-MODULE_DESCRIPTION("ASoC SSM2602/SSM2604 driver");
+MODULE_DESCRIPTION("ASoC SSM2602/SSM2603/SSM2604 driver");
 MODULE_AUTHOR("Cliff Cai");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5
