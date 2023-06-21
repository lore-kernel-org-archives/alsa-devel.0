Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531DEB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 10:52:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3525C822;
	Wed, 21 Jun 2023 12:51:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3525C822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687344766;
	bh=1kZA/ZWjzG5usQ5GqlzqPsiXwNKPSaidlzP7qa/Trt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gWbKfBYsiJAjGb+nX3L8jccUWmvYImA5rx/t0sDtvczlMqkKPFl7BFNnlPd3g/vak
	 ltEYH5iyR6J2BL2gWWA+7FOAji72zaE9MqlfBM6BnQbwAsWoSn7UjAiZNpcRTFF4OQ
	 JcHcKS3yXrsyT0toFhfdfBSC0sVpOb5DFcrznZPg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E37F6F80022; Wed, 21 Jun 2023 12:51:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D048F80022;
	Wed, 21 Jun 2023 12:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5ABB4F80141; Wed, 21 Jun 2023 12:51:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1ECEF80022
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 12:51:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1ECEF80022
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AUgkeL9A
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 71FFE614F7;
	Wed, 21 Jun 2023 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E5C433C0;
	Wed, 21 Jun 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687344679;
	bh=1kZA/ZWjzG5usQ5GqlzqPsiXwNKPSaidlzP7qa/Trt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUgkeL9ADvrwRmG0xIOAbOBTHSY5srqR+zFdZHjCl34eFkP1h3JnJPvGGqDe+tpz6
	 bfbv+DHE625NBP3H4mgXPizSn3ZsUZ9+mKHk2biaze2QJ9X1vD4qSuO74cO/ZcJMAc
	 XLQDnkVl/NOYKcfFF8SBVL0xC9BvCHNfSoVlXnBoNR8QLWQnVC5zZu75ZW6ooPA+fb
	 TiGx55frIkJxLoUMvqL+iFj+sz+h4frJbTuAJMiFZJEcBDJzofzgCDdZo9YjzmTSwu
	 Vh/zT/eaQaOxS/FsBK503iQPG7CwKfK1UAwDb/c98cB9BLZraA5J/Mrpbd6CEJYmby
	 6/GtIWhjqFjYQ==
Date: Wed, 21 Jun 2023 16:21:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Rander Wang <rander.wang@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel_ace2x: fix SND_SOC_SOF_HDA_MLINK
 dependency
Message-ID: <ZJLWIw5nMhFcaoSe@matsya>
References: <20230616090932.2714714-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616090932.2714714-1-arnd@kernel.org>
Message-ID-Hash: 7T2TBQDEZEN7MB645UI23WYPIY3UQTUZ
X-Message-ID-Hash: 7T2TBQDEZEN7MB645UI23WYPIY3UQTUZ
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7T2TBQDEZEN7MB645UI23WYPIY3UQTUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 16-06-23, 11:09, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ace2x driver can be build with or without mlink support, but
> when SND_SOC_SOF_HDA_MLINK is set to =m and soundwire is built-in,
> it fails with a link error:
> 
> ld.lld: error: undefined symbol: hdac_bus_eml_sdw_wait_syncpu_unlocked
> >>> referenced by intel_ace2x.c
> >>>               drivers/soundwire/intel_ace2x.o:(intel_link_power_up) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: hdac_bus_eml_sdw_sync_arm_unlocked
> >>> referenced by intel_ace2x.c
> >>>               drivers/soundwire/intel_ace2x.o:(intel_sync_arm) in archive vmlinux.a
> 
> Add a Kconfig dependency that prevents that broken configuration but
> still allows soundwire to be a loadable module instead.

Applied, thanks

-- 
~Vinod
