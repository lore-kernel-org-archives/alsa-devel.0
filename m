From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
 sgtl5000_enable_regulators()
Date: Fri, 13 Dec 2013 10:29:43 +0000
Message-ID: <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 61C952615DC
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 11:29:48 +0100 (CET)
In-Reply-To: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

> -	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> -				sgtl5000->supplies);
> -	if (!ret)
> -		external_vddd = 1;
> -	else {
> +	/* External VDDD only works before revision 0x11 */
> +	if (sgtl5000->revision < 0x11) {
> +		vddd = regulator_get_optional(codec->dev, "VDDD");
> +		if (IS_ERR(vddd)) {
> +			/* See if it's just not registered yet */
> +			if (PTR_ERR(vddd) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +		} else {
> +			external_vddd = 1;
> +			regulator_put(vddd);
> +		}

Shouldn't we handle other errors ?
We can see that from the regulator_get_optional()-->_regulator_get(), there
are many other errors maybe returned. Not considering other error cases, If
the dt is used here, only ERR_PTR(-ENODEV) will be returned if the external
VDDD is absent, and only this case the ERR_PTR(_ENODEV) error will be returned,
Or if dt is not used and there has no external VDDD was found, the
ERR_PTR(-EPROBE_DEFER) will be returned.

So, if the external VDDD is not used, only ERR_PTR(-ENODEV) and ERR_PTR(-EPROBE_DEFER)
maybe returned ignoring other errors.

How about the following ? 
-----------------
+	if (IS_ERR(vddd)) {
+		/* See if it's just not registered yet */
+		if (PTR_ERR(vddd) != -ENODEV)
+			return PTR_ERR(vddd);
+	} else {
+		external_vddd = 1;
+		regulator_put(vddd);
+	}
-----------------


--
Xiubo
