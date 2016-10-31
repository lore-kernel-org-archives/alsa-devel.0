From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH] ASoC: sun4i-codec: return error code instead of
 NULL when create_card fails
Date: Mon, 31 Oct 2016 14:42:09 +0800
Message-ID: <20161031064209.12241-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBRGP3PAAKGQE6V2UBPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

When sun4i_codec_create_card fails, we do not assign a proper error
code to the return value. The return value would be 0 from the previous
function call, or we would have bailed out sooner. This would confuse
the driver core into thinking the device probe succeeded, when in fact
it didn't, leaving various devres based resources lingering.

Make the create_card function pass back a meaningful error code, and
assign it to the return value.

Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip codec on
		      early Allwinner SoCs")
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---

In practice this should be really hard to hit, as the only failures in
create_card are memory allocation failures.

Should we mark this for stable?

---
 sound/soc/sunxi/sun4i-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e047ec06d538..a60707761abf 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -765,11 +765,11 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
@@ -876,7 +876,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	card = sun4i_codec_create_card(&pdev->dev);
-	if (!card) {
+	if (IS_ERR(card)) {
+		ret = PTR_ERR(card);
 		dev_err(&pdev->dev, "Failed to create our card\n");
 		goto err_unregister_codec;
 	}
-- 
2.10.1
