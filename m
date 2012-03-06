From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Remove defaults for volatile
	registers
Date: Tue,  6 Mar 2012 00:25:55 +0000
Message-ID: <1330993555-19581-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E8C824364
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 01:25:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Save a little RAM.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d5ee3ec..e5aaf24 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -116,11 +116,11 @@ static struct reg_default wm8962_reg[] = {
 	{ 1, 0x049F },   /* R1     - Right Input volume */
 	{ 2, 0x0000 },   /* R2     - HPOUTL volume */
 	{ 3, 0x0000 },   /* R3     - HPOUTR volume */
-	{ 4, 0x0020 },   /* R4     - Clocking1 */
+
 	{ 5, 0x0018 },   /* R5     - ADC & DAC Control 1 */
 	{ 6, 0x2008 },   /* R6     - ADC & DAC Control 2 */
 	{ 7, 0x000A },   /* R7     - Audio Interface 0 */
-	{ 8, 0x01E4 },   /* R8     - Clocking2 */
+
 	{ 9, 0x0300 },   /* R9     - Audio Interface 1 */
 	{ 10, 0x00C0 },  /* R10    - Left DAC volume */
 	{ 11, 0x00C0 },  /* R11    - Right DAC volume */
@@ -129,7 +129,7 @@ static struct reg_default wm8962_reg[] = {
 	{ 15, 0x6243 },   /* R15    - Software Reset */
 
 	{ 17, 0x007B },   /* R17    - ALC1 */
-	{ 18, 0x0000 },   /* R18    - ALC2 */
+
 	{ 19, 0x1C32 },   /* R19    - ALC3 */
 	{ 20, 0x3200 },   /* R20    - Noise Gate */
 	{ 21, 0x00C0 },   /* R21    - Left ADC volume */
@@ -153,10 +153,6 @@ static struct reg_default wm8962_reg[] = {
 	{ 40, 0x0000 },   /* R40    - SPKOUTL volume */
 	{ 41, 0x0000 },   /* R41    - SPKOUTR volume */
 
-	{ 47, 0x0000 },   /* R47    - Thermal Shutdown Status */
-	{ 48, 0x8027 },   /* R48    - Additional Control (4) */
-	{ 49, 0x0010 },   /* R49    - Class D Control 1 */
-
 	{ 51, 0x0003 },   /* R51    - Class D Control 2 */
 
 	{ 56, 0x0506 },   /* R56    - Clocking 4 */
@@ -168,8 +164,6 @@ static struct reg_default wm8962_reg[] = {
 
 	{ 64, 0x0810 },   /* R64    - DC Servo 4 */
 
-	{ 66, 0x0000 },   /* R66    - DC Servo 6 */
-
 	{ 68, 0x001B },   /* R68    - Analogue PGA Bias */
 	{ 69, 0x0000 },   /* R69    - Analogue HP 0 */
 
@@ -302,9 +296,6 @@ static struct reg_default wm8962_reg[] = {
 	{ 516, 0x8100 },   /* R516   - GPIO 5 */
 	{ 517, 0x8100 },   /* R517   - GPIO 6 */
 
-	{ 560, 0x0000 },   /* R560   - Interrupt Status 1 */
-	{ 561, 0x0000 },   /* R561   - Interrupt Status 2 */
-
 	{ 568, 0x0030 },   /* R568   - Interrupt Status 1 Mask */
 	{ 569, 0xFFED },   /* R569   - Interrupt Status 2 Mask */
 
@@ -316,8 +307,6 @@ static struct reg_default wm8962_reg[] = {
 
 	{ 768, 0x1C00 },   /* R768   - DSP2 Power Management */
 
-	{ 1037, 0x0000 },   /* R1037  - DSP2_ExecControl */
-
 	{ 8192, 0x0000 },   /* R8192  - DSP2 Instruction RAM 0 */
 
 	{ 9216, 0x0030 },   /* R9216  - DSP2 Address RAM 2 */
-- 
1.7.9.1
