From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 05/22] mfd: madera: Fix bad reference to pinctrl.txt file
Date: Wed, 29 May 2019 20:23:36 -0300
Message-ID: <36c1c04d050fa3f4f56efd306e59f5eeeccf4015.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Otto Sabart <ottosabart@seberm.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Otto Sabart <ottosabart@seberm.com>

The pinctrl.txt file was converted into reStructuredText and moved into
driver-api folder. This patch updates the broken reference.

Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb..dd00ab824e5b 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
+ * @gpio_configs:   Array of GPIO configurations (See
+ *		    Documentation/driver-api/pinctl.rst)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
-- 
2.21.0
