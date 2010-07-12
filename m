From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] ASoC: au1x: fix section mismatch in psc-i2s.c
Date: Mon, 12 Jul 2010 15:14:59 +0200
Message-ID: <1278940499-16824-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: alsa-devel@alsa-project.org

Annotate platform probe callback with __devinit instead of plain __init.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 sound/soc/au1x/psc-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 495be6e..24454c9 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -300,7 +300,7 @@ struct snd_soc_dai au1xpsc_i2s_dai = {
 };
 EXPORT_SYMBOL(au1xpsc_i2s_dai);
 
-static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
+static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 {
 	struct resource *r;
 	unsigned long sel;
-- 
1.7.1.1

