Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80994C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 20:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3945B60E54
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 20:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3945B60E54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55D4616CE;
	Mon, 11 Oct 2021 22:18:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55D4616CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633983548;
	bh=GZJDcbARWQB5iOx0R46M91bP4R1bGWWmn0R4ycRE+gk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOn261FLAQyAqNA6wZ0iQCtZAHUotCSn5e4tneyvbP2+ibPR+2u+BApGWR4lwhVe3
	 lFqx7hcgp7/WSfD46CyceBiYN9vTs/SoL9YH8mySyNVh5fkLoFDirv4flUCG5JiPq7
	 0fMYTYIOqpyGS5ugAfzJWbfr9DVgC7n6mrPDiR/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D92ABF8025B;
	Mon, 11 Oct 2021 22:18:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34737F80269; Mon, 11 Oct 2021 22:18:16 +0200 (CEST)
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CB72F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 22:18:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CB72F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Mx+UIY8A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6BfPWdxhcFBaDDiqb/ocng4a5UziACoHk6Kt3bc/Ucs=; b=Mx+UIY8Ae1UxIFrrPnDylXYQ+x
 FAia0x7Uo+IMLcLAywfKlbBvmNrfZ6GlEISlRNiryrXFcluXOOICS7leMouGEqiz+gmcrDe75W6w2
 Eg807Pi78UdLS6byK37MYl+Dp+kBDbUDtOAr6p5onCY9g3bf0ISgRdnwk6QClWb5nU8DFHObEQzSZ
 SNtwcgszHmmyBgelkgRLcme2w05lp8z1XJ2H6FRJ3A6NP7LCM/PA19YrSr1zb/Bz6uu7STLCd5opk
 b4R0segMo8Mb5nhBLQrBecw2mzOF95oVXSayxRtK2Xf/Bb85Snngg4i7dmPRBo+3X74NBq7Eb/GTg
 Fyh/DqRA==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ma1kL-00AaLK-Ir; Mon, 11 Oct 2021 20:18:05 +0000
Subject: Re: [PATCH v2 5/8] ASoC: amd: acp: Add legacy sound card support for
 Chrome audio
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
 <20211011154452.76849-6-AjitKumar.Pandey@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c3a93858-65ee-d68e-d805-4248850e8553@infradead.org>
Date: Mon, 11 Oct 2021 13:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011154452.76849-6-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sunil-kumar.Dommati@amd.com, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Vijendar.Mukunda@amd.com,
 Alexander.Deucher@amd.com
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

On 10/11/21 8:44 AM, Ajit Kumar Pandey wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index 5cb7115662d2..2b9440372346 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -34,3 +34,9 @@ config SND_SOC_AMD_MACH_COMMON
>   	depends on X86 && PCI && I2C
>   	help
>   	  This option enables common Machine driver module for ACP.
> +
> +config SND_SOC_AMD_LEGACY_MACH
> +	tristate "AMD Legacy Machine Driver Support"
> +	select SND_SOC_AMD_MACH_COMMON
> +	help
> +	 This option enables legacy sound card support for ACP audio.

Add one more space just before "This" to conform to kernel Kconfig
style, please.

-- 
~Randy
