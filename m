From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: ssm2518: Use a signed return type for
 ssm2518_lookup_mcs()
Date: Sun, 20 Dec 2015 10:40:24 +0100
Message-ID: <56767788.4020709@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0F92606C9
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 10:40:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 20 Dec 2015 10:34:25 +0100

The return type "unsigned int" was used by the ssm2518_lookup_mcs()
function even though it will eventually return a negative error code.
Improve this implementation detail by deletion of the type modifier then.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/ssm2518.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 86b81a6..e2e0bfa 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -309,7 +309,7 @@ static const struct snd_pcm_hw_constraint_list ssm2518_constraints_12288000 = {
 	.count = ARRAY_SIZE(ssm2518_rates_12288000),
 };
 
-static unsigned int ssm2518_lookup_mcs(struct ssm2518 *ssm2518,
+static int ssm2518_lookup_mcs(struct ssm2518 *ssm2518,
 	unsigned int rate)
 {
 	const unsigned int *sysclks = NULL;
-- 
2.6.3
