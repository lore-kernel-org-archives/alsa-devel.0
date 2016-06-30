From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l33: Fix display revision id
Date: Thu, 30 Jun 2016 15:36:47 +0000
Message-ID: <D39AA69F.15239%Paul.Handrigan@cirrus.com>
References: <1467245670.7105.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B948F266A30
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 17:36:51 +0200 (CEST)
In-Reply-To: <1467245670.7105.3.camel@ingics.com>
Content-Language: en-US
Content-ID: <A7B64EF9BE96AB41B12D1FA3A4C03A3B@ad.cirrus.com>
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



On 6/29/16, 7:14 PM, "Axel Lin" <axel.lin@ingics.com> wrote:

>Signed-off-by: Axel Lin <axel.lin@ingics.com>
>---
> sound/soc/codecs/cs35l33.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
>index aa5c0c5..640fe24 100644
>--- a/sound/soc/codecs/cs35l33.c
>+++ b/sound/soc/codecs/cs35l33.c
>@@ -1219,7 +1219,7 @@ static int cs35l33_i2c_probe(struct i2c_client
>*i2c_client,
> 	}
> 
> 	dev_info(&i2c_client->dev,
>-		 "Cirrus Logic CS35L33, Revision: %02X\n", ret & 0xFF);
>+		 "Cirrus Logic CS35L33, Revision: %02X\n", reg & 0xFF);
> 
> 	ret = regmap_register_patch(cs35l33->regmap,
> 			cs35l33_patch, ARRAY_SIZE(cs35l33_patch));
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
