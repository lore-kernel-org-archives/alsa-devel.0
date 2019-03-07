From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ASoC: soc-pcm: only apply symmetry if more
 than one stream is active
Date: Thu, 07 Mar 2019 15:45:25 +0000
Message-ID: <E1h1vD3-0005C1-Gl@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32629F806F7
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 16:45:40 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

ALSA documentation indicates that the hw_params() (and prepare())
callbacks can be made multiple times during the life of an individual
stream.  It is not specified whether hw_free() will be called, nor is
it specified whether the parameters will be the same as the last call.

Since symmetry is supposed to be applied between different streams,
apply symmetry only when we have more than one activation of the CPU
DAI.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Untested, depends on "ASoC: soc-pcm: make symmetry work again"

 sound/soc/soc-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2a4246dbe55f..3c7c3f79742e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1010,9 +1010,11 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	component = NULL;
 
-	ret = soc_pcm_params_symmetry(substream, params);
-	if (ret)
-		goto component_err;
+	if (cpu_dai->active > 1) {
+		ret = soc_pcm_params_symmetry(substream, params);
+		if (ret)
+			goto component_err;
+	}
 
 	/* store the parameters for each DAIs */
 	cpu_dai->rate = params_rate(params);
-- 
2.7.4
