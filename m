From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 02/27] drivers/gpio/of: don't use deprecated
	fields in	of_platform_driver
Date: Thu, 11 Mar 2010 11:21:59 -0700
Message-ID: <20100311182158.13103.93206.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CF9A103A86
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:22:01 +0100 (CET)
Received: by mail-px0-f181.google.com with SMTP id 11so2877pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:22:01 -0800 (PST)
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade
List-Id: alsa-devel@alsa-project.org

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/leds/leds-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 7ff758a..0e6e9ac 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -291,8 +291,8 @@ static struct of_platform_driver of_gpio_leds_driver = {
 	.driver = {
 		.name = "of_gpio_leds",
 		.owner = THIS_MODULE,
+		.of_match_table = of_gpio_leds_match,
 	},
-	.match_table = of_gpio_leds_match,
 	.probe = of_gpio_leds_probe,
 	.remove = __devexit_p(of_gpio_leds_remove),
 };
