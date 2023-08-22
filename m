Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBD5EE4996
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Aug 2023 02:50:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C4C5832;
	Tue, 22 Aug 2023 04:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C4C5832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692672605;
	bh=s4Jm6rRfwN1XEB1q4///g0rGuH9LIcFzm1gB7UJ2Bck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ff1REFmoOaYe4TcKVLD8wQHAfKWejmBCfw2XaZGWZYZKKpVJq8waRxeqEjVlwhYNI
	 W37okWu4y9i1h32/S0hWpQlrkxpWOhEez7w/eDu5TVdrk+mDwww6PUQYu2QDEOsx/c
	 rbHc1Qt8mTHWeudfHgh6aq4HVBBr8gSm8Euhv5fI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95819F80536; Tue, 22 Aug 2023 04:48:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B98EDF80158;
	Tue, 22 Aug 2023 04:48:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A071F80158; Tue, 22 Aug 2023 04:48:37 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 042D5F800AE
	for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2023 04:48:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 042D5F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wujxoq7J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Di2rNu71+Hu4u+oVwZ7coemob+4mzedVXoJTf03SuGQ=; b=wujxoq7J6jDyciv1jHyYftfWdi
	pbgTIm6fBdOASAbFrSiduWR66oBlajre2Bhvvh6YeoHxn0+GXLRqpo6YeznNGA4lJXRhMav+vlAsC
	Vm8so5fMOBFG9etSsZrZWmeWtvLyrZc1PKCO2RniVNuqVeXgYtO66ADusxUIQhq5K9V7lsX4ibxVF
	yDRkBI0zb5Snl0RqB1h2g6k9F1jfzQU9sd1tnkbTjERMSbi4f3fjesGy37dEuAW+h+km9am8tHOn2
	AczH72t0qlNzKziNIVgzuwRB7Hle5HZLpgQeRF5rhVDDy6ydCjyNCHtbqcMZ/vUemzQ7LqUb2+Vs8
	0oYEGnyQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qYHRD-00F0d0-1l;
	Tue, 22 Aug 2023 02:48:11 +0000
Message-ID: <d474fe3b-1830-1bfd-d73d-3d79c1098392@infradead.org>
Date: Mon, 21 Aug 2023 19:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ASoC: fsl: merge DAI call back functions into ops
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=83=c2=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
References: <87a5ujubj0.wl-kuninori.morimoto.gx@renesas.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87a5ujubj0.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: I46TLNFL236SBUHDXWAC2UKKK6ABZAXW
X-Message-ID-Hash: I46TLNFL236SBUHDXWAC2UKKK6ABZAXW
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I46TLNFL236SBUHDXWAC2UKKK6ABZAXW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 8/21/23 18:10, Kuninori Morimoto wrote:
> ALSA SoC merges DAI call backs into .ops.
> This patch merge these into one.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308152047.psX1QNDh-lkp@intel.com/
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 446b31e89493 ("ASoC: soc-dai.h: remove unused call back functions")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/fsl/mpc5200_psc_ac97.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
> index 40a4a2667394..1671bcd4ee3d 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -222,6 +222,7 @@ static int psc_ac97_probe(struct snd_soc_dai *cpu_dai)
>   * psc_ac97_dai_template: template CPU Digital Audio Interface
>   */
>  static const struct snd_soc_dai_ops psc_ac97_analog_ops = {
> +	.probe		= psc_ac97_probe,
>  	.hw_params	= psc_ac97_hw_analog_params,
>  	.trigger	= psc_ac97_trigger,
>  };
> @@ -233,7 +234,6 @@ static const struct snd_soc_dai_ops psc_ac97_digital_ops = {
>  static struct snd_soc_dai_driver psc_ac97_dai[] = {
>  {
>  	.name = "mpc5200-psc-ac97.0",
> -	.probe	= psc_ac97_probe,
>  	.playback = {
>  		.stream_name	= "AC97 Playback",
>  		.channels_min   = 1,

-- 
~Randy
