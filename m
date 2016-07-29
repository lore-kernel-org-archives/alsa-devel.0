From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs53l30: Do not ignore errors if mclk is specified
Date: Fri, 29 Jul 2016 18:21:50 +0000
Message-ID: <a85c897c-66c7-4703-998d-822eb9f77163@EX4.ad.cirrus.com>
References: <1469745781-31057-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469745781-31057-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Content-ID: <36BE31E2CB44F84F8CD80F47E11A63E7@ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Austin, Brian" <Brian.Austin@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 7/28/16, 5:43 PM, "Nicolin Chen" <nicoleotsuka@gmail.com> wrote:

>When the clock is specified, there could be other errors besides
>the EPROBE_DEFER so don't ignore them.
>
>Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>---
> sound/soc/codecs/cs53l30.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 2c0d9c4..227c556 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -999,8 +999,8 @@ static int cs53l30_i2c_probe(struct i2c_client
>*client,
> 	/* Check if MCLK provided */
> 	cs53l30->mclk = devm_clk_get(dev, "mclk");
> 	if (IS_ERR(cs53l30->mclk)) {
>-		if (PTR_ERR(cs53l30->mclk) == -EPROBE_DEFER) {
>-			ret = -EPROBE_DEFER;
>+		if (PTR_ERR(cs53l30->mclk) != -ENOENT) {
>+			ret = PTR_ERR(cs53l30->mclk);
> 			goto error;
> 		}
> 		/* Otherwise mark the mclk pointer to NULL */

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
