From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH v2] ASoC: atmel: test wrong variable
Date: Mon, 22 Nov 2010 18:59:13 +0300
Message-ID: <20101122155913.GA9089@albatros>
References: <1290361216-15166-1-git-send-email-segoon@openwall.com>
 <20101122094353.f76830b5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101122094353.f76830b5.jhnikula@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Jarkko Nikula <jhnikula@gmail.com>
List-Id: alsa-devel@alsa-project.org

After clk_get() mclk is checked second time instead of pllb check.
In patch v1 Jarkko Nikula noticed that PTR_ERR() is also has wrong argument.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index da9c303..f16e00c 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -223,9 +223,9 @@ static int __init at91sam9g20ek_init(void)
 	}
 
 	pllb = clk_get(NULL, "pllb");
-	if (IS_ERR(mclk)) {
+	if (IS_ERR(pllb)) {
 		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
-		ret = PTR_ERR(mclk);
+		ret = PTR_ERR(pllb);
 		goto err_mclk;
 	}
 	ret = clk_set_parent(mclk, pllb);
-- 
1.7.0.4
