From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 5/6] ASoC: alc5632: Added support of two
	undocumented registers
Date: Wed, 16 Nov 2011 12:07:02 +0200
Message-ID: <1321438023-29660-6-git-send-email-leon@leon.nu>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE7AD24484
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:33 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:33 -0800 (PST)
In-Reply-To: <1321438023-29660-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

There are two undocumented registers in use in alc5632_i2c_probe
function. It must be added to regmap defaults, in order to support
future rewrite of this function to use regmap API completely.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index ea40f02..5a672a9 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -85,6 +85,8 @@ static struct reg_default  alc5632_reg_defaults[] = {
 	{ 108, 0x0000 },	/* R108 - Private Register Data */
 	{ 110, 0x0000 },	/* R110 - EQ Control and Status/ADC
 							HPF Control */
+	{ 124, 0x0000 },	/* R124 - Vendor ID1 (Undocumented) */
+	{ 125, 0x0000 },	/* R124 - Vendor ID2 (Undocumented) */
 };
 
 /* codec private data */
@@ -104,6 +106,8 @@ static bool alc5632_volatile_register(struct device *dev,
 	case ALC5632_OVER_CURR_STATUS:
 	case ALC5632_HID_CTRL_DATA:
 	case ALC5632_EQ_CTRL:
+	case ALC5632_VENDOR_ID1:
+	case ALC5632_VENDOR_ID2:
 		return true;
 
 	default:
-- 
1.7.3.4
