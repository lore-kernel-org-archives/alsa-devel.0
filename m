From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] ASoC: alc5632: Remove volatile registers from
	regmap defaults
Date: Thu, 17 Nov 2011 18:48:42 +0200
Message-ID: <1321548522-32306-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 07CAA103AD4
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 17:48:57 +0100 (CET)
Received: by eyz10 with SMTP id 10so2289697eyz.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 08:48:57 -0800 (PST)
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

There is no need to provide defaults for the volatile
registers and doing so might cause confusion.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index c32eade..2d77665 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -36,7 +36,6 @@
  * ALC5632 register cache
  */
 static struct reg_default  alc5632_reg_defaults[] = {
-	{   0, 0x59B4 },	/* R0   - Reset */
 	{   2, 0x8080 },	/* R2   - Speaker Output Volume */
 	{   4, 0x8080 },	/* R4   - Headphone Output Volume */
 	{   6, 0x8080 },	/* R6   - AUXOUT Volume */
@@ -52,7 +51,6 @@ static struct reg_default  alc5632_reg_defaults[] = {
 	{  34, 0x0000 },	/* R34  - Microphone Control */
 	{  36, 0x00C0 },    /* R36  - Codec Digital MIC/Digital Boost
 						   Control */
-	{  38, 0xEF00 },	/* R38  - Power Down Control/Status */
 	{  46, 0x0000 },	/* R46  - Stereo DAC/Voice DAC/Stereo ADC
 						   Function Select */
 	{  52, 0x8000 },	/* R52  - Main Serial Data Port Control
@@ -70,9 +68,7 @@ static struct reg_default  alc5632_reg_defaults[] = {
 	{  78, 0xBE3E },	/* R78  - GPIO Pin Polarity */
 	{  80, 0x0000 },	/* R80  - GPIO Pin Sticky */
 	{  82, 0x0000 },	/* R82  - GPIO Pin Wake Up */
-	{  84, 0x803A },	/* R84  - GPIO Pin Status */
 	{  86, 0x0000 },	/* R86  - Pin Sharing */
-	{  88, 0x0000 },	/* R88  - Over-Temp/Current Status */
 	{  90, 0x0009 },	/* R90  - Soft Volume Control Setting */
 	{  92, 0x0000 },	/* R92  - GPIO_Output Pin Control */
 	{  94, 0x3000 },	/* R94  - MISC Control */
@@ -82,9 +78,6 @@ static struct reg_default  alc5632_reg_defaults[] = {
 	{ 104, 0x0553 },	/* R104 - Pseudo Stereo and Spatial Effect
 						   Block Control */
 	{ 106, 0x0000 },	/* R106 - Private Register Address */
-	{ 108, 0x0000 },	/* R108 - Private Register Data */
-	{ 110, 0x0000 },	/* R110 - EQ Control and Status/ADC
-							HPF Control */
 };
 
 /* codec private data */
-- 
1.7.3.4
