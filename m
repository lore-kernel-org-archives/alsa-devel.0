From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: max9877: Update register if either val or val2
	is changed
Date: Tue, 22 Nov 2011 14:47:44 +0800
Message-ID: <1321944464.2236.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8145F103946
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 07:47:58 +0100 (CET)
Received: by yenr9 with SMTP id r9so3692797yen.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 22:47:56 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In the case of ((max9877_regs[reg] >> shift) & mask) != val
but ((max9877_regs[reg2] >> shift) & mask) == val2,
current code does not update the registers.

Fix the logic to update registers if either val or val2 is changed.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max9877.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 9e7e964..dcf6f2a 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -106,13 +106,13 @@ static int max9877_set_2reg(struct snd_kcontrol *kcontrol,
 	unsigned int mask = mc->max;
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
 	unsigned int val2 = (ucontrol->value.integer.value[1] & mask);
-	unsigned int change = 1;
+	unsigned int change = 0;
 
-	if (((max9877_regs[reg] >> shift) & mask) == val)
-		change = 0;
+	if (((max9877_regs[reg] >> shift) & mask) != val)
+		change = 1;
 
-	if (((max9877_regs[reg2] >> shift) & mask) == val2)
-		change = 0;
+	if (((max9877_regs[reg2] >> shift) & mask) != val2)
+		change = 1;
 
 	if (change) {
 		max9877_regs[reg] &= ~(mask << shift);
-- 
1.7.5.4
