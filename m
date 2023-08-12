Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C440EB64DD
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Aug 2023 02:02:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6662A82A;
	Sat, 12 Aug 2023 04:01:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6662A82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691805748;
	bh=rNbl8qxbyJJcKxmVj7kxuK0nzZioJI2hGiYbGM61zQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EpHislCS+X/JyjG0Qszu3BrT4bAGfANYEqz+4KF6691uy1yqpWoqorXTgBx4i/DTc
	 QmgMP/J2AxQ3mXVI7hKIz/UiZqklDdERCSWZjVfEKAde4Y4gVD2Lm/nFE2qz/qLBzL
	 3tkT+RPTZAduXm2yJTv1l3yxUmiJ9EPVJMOuJEZk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA402F80134; Sat, 12 Aug 2023 04:01:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3736CF80166;
	Sat, 12 Aug 2023 04:01:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9098F80166; Sat, 12 Aug 2023 04:01:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D6DEFF800FB
	for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2023 04:00:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6DEFF800FB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Kpocs/H9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DB22363394;
	Sat, 12 Aug 2023 02:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E9C433C7;
	Sat, 12 Aug 2023 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691805653;
	bh=rNbl8qxbyJJcKxmVj7kxuK0nzZioJI2hGiYbGM61zQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kpocs/H9CJKF2NIY81ejYcjI3FyWLvo2eNHu+hqrsI4WayaknSOGD+0/wbMXI/+PQ
	 JBcp3uBd/v0WtZR0B7Q1SMGlhv36uMAJ3Jj3EXytpM5F+vWE6zyaEcRas5N9xB+pK1
	 dojO9jHO/YAkxSqDT6/FSLEloXuLXSz02OPI98kPKgB6kZ4bmyPwXzMDEeLX3voAIo
	 JddhPjW2XiKgeGf3mbiNecQR7sn5nxO8YHG0yXjLI/9xyfaJbtxwYhjy9KlXD27n1e
	 Usg9uT/6X46R5ilzsv5Rnd/JM6WkSdcPcoMigIhVt09xdcRxoSHr4krhDwItA5NIDM
	 +8zhpQV2vv/hA==
Date: Sat, 12 Aug 2023 10:00:37 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, kernel@puri.sm,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	David Heidelberg <david@ixit.cz>, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5-devkit: Mark buck2 as
 always on
Message-ID: <20230812020037.GH151430@dragon>
References: <cover.1691684726.git.agx@sigxcpu.org>
 <513d6f6d1525ad9f7996a9976c06b2a858f8a6a4.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <513d6f6d1525ad9f7996a9976c06b2a858f8a6a4.1691684726.git.agx@sigxcpu.org>
Message-ID-Hash: C5CMRQLYC6T5CUWBHYKTUQ3GWQXIVFZ3
X-Message-ID-Hash: C5CMRQLYC6T5CUWBHYKTUQ3GWQXIVFZ3
X-MailFrom: shawnguo@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C5CMRQLYC6T5CUWBHYKTUQ3GWQXIVFZ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Aug 10, 2023 at 07:59:50PM +0200, Guido Günther wrote:
> Otherwise the A53 cores are shut down which doesn't end well.
> 
> Reported-by: David Heidelberg <david@ixit.cz>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
