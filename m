From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] sound/soc/fsl/fsl_ssi.c: let checking none-zero instead of
 checking NO_IRQ
Date: Mon, 23 Sep 2013 11:24:44 +0800
Message-ID: <523FB47C.8010800@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, perex@perex.cz, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

NO_IRQ may be defined as '(unsigned int) -1' in some architectures
(arm, sh ...), and either may not be defined in some architectures
which can enable SND_SOC_FSL_SSI (e.g. allmodconfig for arc).

When irq_of_parse_and_map() fails, it will always return 0, so need let
checking none-zero instead of checking NO_IRQ, or will cause compiling
issue or run time bug in some architectures.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 sound/soc/fsl/fsl_ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6ac8730..6c17d3e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -936,7 +936,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->ssi_phys = res.start;
 
 	ssi_private->irq = irq_of_parse_and_map(np, 0);
-	if (ssi_private->irq == NO_IRQ) {
+	if (!ssi_private->irq) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
 		return -ENXIO;
 	}
-- 
1.7.7.6
