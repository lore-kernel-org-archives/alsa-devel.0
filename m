Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94208C4450A
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2026 00:18:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F7F460209;
	Sun, 19 Jul 2026 02:17:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F7F460209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784420287;
	bh=wuFUYhFB1+7WPKBFORKU9wV+2M23Jx+0LV4KpoqSnHo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hR83DNPLEb0Ssr4DtxA8ypY47EDHBND1xd7mtNE+ldvdiMHPuvUY5Kx2DV2Pj98Z+
	 JkSSKocUNvQtCqmO49lSAAZbjTyIXMzUXCoPdZVFhWvdKo/XZv4qDsMfGeB1red/bI
	 gqata8dypHfriHyOX+U71btaoAOL0SZJgBHHOHO0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C6605F80606; Sun, 19 Jul 2026 02:17:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CDDAF80606;
	Sun, 19 Jul 2026 02:17:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21CCCF8057A; Sun, 19 Jul 2026 02:17:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784420260;
	b=k+tAAgwozMHKFmSEsvQKLpp6vJyyrxenG0xNt1lk8ZxEaFbx6vGG5CbHFMgtaoYH8B+1
	 ej8H1hPdiZVOXyUjXDWx3XeFwAfhYzVIgHgOfpw3PQ1xA4UC1OKi6lkA7ELFkIPtmTkAp
	 WqPwjLto0Ka7KRuegFdhizl/UjWUSFew7TxYOOIng+Rh5So4G2ATAjpXobO29wVYODLMd
	 0nKykNBOBjLOB0qiU7v48GCMjS67uIo2zNxxfzuyoeRt/Jw5TLm3ednvqw7xt/vetXo7x
	 Z04ucmhcJ51nY6L6LxXTyAumMzmHsNE1l+n/Z0ySzDh0AheHIrZDMXoCBR+mJsiozyg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784420260;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=wuFUYhFB1+7WPKBFORKU9wV+2M23Jx+0LV4KpoqSnHo=;
	b=BguWp2SugkGt3oi2NofGTyQzRpPVHE8vR7me6Y9L/BxCt7mBH9mgiM6PJMnH6gi89vC+
	 k0YMcMXQ3gzWEd35w90Tnye5hAWxO5bdsSytaRAEoodG9DnOqi6k4+ulBeT3z9S87r3oM
	 5TeFPpfiqE7nxKlb9L35ixUJsPXmWVRF8YnTBwI+osjIbgaPUR9H0c0IQU6rzJcG4lbOm
	 HWzUTW4XZHGEG96EWYuIHPb4LdJ4PT4eFm5PBHWeU6Gduv7GsE9XMoz4SeS88X5amCMMt
	 4j36Zh5lEzavyFlnXOjgGfPMdqVV0Y0UxYjYh6BKVqUBiU1sPEbukfhNmNg+cwhX14w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AEC91F8010B
	for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2026 02:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEC91F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c388c596850000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
Subject: ucm2: MediaTek: Add SOF UCM for mt8186 mt6366 rt1019 rt5682s
Date: Sun, 19 Jul 2026 02:17:41 +0200 (CEST)
Message-ID-Hash: UDRMJRD4GRQQ54K6KUPK2ASHWG6EYYCJ
X-Message-ID-Hash: UDRMJRD4GRQQ54K6KUPK2ASHWG6EYYCJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UDRMJRD4GRQQ54K6KUPK2ASHWG6EYYCJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #814 was edited from dangowrt:

Add a UCM profile for the SOF variant of the MediaTek MT8186 (Kompanio 520) sound card `sof-mt8186_rt1019_rt5682s`, as found on Corsola-family Chromebooks (e.g. google,steelix).

The card exposes:
- RT1019 amplifier -> speaker (SOF_DL2 -> I2S3)
- RT5682S codec -> headset jack: headphones (SOF_DL1 -> I2S1) and headset mic
  (SOF_UL2 -> I2S0)
- MT6366 built-in digital microphone (SOF_UL1)

RT5682S DAC/ADC routing follows the existing mt8195 mt6359-rt1019-rt5682 profile (same codec), with board specifics:
- MT6366 internal DMIC needs one-wire mode (`Mt6366 Dmic Mode Switch`)
- headset-mic capture (SOF_UL2 -> I2S0) needs the AFE
  `UL2_CH1/CH2 I2S0_CH1/CH2 Switch` interconnect
- a moderate analog capture gain for the headset mic

Tested on google,steelix (Debian, PipeWire): speaker, headphones, headset mic and built-in mic all validated end-to-end; jack detection works.

`alsa-info.sh` output: https://gist.github.com/dangowrt/4d530e8542542a6611a03b1849a7c8bd

Note: this card is not yet in the `alsa-tests` validator set, so CI may not fully emulate it until the alsa-info above is added there.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/814
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/814.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
