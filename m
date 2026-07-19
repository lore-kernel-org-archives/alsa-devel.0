Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4141CC44521
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2026 00:17:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64016601E7;
	Sun, 19 Jul 2026 02:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64016601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784420263;
	bh=RruuB39Av1BdthmiKryF7as/+kOKQKo4wDRnBjXkk4A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OeRlIxSb89hexKsOWsyO/GxHkS4WXeq8K6qR0vrpP+mmUW2Lzx9LgvDRFTYLIto/A
	 rbxSenf+s7s8qsYgI1L6DlPuOyy8Hp/0BO29GGQ3LSI0Me0EcModyRO7kqyd1u4q/z
	 U/FRTSP4dmeNXUk5JekffRAsQrdbaw6GyioWHJCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D72C5F805F6; Sun, 19 Jul 2026 02:17:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB70BF805F9;
	Sun, 19 Jul 2026 02:17:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D26A0F80551; Sun, 19 Jul 2026 02:17:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784420226;
	b=f7BNLcHa7b0NwdpzcaRqGbDrskRM8HRpcOKMxw+poapQ8aDQ9Ajut2rpr4CmloORpRJf
	 8nI0uX8wz7qmvtCcrr1q39jJOoRdafZTffFJBVscHVY8neRsY9rMN90XUx5C69OgtUfmX
	 1QciFsy+xsqEs0FI1369pLSIRgKSaxTcSeIeHPmxie9MDNMf1F03+GaO67VPIXF2zqmKz
	 Ku8XfAVmzLlBv2Nd9hokTDsg3aCGvhexLsz2Ed2j50/Z/Ci4YnBvctxSnujNDU3uMUBmU
	 vXE97L3so1Rf3Ccob7x+4IcrfAhfco5b9IMopomksw2pU9j7+rcs/4N3QchcGN8Jx/g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784420226;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=RruuB39Av1BdthmiKryF7as/+kOKQKo4wDRnBjXkk4A=;
	b=J6DDtZZqkGCKR3PTbzMEIz/V5Ao2sQtlleyXu2CqpEhMZJtUcCZ4pzyTNmes92NKtRNX
	 5ia2MywAP+J/Wd+P9+rEWAJlBkNBoOJecN4qjW66qU0XhxTjpzWuISwSJDwknOmBvTDjl
	 kSIvVvoK7IoCymMz3ML6czwnj/uGjQOM8O9E1XB1g+qP728CYbMBsCSYp0WdP4X0AyAoq
	 njkLcxTmB93URUzaFjGbSYMIWMsO58n5lAytWnRwNzlpO3qQYw4C3Ui0A6xh/87JlkBnC
	 OPRvMweTFGEt9+ScNeQP7bihRmYVWta1oa7SzLT+keGvXkPmIbHgX1VvJEhFKc5mE/Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DEFAF8010B
	for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2026 02:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DEFAF8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c388bd66adba00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
Subject: ucm2: MediaTek: Add SOF UCM for mt8186 mt6366 rt1019 rt5682s
Date: Sun, 19 Jul 2026 02:17:06 +0200 (CEST)
Message-ID-Hash: KWFSTZI7GF2FBXSLNSGP4UCFYYFPRE3O
X-Message-ID-Hash: KWFSTZI7GF2FBXSLNSGP4UCFYYFPRE3O
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KWFSTZI7GF2FBXSLNSGP4UCFYYFPRE3O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #814 was edited from dangowrt:

Add a UCM profile for the SOF variant of the MediaTek MT8186 (Kompanio 520)
sound card `sof-mt8186_rt1019_rt5682s`, as found on Corsola-family Chromebooks
(e.g. google,steelix).

The card exposes:
- RT1019 amplifier -> speaker (SOF_DL2 -> I2S3)
- RT5682S codec -> headset jack: headphones (SOF_DL1 -> I2S1) and headset mic
  (SOF_UL2 -> I2S0)
- MT6366 built-in digital microphone (SOF_UL1)

RT5682S DAC/ADC routing follows the existing mt8195 mt6359-rt1019-rt5682
profile (same codec), with board specifics:
- MT6366 internal DMIC needs one-wire mode (`Mt6366 Dmic Mode Switch`)
- headset-mic capture (SOF_UL2 -> I2S0) needs the AFE
  `UL2_CH1/CH2 I2S0_CH1/CH2 Switch` interconnect
- a moderate analog capture gain for the headset mic

Tested on google,steelix (Debian, PipeWire): speaker, headphones, headset mic
and built-in mic all validated end-to-end; jack detection works.

`alsa-info.sh` output (per CONTRIBUTING, for the UCM validator):
https://gist.github.com/dangowrt/4d530e8542542a6611a03b1849a7c8bd

Note: this card is not yet in the `alsa-tests` validator set, so CI may not
fully emulate it until the alsa-info above is added there.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/814
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/814.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
