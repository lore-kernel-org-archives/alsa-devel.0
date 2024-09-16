Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53706C3ABB2
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2024 07:50:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AE1DE85;
	Mon, 16 Sep 2024 09:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AE1DE85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726473050;
	bh=oV/rO+rIUTVYa4h0wxcp7MAVCpDJMSEAlgybJBzpQHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ljIO376biFVDNRgAJiBAeqMbMI3tMf+69bn+/EOHhq2LmJ/oHQ6VGNvVhzXL5RApU
	 okDdgTSGXpPFbPxpOj3YaalN2nqJdTWEKXv3XMGuwHoMrquZOFid+mnALg5vtNopDT
	 ehDgfXN7Efrc2RPbrOdPkFmaBAhpuZFd8gDxcTXc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32D0DF805B5; Mon, 16 Sep 2024 09:50:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDCF5F805B4;
	Mon, 16 Sep 2024 09:50:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 157B3F8020D; Mon, 16 Sep 2024 09:50:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40E48F80107
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2024 09:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40E48F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZKFdAhXt
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A4995C035D;
	Mon, 16 Sep 2024 07:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F9C4CEC4;
	Mon, 16 Sep 2024 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726473010;
	bh=oV/rO+rIUTVYa4h0wxcp7MAVCpDJMSEAlgybJBzpQHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKFdAhXtphS6fWKaRpjmKRfIr+/wtF+QpBjwKMhu7sLPhNH1T/XgS1DKvbNBRJ/F0
	 g/qrrq44VJddTKMJwZNsuCOaXxog2Hnwogh7AWke2ksY/ZRauBpzNnXzAiq0G4Ipm0
	 eKXF0ao8cRuNRAjLYhulPGN/sv9mJFAFKdE0HCmne15j1cdu7t7kBRRHxDZ92wQm6M
	 81acSv9trf3cLFTCIobGyxm52YXOZrU/7e9BvGQBbcwMgp5SGBGz0GdED/urEm3qz2
	 aAzbdgK12il101jbRmBCb0xJfqpUcULWdl62De1fpCkkyeZ8Qt83Gb8wSdmRDkFbSe
	 9R6Ni5xz99bbw==
Date: Mon, 16 Sep 2024 09:50:08 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <ZufjMLwX4m3ECJoS@vaman>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
 <f4c222e2-cf94-44ec-bc69-0ab758bfb3fa@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c222e2-cf94-44ec-bc69-0ab758bfb3fa@leemhuis.info>
Message-ID-Hash: DXY2VB7BACI6IU6RGO5AYJVJHQKGMLQO
X-Message-ID-Hash: DXY2VB7BACI6IU6RGO5AYJVJHQKGMLQO
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DXY2VB7BACI6IU6RGO5AYJVJHQKGMLQO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 11-09-24, 16:31, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.09.24 14:31, Greg KH wrote:
> > On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> >>> The reverted patch causes major regression on soundwire causing all audio
> >>> to fail.
> >>> Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.
> > 
> > Really?  Commit ab8d66d132bc ("soundwire: stream: fix programming slave
> > ports for non-continous port maps") is in Linus's tree, why isn't it
> > being reverted there first?
> 
> FWIW, the revert should land in mainline tomorrow afaics:
> https://lore.kernel.org/all/ZuFcBcJztAgicjNt@vaman/
> 
> BTW, in case anyone cares: I think this is another report about the
> problem, this time with 6.6.y:
> https://bugzilla.kernel.org/show_bug.cgi?id=219256

Revert has been applied to 6.6 and other stable kernel so this should be
fixed now

-- 
~Vinod
