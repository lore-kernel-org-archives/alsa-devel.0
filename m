From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoC: Fail card instantiation if DAI format
	setup fails
Date: Wed, 24 Jul 2019 11:38:44 +0200
Message-ID: <alpine.DEB.2.20.1907241132350.6338@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 760BCF800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:38:50 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


If the DAI format setup fails, there is no valid communication format
between CPU and CODEC, so fail card instantiation, rather than continue
with a card that will most likely not function properly.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---

I've had the problem of a sound card coming up even though an incorrect 
DAI format was selected in the devicetree, apparently caused by not 
checking the return value of snd_soc_runtime_set_dai_fmt() when the card 
is instantiated, with the result in this particular case that that the 
audio data was not transferred correctly (capture data was shifted one bit 
up).

I'm unsure though if this is intentional, I can't think why it should be, 
since the DAI format is only set up at this time and not for instance 
later when a stream is enabled, but perhaps I'm missing something here.

At any rate, with this patch, the card does not come up under these 
circumstances. The error message from snd_soc_runtime_set_dai_fmt() is 
still printed to the kernel log so it's possible to see what the reason 
is.

/Ricard

 sound/soc/soc-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ecfe641ca46..06697b2d96b1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1511,8 +1511,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		}
 	}
 
-	if (dai_link->dai_fmt)
-		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+	if (dai_link->dai_fmt) {
+		ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+		if (ret)
+			return ret;
+	}
 
 	ret = soc_post_component_init(rtd, dai_link->name);
 	if (ret)
-- 
2.11.0


-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
