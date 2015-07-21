From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: max98925: reading beyond the end of the
	array
Date: Tue, 21 Jul 2015 11:55:27 +0300
Message-ID: <20150721085527.GA22070@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 35B962617B5
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 10:55:41 +0200 (CEST)
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
To: Liam Girdwood <lgirdwood@gmail.com>, Anish Kumar <yesanishhere@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Debug prints are seldom useful and this one has an annoying thing where
it reads one space beyond the end of the array on error.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index e1753c8..ebb648a 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -271,8 +271,6 @@ static inline int max98925_rate_value(struct snd_soc_codec *codec,
 			break;
 		}
 	}
-	dev_dbg(codec->dev, "%s: sample rate is %d, returning %d\n",
-				__func__, rate_table[i].rate, *value);
 	return ret;
 }
 
