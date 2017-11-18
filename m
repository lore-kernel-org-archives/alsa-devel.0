From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/5 v2] ASoC: intel: mfld: Handle return value
	of platform_get_irq
Date: Sat, 18 Nov 2017 15:26:49 +0530
Message-ID: <f77d3cc6ccd2de3f94c0b09c110d970d5c8e0372.1510997815.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDBB82678A5
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 10:57:14 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id i15so3764036pfa.3
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:57:14 -0800 (PST)
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <37f7370f99f4efa12f92eaeada72ff511d409fa6.1510997815.git.arvind.yadav.cs@gmail.com>
References: <37f7370f99f4efa12f92eaeada72ff511d409fa6.1510997815.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, linux@armlinux.org.uk
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 sound/soc/intel/boards/mfld_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acf..77b3162 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -372,6 +372,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 	/* retrive the irq number */
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
 
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
-- 
2.7.4
