Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DBC11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:32:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB620836
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FjRW4Pfj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4/tVjd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C962D168A;
	Mon, 24 Feb 2020 17:31:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C962D168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582561941;
	bh=BQWI4/PlqUwE2LdzkRyV2Wg27jJHrbNJcGf4ChBc3Xs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjRW4PfjFYEofTIi9/iw7GrRwdqI72utjouLWtZ8PW0dJ22C2q3/XBub+fT57AZEH
	 7Apm3LihrhbDOhj+5VBGeTTQEtwm9I7IVLQxXCW36V+0Wu0pIkoNxnoVOzPbfK5gsx
	 bvjPdoJFSA7fKgsL/yjHNzfdfKFTSFdigXIpzcs4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65EB1F80137;
	Mon, 24 Feb 2020 17:31:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0176FF8016F; Mon, 24 Feb 2020 17:31:29 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91E0EF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 17:31:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91E0EF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="I4/tVjd7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qh1LUc+qxPHEVoho6FaU1vCoNs7OEstk4AiDTBBk/Bo=; b=I4/tVjd7cQH/PskjU6+l3QSZ5/
 Fo5TtMoEvO9vFR+dVEvxJQMHwu94R/1Eb6PQyp+L3gP446cMb73QLJVTGnPKkiB02f4xoN2KeH0Sx
 /2WpDaCoklEyqK3OdB0Sg5ew6kLIST3tWfV8Yz1qROK0+8L/Ye0V4SASIlp78U1jyvOFWVN9jVu1h
 vvQgBodx7XJXEHN9UohBU0hVpjUZGGMUcIH6GfmL3feUoQpBFk6ROzMaYX50anXza4ZrX6ljzTQTC
 AUMqkRFOdQcyc4LqmditI6nA0SSwUvK0R8FvpGcY1i0rXP9Mh5Hm2W35Hj1qZLBQQy5avC49UKGGQ
 tscH4WBQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Gdb-0003UZ-47; Mon, 24 Feb 2020 16:31:19 +0000
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
References: <20200224112537.14483-1-geert@linux-m68k.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eac16b4c-8920-78a0-6ca5-dd72cf83888d@infradead.org>
Date: Mon, 24 Feb 2020 08:31:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224112537.14483-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On 2/24/20 3:25 AM, Geert Uytterhoeven wrote:
> On i386 randconfig:
> 
>     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
>     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
>     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
>     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> 
> Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Before commit ea00d95200d02ece ("ASoC: Use imply for
> SND_SOC_ALL_CODECS"), SND_SOC_ALL_CODECS used:
> 
>     select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
>     select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
>     select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
> 
> but SND_SOC_AC97_BUS_NEW never existed in upstream.
> Should there be another dependency>
> 
> See also "non-existent SND_SOC_AC97_BUS_NEW (was: Re: [PATCH v9] ASoC:
> pxa: switch to new ac97 bus support)"
> http://lore.kernel.org/r/CAMuHMdU3uxfBwKd8SkOtZSDV5Ai3CKc3CWRhDy0Cz94T1Hn0iA@mail.gmail.com
> ---
>  sound/soc/codecs/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 9e9d54e4576ce5ba..a7e89567edbe8b47 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
>  
>  config SND_SOC_WM9705
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
>  config SND_SOC_WM9712
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
>  config SND_SOC_WM9713
>  	tristate
> +	depends on SND_SOC_AC97_BUS
>  	select REGMAP_AC97
>  	select AC97_BUS_COMPAT if AC97_BUS_NEW
>  
> 


-- 
~Randy

