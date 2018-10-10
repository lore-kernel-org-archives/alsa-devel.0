From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] pinctrl: madera: Fix uninitialized variable bug in
 madera_mux_set_mux
Date: Wed, 10 Oct 2018 17:13:13 +0200
Message-ID: <20181010151313.GA16854@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

There is a potential execution path in which variable *ret* is checked
in an IF statement, and then its value is used to report an error at
line 659 without being properly initialized previously:

659 if (ret)
660	dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);

Fix this by initializing variable *ret* to 0 in order to
avoid unpredictable or unintended results.

Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Initialize variable ret to 0 instead of -1. Thanks to Charles Keepax
   for pointing this out.
 - Update subject and commit log.

 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index 0266302..a5dda83 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -608,7 +608,7 @@ static int madera_mux_set_mux(struct pinctrl_dev *pctldev,
 	unsigned int n_chip_groups = priv->chip->n_pin_groups;
 	const char *func_name = madera_mux_funcs[selector].name;
 	unsigned int reg;
-	int i, ret;
+	int i, ret = 0;
 
 	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
 		__func__, selector, func_name, group,
-- 
2.7.4
