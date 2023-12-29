Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CE7C46CD2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 19:23:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAE1AEBF;
	Tue,  2 Jan 2024 20:23:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAE1AEBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704223416;
	bh=ph7ij4+ZkuUz9sCGgTOqw+5Pqej5w0puw7xye6OPFp0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fmCU4ZHbp0reuNzWlmL7cc/FrLdQfb24o/+YXsccxiqaizT87glpqntD/K7xwUjs4
	 qqh/fasqBDz/PcXCkd6wgH0yW8LXJ31hDu+1naNnztfQ/6PMtx4BVsb1ptwtgEZSaZ
	 yLPh64QZhG4vE4TEYfZFBObcU/F3iswvMlfZSm+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86A10F805BB; Tue,  2 Jan 2024 20:23:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F20F0F805AE;
	Tue,  2 Jan 2024 20:23:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84C8CF80558; Tue,  2 Jan 2024 20:23:00 +0100 (CET)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C664EF80224
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2024 20:22:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C664EF80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com
 header.a=rsa-sha256 header.s=DFC430D2-D198-11EC-948E-34200CB392D2
 header.b=po3U1yBC
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0A2DD9C330F;
	Fri, 29 Dec 2023 08:45:45 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RDHQVC7hAZsW; Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E1B49C3380;
	Fri, 29 Dec 2023 08:45:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E1B49C3380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703857544; bh=Lyk686/x2Ez5b2w7VD1NWpu9PQmISjz21nS2j3Knoo8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=po3U1yBCDfCq7u3iTDEhMpY8CICqIY+mxPesFY9awIGMWGOZBSA/zcCmtcejahKEW
	 NxEnYNdHTH3keUrQoK5VIZddX58OzHZF1Hff7Os09Z1MeHnvX14ykUwhVJpfvaEphu
	 2xtN3k4Jbr//2Z+G7Lww8H0I944uvqDPcHqGbqwVRz4rYcmOR/C+O3cMFszFNaU/BS
	 CBGXnjsKjfYSoQysu3xVtrJmDCqOSNfRojHHrAVWVqlSXpcpAkfhfViPUEzCTNjpL2
	 ynpe8QHWMOaX0o7K/AQ+KC3XVGR9c//FwgX16u/rbZpvEm9na8cOAcv0dqSrRfDxxz
	 0b26rCZdsiuaA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sSUMGHPKYEW5; Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 515039C330F;
	Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Date: Fri, 29 Dec 2023 08:45:44 -0500 (EST)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: 
 <361044647.7067.1703857544284.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: 
 <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com>
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
 <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com>
 <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com>
Subject: Re: [PATCHv3 RESEND 00/10] ASoC: fsl-asoc-card: compatibility
 integration of a generic codec use case for use with S/PDIF controller
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112
 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: compatibility integration of a generic
 codec use case for use with S/PDIF controller
Thread-Index: lu32M+7WowvRn2WxYZZGeiz9hy0xKkRA+mdz
Message-ID-Hash: JHTU7SQPWN33UZTPQR6DKTTXLKQ2BP5R
X-Message-ID-Hash: JHTU7SQPWN33UZTPQR6DKTTXLKQ2BP5R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JHTU7SQPWN33UZTPQR6DKTTXLKQ2BP5R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello

On Monday, 18 December, 2023 14:54:03, Daniel Baluta wrote 
> I know this is extra-work but we would greatly appreciate if you first 
> convert fsl-asoc-card.txt 
> to yml format and then add your new properties. 

DT schema must have at least one maintainer in the "maintainers" field.
Who should I put for fsl-asoc-card.yaml ?

Best regards, 
Elinor Montmasson 

