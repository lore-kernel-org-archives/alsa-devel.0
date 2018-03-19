From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid
 compatibles as deprecated
Date: Mon, 19 Mar 2018 16:16:04 +0100
Message-ID: <29143fe8-614b-21f7-624a-671207c0822b@samsung.com>
References: <CGME20180318153541epcas4p2229bf9e856b26e0b1f0db778222eb32e@epcas4p2.samsung.com>
 <20180318153512.8343-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C182B267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 16:16:12 +0100 (CET)
In-reply-to: <20180318153512.8343-1-krzk@kernel.org>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> index f35a2694eb04..e9da2200e173 100644
> --- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> +++ b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> @@ -3,7 +3,9 @@ Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
>  Required properties:
>  
>   - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
> -		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board
> +		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
> +		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
> +		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)

I think we should make it clear which compatible applies to which board.

-- 
Thanks,
Sylwester
