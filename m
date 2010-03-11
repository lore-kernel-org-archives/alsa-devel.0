From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 22/37] drivers/leds: use .dev.of_node instead
	of .node in	struct of_device
Date: Thu, 11 Mar 2010 11:05:49 -0700
Message-ID: <20100311180549.4824.31164.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F21E103A36
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:05:52 +0100 (CET)
Received: by mail-pw0-f51.google.com with SMTP id 10so154935pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:05:52 -0800 (PST)
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
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

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/leds/leds-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index e5225d2..7ff758a 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -210,7 +210,7 @@ struct gpio_led_of_platform_data {
 static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 					const struct of_device_id *match)
 {
-	struct device_node *np = ofdev->node, *child;
+	struct device_node *np = ofdev->dev.of_node, *child;
 	struct gpio_led led;
 	struct gpio_led_of_platform_data *pdata;
 	int count = 0, ret;
