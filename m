Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C24BCD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:47:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AEB8601AA;
	Mon, 11 May 2026 16:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AEB8601AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510827;
	bh=QsLYeqoRpxH6BMcbjJy4UDYAnoo+40W8WyaEDfEFP8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RdhC/NbhKgPtvDMJZDdY93OwVixS5y9DpXFBMKoHVnM2SafvVLJax0RLpU79Pk6gP
	 cOI2w/95Et7Vb3cmnditBlUIqsVyYaR5BHOiMxaoAq16bb7eP+GKh6K1nXzk/W+ugg
	 GTUeMTC9cn1i5LWY2+s/Pc5jduhLZcyNSNlurXho=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 295ECF806F9; Mon, 11 May 2026 16:44:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0B53F806F1;
	Mon, 11 May 2026 16:44:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AD3FF80518; Thu,  7 May 2026 21:36:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CC16F8007E
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 21:36:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CC16F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XYxE/qFq
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CD6BE60181;
	Thu,  7 May 2026 19:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F18C2BCB2;
	Thu,  7 May 2026 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182606;
	bh=QsLYeqoRpxH6BMcbjJy4UDYAnoo+40W8WyaEDfEFP8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XYxE/qFqUg6HhMwU7PT3a3S9A3FcURy+akKstjw046typ3LWImxDTvYt4OSwv0CXa
	 khkh0E9OyTryf4gT+4Iws81NRNN+aFui4pOa6mRZutHVdG3RXd6yuAzIbZN0wAo3xY
	 0HyjFQAehPmDPq8KyWNxu5IeI6FysnvK/nK4rKkI+FvZsBgJOnqGeU96It6sRSRDa+
	 leUmLm7L1CroVbf2vSFgPkqzpMcVdpBRk6va4fkttLsYYRl0GBlakf+5fBoNSlNcOd
	 fLYW+S4JtyK3TvrEjVS7CS113p7o6ax3hQYyT8MjXyelP2mQoocg37tHHUWHDnomzv
	 F7Mpgk3G4JKSw==
Message-ID: <1cb541aa-13f4-4836-b4d0-fe3c50c032af@kernel.org>
Date: Thu, 7 May 2026 14:36:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ASoC: amd: enable acp7.x drivers build
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-5-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260507181251.20594-5-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LCLZXVMDLZLFBLFS3GPXWC3D54INGJRR
X-Message-ID-Hash: LCLZXVMDLZLFBLFS3GPXWC3D54INGJRR
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LCLZXVMDLZLFBLFS3GPXWC3D54INGJRR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/26 13:11, Vijendar Mukunda wrote:
> ACP7.x drivers can be built by selecting necessary
> kernel config option.
> The patch enables build support of the same.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   sound/soc/amd/Kconfig        | 10 ++++++++++
>   sound/soc/amd/Makefile       |  1 +
>   sound/soc/amd/acp7x/Makefile |  5 +++++
>   3 files changed, 16 insertions(+)
>   create mode 100644 sound/soc/amd/acp7x/Makefile
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 53139766fafb..9f4f1f4ac3f8 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -174,5 +174,15 @@ config SND_SOC_AMD_PS_MACH
>             Say m if you have such a device.
>             If unsure select "N".
>   
> +config SND_SOC_AMD_ACP7X
> +        tristate "AMD Audio Coprocessor-v7.x support"
> +        depends on X86 && PCI && ACPI
> +        help
> +	  This option enables Audio Coprocessor i.e ACP7.x
> +	  variants support(ACP7.D/7.E/7.F). By enabling this flag build
> +	  will be triggered for ACP PCI driver.
> +	  Say m if you have such a device.
> +	  If unsure select "N".
> +
>   endif
>   endmenu
> diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
> index 23b25ff0d800..ef2b36d47705 100644
> --- a/sound/soc/amd/Makefile
> +++ b/sound/soc/amd/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_SND_SOC_AMD_ACP6x) += yc/
>   obj-$(CONFIG_SND_AMD_ACP_CONFIG) += acp/
>   obj-$(CONFIG_SND_AMD_ACP_CONFIG) += snd-acp-config.o
>   obj-$(CONFIG_SND_SOC_AMD_PS) += ps/
> +obj-$(CONFIG_SND_SOC_AMD_ACP7X) += acp7x/
> diff --git a/sound/soc/amd/acp7x/Makefile b/sound/soc/amd/acp7x/Makefile
> new file mode 100644
> index 000000000000..9426e3b47c08
> --- /dev/null
> +++ b/sound/soc/amd/acp7x/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# ACP7.x variants platform Support
> +snd-pci-acp7x-y := pci-acp7x.o acp7x-common.o
> +
> +obj-$(CONFIG_SND_SOC_AMD_ACP7X) += snd-pci-acp7x.o

