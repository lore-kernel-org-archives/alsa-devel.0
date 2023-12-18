Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467D0C35274
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Dec 2023 22:11:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 803A5843;
	Mon, 18 Dec 2023 23:11:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 803A5843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702937470;
	bh=V67jUA/X4iuuyWPHvIFmIMQeerw4rwp8jEY/OLK5Slg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JMCzhpwipnyAzSMigl/Bwd0+iv8yQfac38bg90/qOfrLMYRPJQICjh484v6zgHJS1
	 GhqHi6OLOaNhIEyTuLxCeeJJyz/BBim+aoucA4lspY3tUCcZI/8hsk4kFeAPGJDCfJ
	 vZBo00UcHbWXNZcQXLGa3dKDSMYupGjGDDt8z4Vs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 588F3F8057A; Mon, 18 Dec 2023 23:10:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4421F80579;
	Mon, 18 Dec 2023 23:10:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CDE0F80425; Mon, 18 Dec 2023 23:10:29 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C22A6F800BD
	for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2023 23:10:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C22A6F800BD
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E1BDC6343B3B;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9keEN92ZV6OF; Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6AB616343B3C;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nR8uZpRh0SkQ; Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2459D6343B3B;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Date: Mon, 18 Dec 2023 23:10:20 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	pratyush <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	sbinding@opensource.cirrus.com, Lee Jones <lee@kernel.org>,
	james schulman <james.schulman@cirrus.com>,
	david rhodes <david.rhodes@cirrus.com>, rf@opensource.cirrus.com,
	Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	michal simek <michal.simek@amd.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Message-ID: <1953466568.133535.1702937420979.JavaMail.zimbra@nod.at>
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel
 memories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97
 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add support for stacked/parallel memories
Thread-Index: Gp+EE7t5zvexUhLdnkyaadGyCIq7oQ==
Message-ID-Hash: ZN6VDFCZD7HLBCBUKAXGOQ7P45PJRSMB
X-Message-ID-Hash: ZN6VDFCZD7HLBCBUKAXGOQ7P45PJRSMB
X-MailFrom: richard@nod.at
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZN6VDFCZD7HLBCBUKAXGOQ7P45PJRSMB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Amit Kumar Mahapatra" <amit.kumar-mahapatra@amd.com>

> This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> driver to add stacked and parallel memories support.

I wish the series had a real cover letter which explains the big picture
in more detail.

What I didn't really get so far, is it really necessary to support multiple
chip selects within a single mtd?
You changes introduce hard to maintain changes into the spi-nor/mtd core co=
de
which alert me.
Why can't we have one mtd for each cs and, if needed, combine them later?
We have drivers such as mtdconcat for reasons.

Thanks,
//richard
