From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: ti: davinci-evm: Do not fail if the
	dai_set_sysclk returns -ENOTSUPP
Date: Fri, 30 Aug 2019 13:38:41 +0300
Message-ID: <20190830103841.25128-5-peter.ujfalusi@ti.com>
References: <20190830103841.25128-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D58BFF80444
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:38:28 +0200 (CEST)
In-Reply-To: <20190830103841.25128-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The davinci McBSP (davinci-i2s) driver does not implement the set_sysclk
callback, which is fine and should not be treated as error.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index bfd8d1a03ba7..686b23d7a90d 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -68,7 +68,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set the CPU system clock */
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOTSUPP)
 		return ret;
 
 	return 0;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
