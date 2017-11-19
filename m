From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/5 v4] ASoC: nuc900: Fix platform_get_irq's
	error checking
Date: Sun, 19 Nov 2017 09:45:02 +0530
Message-ID: <ff6af1a5db5ee3cb9b8f5846573d0f578950d6a8.1511062844.git.arvind.yadav.cs@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A5036266EDF
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 05:15:31 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id s11so4846558pgc.5
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 20:15:31 -0800 (PST)
In-Reply-To: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux@armlinux.org.uk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               irq was unsigned. so using signed variable ret.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v4 :
              Return -ENODEV insted of irq.
 sound/soc/nuc900/nuc900-ac97.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..893ccf2 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -345,11 +345,12 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 		goto out;
 	}
 
-	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
 		ret = -EBUSY;
 		goto out;
 	}
+	nuc900_audio->irq_num = ret;
 
 	nuc900_ac97_data = nuc900_audio;
 
-- 
2.7.4
