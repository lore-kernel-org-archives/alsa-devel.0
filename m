From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] ASoC: cs42l73: don't use negative array index
Date: Thu, 12 Apr 2012 21:54:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204122152340.7553@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 236732458F
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 21:54:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: brian.austin@cirrus.com, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@linux.intel.com>, joe@nucleusys.com, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

If cs42l73_get_mclkx_coeff() returns < 0 (which it can) in
sound/soc/codecs/cs42l73.c::cs42l73_set_mclk(), then we'll be using
the (negative) return value as array index on the very next line of
code - that's bad.

Catch the negative return value and propagate it to the caller (which
checks for it) and things are a bit more sane :-)

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/cs42l73.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 78979b3..07c44b7 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -929,6 +929,8 @@ static int cs42l73_set_mclk(struct snd_soc_dai *dai, unsigned int freq)
 
 	/* MCLKX -> MCLK */
 	mclkx_coeff = cs42l73_get_mclkx_coeff(freq);
+	if (mclkx_coeff < 0)
+		return mclkx_coeff;
 
 	mclk = cs42l73_mclkx_coeffs[mclkx_coeff].mclkx /
 		cs42l73_mclkx_coeffs[mclkx_coeff].ratio;
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
