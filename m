Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E73DC2BD05
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:53:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A973BB65;
	Mon, 24 Jun 2024 10:52:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A973BB65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719219186;
	bh=tbtZYVbQLro8sFxxPVvhwFiL36HLsgTQevnhEb2DJJc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NCTmGemSjjDufK0+KG2TmatEkZ9wbZJKgy1Gk4ozYpMGCcXcbmnkjFMf3MdFn4VAi
	 m4mcnLC2yLFKDCVbTeO3RVwk1hCCYPdrZWIZSPtneRvRUmIZnhYMPObIN/ImmK9usO
	 s1EunDi1LVgBVCdngePQW9iqvQkURet4yoikFDwc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F216BF805F4; Mon, 24 Jun 2024 10:52:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59D6DF80607;
	Mon, 24 Jun 2024 10:52:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44F45F80495; Mon, 24 Jun 2024 10:52:01 +0200 (CEST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CE9D3F80154
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 10:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE9D3F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com
 header.a=rsa-sha256 header.s=DFC430D2-D198-11EC-948E-34200CB392D2
 header.b=Lb/JDqYv
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A16229C5B37;
	Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1bgfUhXbQxyf; Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 12A3E9C0760;
	Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 12A3E9C0760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719219116; bh=ywUot3rVde8QyC4XFzB69VkfFZ81TabakSY7pKOGwNI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Lb/JDqYvbCLOxwHnIAGfWllK8kIIRjuyG8PuIPzCh1ronj7Exjf3inbdEeyFSMJxT
	 M1nnT5HyczGirf+cvKnulquvAgW6pOcmEkt/VI0W3lVYe6qhNYmAH2aHuoRQViLaag
	 f21KX2A7RMc+uoZTixi1gMnHxKh+xvQ8Tme5n11IzQSxN3axsXCXOIrvM+R8OsswRI
	 t1j8EVj0Tx+x5OFtnLHH08HckNFlENjyeGYu2szqnCUBcehEIsJ+GjMMmQG2ApOnDY
	 nLgA8h7svYlxiGkAdxU3cVIsPIk88YTHxq5/RA7BmIpGEaPTDx/l2UJCuIuZfDU+OF
	 TIVWSVv01UkAw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qeHu2LUwBW_G; Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B87A49C5B37;
	Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
Date: Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>, imx <imx@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: 
 <676829420.1714448.1719219115719.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <2c32e077-48ef-4d08-99ce-9072a339740c@kernel.org>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
 <20240620132511.4291-9-elinor.montmasson@savoirfairelinux.com>
 <2c32e077-48ef-4d08-99ce-9072a339740c@kernel.org>
Subject: Re: [PATCHv5 8/9] arm64: dts: imx8m: update spdif sound card node
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112
 (Linux)/8.8.15_GA_4581)
Thread-Topic: arm64: dts: imx8m: update spdif sound card node properties
Thread-Index: OrrUPkiV572zhM5QFQUzINFUm+660w==
Message-ID-Hash: 5BQMYVYJA7CU2VFFUL3TKZQMRMHTFI27
X-Message-ID-Hash: 5BQMYVYJA7CU2VFFUL3TKZQMRMHTFI27
X-MailFrom: elinor.montmasson@savoirfairelinux.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5BQMYVYJA7CU2VFFUL3TKZQMRMHTFI27/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: "Krzysztof Kozlowski" <krzk@kernel.org>
Sent: Sunday, 23 June, 2024 13:10:48
> On 20/06/2024 15:25, Elinor Montmasson wrote:
>> Following merge of imx-spdif driver into fsl-asoc-card:
>> * update properties to match those used by fsl-asoc-card.
>> * S/PDIF in/out dummy codecs must now be declared explicitly, add and
>>   use them.
>> 
>> These modifications were tested only on an imx8mn-evk board.
> 
> So new DTS will not work on old kernel... Can you at least explain why
> this is needed and what benefits this make? You change hardware
> description, so whatever you merged in drivers is not really relevant, I
> would say.


Ack, I will explain the reasons in the commit message,
which are in my answer to your review of commit 7/9.


Best regards,
Elinor Montmasson
