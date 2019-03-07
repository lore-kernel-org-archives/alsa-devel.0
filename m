From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ASoC: soc-pcm: make symmetry work again
Date: Thu, 07 Mar 2019 13:59:19 +0000
Message-ID: <E1h1tYN-0004Z9-6M@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C810F8065A
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 14:59:35 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: jiada wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 957ce0c6b8a1 ("ASoC: soc-pcm: check symmetry after hw_params")
moved the check for symmetry after we have set the cpu_dai's rate,
channels and sample width to those in the params.

The symmetry check verifies that the cpu dai's stored parameters are
the same as those in the params.  Since we have only just stored these
parameters, this makes the symmetry checks always pass.

Fix this by moving the symmetry check before we store the parameters,
but after the parameters have been fixed up.

Fixes: 957ce0c6b8a1 ("ASoC: soc-pcm: check symmetry after hw_params")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Not tested: this is something I stumbled over while reading the code.

 sound/soc/soc-pcm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 08ee163504e8..dc3c3e31d2ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1010,15 +1010,16 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	component = NULL;
 
+	ret = soc_pcm_params_symmetry(substream, params);
+        if (ret)
+		goto component_err;
+
 	/* store the parameters for each DAIs */
 	cpu_dai->rate = params_rate(params);
 	cpu_dai->channels = params_channels(params);
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
-	ret = soc_pcm_params_symmetry(substream, params);
-        if (ret)
-		goto component_err;
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
-- 
2.7.4
