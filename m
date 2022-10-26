Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA3C38A2D
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Oct 2022 14:33:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FECE3CB1;
	Wed, 26 Oct 2022 16:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FECE3CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666794778;
	bh=j/+TzUZKjPg6AiDdPdUrU7skNxekli5IAwJzr55tM8E=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpyXnoUXJf7U6ifE+KpTYgYx7FFOX7F73hL0b8jdsnqSan8y9nDgJredNxisPAiYY
	 JAAzjUKruRAwyo3Oo1gUwgaopIt9V8Sx7G0c0bgTbwck0F9P44qTCeRP+qtdhMhLJZ
	 Tu4DiCHScGSwx7KRL0fkbJwdkfWo7OJZVa9VbEs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1BE6F80240;
	Wed, 26 Oct 2022 16:32:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0616DF80271; Wed, 26 Oct 2022 16:32:07 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DFADF80100
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 16:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DFADF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="L7ocpzWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666794721; x=1698330721;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=j/+TzUZKjPg6AiDdPdUrU7skNxekli5IAwJzr55tM8E=;
 b=L7ocpzWKFDu3Pkk7IAL+bwSe92qntaZFh3Hft4y0/YDc49h/uEBOWMlB
 nwiooJwHY5sNS2mYSZjKWhmeZZTJuPdXi4QGcPZ/Rj0N/ZoRkMWQxwd1e
 EIOm0hOa/O+rDtvkm42Ochum1yIIKnv6d5ibxaONSjswQ17iNDY9fvj+l
 BruboRBsgG5PCYKTAwpTU6uzaEfdPQeq4NbB0E+3+UuMnX47XWwx9YKbH
 0pOUNs7o1H74lDioTwQmt6r7inw1f5OfwbI3t6FKAAr8fWYnJa1KQ0+a7
 7rZwWqClo3ta6XLEpku96DLDW83lDacYdhOpglweLHscdNjIPumDWoMC5 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="306688279"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; d="scan'208";a="306688279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2022 07:31:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="609972132"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; d="scan'208";a="609972132"
Received: from chaosong-mobl.ccr.corp.intel.com (HELO [10.255.29.191])
 ([10.255.29.191])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2022 07:31:24 -0700
Message-ID: <69fa20ca-da52-b85f-ffcc-66a533471568@linux.intel.com>
Date: Wed, 26 Oct 2022 22:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] ASoC: sun50i-dmic: avoid unused variable warning for
 sun50i_dmic_of_match
Content-Language: en-US
To: Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org
References: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
From: Chao Song <chao.song@linux.intel.com>
In-Reply-To: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On 10/23/2022 3:44 PM, Ban Tao wrote:
> In configurations with CONFIG_OF=n, we get a harmless build warning:
>
> sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
> 'sun50i_dmic_of_match' [-Wunused-const-variable]
>
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
> v1->v2:Add "Acked-by" tag.
> ---
>   sound/soc/sunxi/sun50i-dmic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> index 86cff5a..62509cb 100644
> --- a/sound/soc/sunxi/sun50i-dmic.c
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -391,7 +391,7 @@ static const struct dev_pm_ops sun50i_dmic_pm = {
>   static struct platform_driver sun50i_dmic_driver = {
>   	.driver         = {
>   		.name   = "sun50i-dmic",
> -		.of_match_table = of_match_ptr(sun50i_dmic_of_match),
> +		.of_match_table = sun50i_dmic_of_match,
I don't think this is the right direction (remove the of_match_ptr) to 
fix the issue.

of_match_ptr(of_table) returns of_table if CONFIG_OF=y, and returns NULL 
if CONFIG_OF=n.

So guard  the definition of sun50i_dmic_of_match with `#ifdef CONFIG_OF` 
should be better.

Many other drivers do it this way.

>   		.pm     = &sun50i_dmic_pm,
>   	},
>   	.probe          = sun50i_dmic_probe,
