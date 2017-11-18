From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/5 v2] ASoC: intel: sst: Handle return value
	of platform_get_irq
Date: Sat, 18 Nov 2017 15:26:48 +0530
Message-ID: <d61bfcbfa40f823d27fd88bf011ffa4b539dc359.1510997815.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 630C82678A0
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 10:57:10 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id o7so3778987pgc.4
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:57:10 -0800 (PST)
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

 sound/soc/intel/atom/sst/sst_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 32d6e02..693b970 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -236,6 +236,9 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* Find the IRQ */
 	ctx->irq_num = platform_get_irq(pdev,
 				ctx->pdata->res_info->acpi_ipc_irq_index);
+	if (ctx->irq_num <= 0)
+		return ctx->irq_num;
+
 	return 0;
 }
 
-- 
2.7.4
