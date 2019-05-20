From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 07/10] mfd: madera: point to the right pinctrl binding file
Date: Mon, 20 May 2019 11:47:36 -0300
Message-ID: <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

The reference to Documentation/pinctrl.txt doesn't exist, but
there is an specific binding for the madera driver.

So, point to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb..c7e0658eb74b 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
+ * @gpio_configs:   Array of GPIO configurations
+ *		    (See Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
-- 
2.21.0
