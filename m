From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l33: Remove setting
 dapm->bias_level in cs35l33_set_bias_level
Date: Tue, 28 Jun 2016 14:30:34 +0000
Message-ID: <D397F40C.150B4%Paul.Handrigan@cirrus.com>
References: <1467110219.1638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8260A266C02
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 16:30:36 +0200 (CEST)
In-Reply-To: <1467110219.1638.1.camel@ingics.com>
Content-Language: en-US
Content-ID: <1946143AB5DEA44699B079BA6C91A4DB@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 6/28/16, 5:36 AM, "Axel Lin" <axel.lin@ingics.com> wrote:

>This is done by ASoC core now.
>
>Signed-off-by: Axel Lin <axel.lin@ingics.com>
>---
> sound/soc/codecs/cs35l33.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
>index 90dc743..622a111 100644
>--- a/sound/soc/codecs/cs35l33.c
>+++ b/sound/soc/codecs/cs35l33.c
>@@ -365,7 +365,6 @@ static int cs35l33_set_bias_level(struct
>snd_soc_codec *codec,
> 				  enum snd_soc_bias_level level)
> {
> 	unsigned int val;
>-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> 	struct cs35l33_private *priv = snd_soc_codec_get_drvdata(codec);
> 
> 	switch (level) {
>@@ -392,8 +391,6 @@ static int cs35l33_set_bias_level(struct
>snd_soc_codec *codec,
> 		return -EINVAL;
> 	}
> 
>-	dapm->bias_level = level;
>-
> 	return 0;
> }
> 
>-- 
>2.5.0
Thanks!

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
