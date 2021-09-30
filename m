Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86FC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 22:09:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A60619F8
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 22:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31A60619F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71F8D16AC;
	Fri,  1 Oct 2021 00:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71F8D16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633039778;
	bh=xc2hch22I8TxrfN+EYo5PyCj4pr6sOYB4IKHC1BOEOk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHZ6t9h0p7bD+qWtUz90cAhjE2rt6DbXAgVm0clU5C+giZS0lulYoUwzhxg8EpniC
	 MS6uhuB4rTJBPSZKzwiZ3ryWaN0Zx3hIRtTvnKQJEWfBrpgA71gghde6yyaNq37yTD
	 9+JA1kzj0P8Eyd4jviAqgeB8u+05CwsG4KgT9wM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 119E5F804AD;
	Fri,  1 Oct 2021 00:08:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E417CF804BC; Fri,  1 Oct 2021 00:08:45 +0200 (CEST)
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BFAEF800F3
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 00:08:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BFAEF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="vlZfDKu1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=7NdS6+teQK03rYflLZeIrWr135Yc2zIWK5XSmPMC1G4=; b=vlZfDKu189SubPvbmY8TZfv1FJ
 6vs2aDjYFjP2bi9gxinALr0dLDBk9TvLivAckOfVKc/M1lWoghDf+A4HNDB1ggzThlsSUNcVlVZUm
 T/QmUaTvpPNijeKXbU73GnfEnbxHg6v1PbMrdETxydTE9ste5VV0COwHatO+xGZ1diSquIzBnJ89F
 dDiANb0E4wHK4pbca/VwVtnqRmHv7gpkJyLVdI6JEIcsRPbUndTJV0BQTfNmyOk2uIwlqUZ8SGiSO
 OFvu1OEealYRDKv4Gi8O+DOvJqsFybbVDzARYxArxj2vf2vXWz8Zee8DsOjeunL4qsXNsomRZmx3Q
 VePfNzOw==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mW4E9-00G5FH-HR; Thu, 30 Sep 2021 22:08:29 +0000
Subject: Re: [PATCH 4/8] ASoC: amd: acp: Add generic machine driver support
 for ACP cards
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210930132418.14077-1-AjitKumar.Pandey@amd.com>
 <20210930132418.14077-5-AjitKumar.Pandey@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5d067d7-b9de-da47-87ba-47653812907b@infradead.org>
Date: Thu, 30 Sep 2021 15:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930132418.14077-5-AjitKumar.Pandey@amd.com>
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

On 9/30/21 6:24 AM, Ajit Kumar Pandey wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index a11182861f49..1ad811707a68 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -24,3 +24,12 @@ config SND_AMD_ASOC_RENOIR
>   	depends on X86 && PCI
>   	help
>   	 This option enables Renoir I2S support on AMD platform
> +
> +config SND_SOC_AMD_MACH_COMMON
> +	tristate
> +	select SND_SOC_RT5682_I2C
> +	select SND_SOC_DMIC
> +	select SND_SOC_RT1019
> +	depends on X86 && PCI && I2C
> +	help
> +	 This option enables common Machine driver module for ACP

Same comments for patch 4, 5, and 6 as given for patch 2.

thanks.
-- 
~Randy
