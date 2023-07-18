Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E39EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 13:37:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADC1E7F4;
	Tue, 18 Jul 2023 15:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADC1E7F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689687427;
	bh=HMGnfP7a18Hb5/1wkqaKdgbdAOS3DZhvpj4y3ByHjF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ffGPgXgvse2ShMM6HoxoJk/nIHBrGX000GMEIbDyA3dn/kmlrU/+Bf8QWGqYMAI5y
	 i1fFPy+AU2Nqec+Z6jFODQUrjqElXnkblE4V6dt2hdJ+qlNUfsnN4qCueupKAcCOeZ
	 tKO2C7skgHCdCR92SPXqRS26O6dIpsMpK5F1BHQA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2504CF80544; Tue, 18 Jul 2023 15:35:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9FFAF80549;
	Tue, 18 Jul 2023 15:35:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DE59F8032D; Tue, 18 Jul 2023 15:35:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BC53F80153
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2023 15:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BC53F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=ziMzr2Vn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2A57761597;
	Tue, 18 Jul 2023 13:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64B7C433C8;
	Tue, 18 Jul 2023 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689687319;
	bh=HMGnfP7a18Hb5/1wkqaKdgbdAOS3DZhvpj4y3ByHjF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ziMzr2VnYTCnLaqm4hFabvD+IIzgnnJLhUm1ZfPfvm5zaXDKU2NL4MMPF1n7cnU2S
	 cu8LKWmga3zikp5StlrGutUNtvQu6OVtktVo/0cM2ISL7VFKgl/ZG92xb6LP/ICFI2
	 8ZOMSD8QVHMj0JvF3xl3GNy6fkwZ7BWcFK/GbjIc=
Date: Tue, 18 Jul 2023 15:35:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 1/5] driver core: Provide stubs for !IOMEM builds
Message-ID: <2023071808-obnoxious-flyover-af63@gregkh>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
 <20230718-asoc-topology-kunit-enable-v2-1-0ee11e662b92@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <20230718-asoc-topology-kunit-enable-v2-1-0ee11e662b92@kernel.org>
Message-ID-Hash: UOK2YKEWPPE2OTAG6IHZKD6GRXT37YLG
X-Message-ID-Hash: UOK2YKEWPPE2OTAG6IHZKD6GRXT37YLG
X-MailFrom: gregkh@linuxfoundation.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UOK2YKEWPPE2OTAG6IHZKD6GRXT37YLG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jul 18, 2023 at 01:28:42AM +0100, Mark Brown wrote:
> The various _ioremap_resource functions are not built when
> CONFIG_HAS_IOMEM is disabled but no stubs are provided. Given how
> widespread IOMEM usage is in drivers and how rare !IOMEM configurations
> are in practical use let's just provide some stubs so users will build
> without having to add explicit dependencies on HAS_IOMEM.
> 
> The most likely use case is builds with UML for KUnit testing.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/device.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
