From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: amd: Fix a NULL vs IS_ERR() check in
	probe
Date: Mon, 26 Nov 2018 11:13:07 +0300
Message-ID: <20181126081307.qhbpwnlikquep476@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1618A267847
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 09:13:26 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sanju R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

The platform_device_register_full() function doesn't return NULL, it
returns error pointers.

Fixes: 7894a7e7ea3d ("ASoC: amd: create ACP3x PCM platform device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index c28457fd9b81..facec2472b34 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -97,10 +97,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo.size_data = sizeof(irqflags);
 
 		adata->pdev = platform_device_register_full(&pdevinfo);
-		if (!adata->pdev) {
+		if (IS_ERR(adata->pdev)) {
 			dev_err(&pci->dev, "cannot register %s device\n",
 				pdevinfo.name);
-			ret = -ENODEV;
+			ret = PTR_ERR(adata->pdev);
 			goto unmap_mmio;
 		}
 		break;
-- 
2.11.0
