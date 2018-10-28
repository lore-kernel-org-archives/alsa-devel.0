From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ASoC: AMD: constify regulator_desc structure
Date: Sun, 28 Oct 2018 06:56:08 +0100
Message-ID: <1540706168-30601-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 378BC267692
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2018 07:31:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The regulator_desc structure can be const as it is only passed as the
second argument of devm_regulator_register and the corresponding
parameter is declared as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/amd/acp-da7219-max98357a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3f813ea5210a..a5daad973ce5 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -403,7 +403,7 @@ static struct regulator_config acp_da7219_cfg = {
 static struct regulator_ops acp_da7219_ops = {
 };
 
-static struct regulator_desc acp_da7219_desc = {
+static const struct regulator_desc acp_da7219_desc = {
 	.name = "reg-fixed-1.8V",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
