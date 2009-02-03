From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports
	start from 1, not 	0
Date: Tue, 3 Feb 2009 18:13:22 +0100
Message-ID: <74d0deb30902030913u581debd1pa31eda017a49524c@mail.gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
	<20090203164715.GH23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DB7D103881
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 18:13:23 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so886521ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 09:13:22 -0800 (PST)
In-Reply-To: <20090203164715.GH23827@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2009 at 5:47 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Feb 03, 2009 at 05:19:41PM +0100, Philipp Zabel wrote:
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> Meh, all the display names use the documentation names and the id is
> used for indexing into arrays (which may well be why you're not getting
> any audio out...).  I'd be more inclined to leave this as-is but if not
> it needs to adjust all the array usages.

Meh, indeed. Jumping between pxa2xx-ssp and pxa-ssp must have confused
me. A lot.
The only thing wrong with pxa-ssp is that it requests the wrong SSP port, then:

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 73cb6b4..7f7c23e 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -751,7 +751,7 @@ static int pxa_ssp_probe(struct platform_device *pdev,
        if (!priv)
                return -ENOMEM;

-       priv->dev.ssp = ssp_request(dai->id, "SoC audio");
+       priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
        if (priv->dev.ssp == NULL) {
                ret = -ENODEV;
                goto err_priv;

But this isn't right either. Because if we request the correct SSP
port here, the subsequent request of the same SSP port in ssp_init
(called from ops->startup) fails.
How to fix?

regards
Philipp
