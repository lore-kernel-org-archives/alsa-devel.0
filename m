Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA4C44521
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2026 00:12:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F085601FA;
	Sun, 19 Jul 2026 02:12:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F085601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784419971;
	bh=ibmSW5i0C6rK898l88axJnEnibRIPnGuH/qofSarwp0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Tr19357fTBkmR4bHte/entQU69+NH06RnmtDc+GxEuZzf+0p2e8vDjVqYPGTW2gA8
	 rUD/ZyHzma1vk2QbykStsqm+X+xsjV4v6TwYqzoMWHBl/I95rTUtU5F09PGmtjX1B6
	 Ef1SoNdVfKEnqxgOFdWkSmmJpwmjT3Fljtn9VygQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA145F805FA; Sun, 19 Jul 2026 02:12:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59D79F805FF;
	Sun, 19 Jul 2026 02:12:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA06CF80551; Sun, 19 Jul 2026 02:12:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784419930;
	b=Oysg6bTOnDIv9LFlLWEkRURo5i1kVTijMkSnx90s2GsKB3gD1j8OVNR0QdBOPXfMP54N
	 bXwDcgIvjBKXoj+A6yMVJSCvTn4OIhToFsuQGeqIkdLMrt7u8w9UQjz5KEl7KvbvY6M5a
	 uVyMraJTva7C8bpyEy0u17gf3l1saC7vctmgIiS6cJn6q4Fu0tlIf8bCrz4VvUQg1w9Ba
	 LAylzLHEP3mbvnBJ8D+FYMetmUOF9vle9bgg+8xgaa+v+8gakWdU1phwGDgAz7Wot2jk7
	 I9vOY61DjAFMhnbyF/75JJnNVw/amqqtj+jnuct2fn7ZhztdqKrZaPyClSuuRHDKowQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784419930;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ibmSW5i0C6rK898l88axJnEnibRIPnGuH/qofSarwp0=;
	b=UuhaAwxonsR8BVfD6/OWXgD/sLpoBInuBEoGQQC0pc8YU8yFgvt18kiOQPTeSzn4DhHT
	 GR4zsKUkPPiyhysu5Jm17eAuRXm5l/TBYt3XlbSRxesEP/D+kp3vEYMzSZN5BwCHMcZA4
	 1nEoTCyQeq7Ez/M3mvca5II0scse6d6Kyxuk3FiD6e1dVgcP9GZhKn74bnGpMdeSaXmmt
	 yAq/Qd1WAjOsBLXLbdUWFyww9szBe2XvSLrbgo8/t49fp8rQm2i+Oh4GgPnGf0vafvHtK
	 rHMkQw4i0oaaFNMBIZM6rvLDtQ3NoNgZLKoWdABvTfd9UWb+PM2Udt3AedNIE5zeCQg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 50447F80246
	for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2026 02:12:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50447F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c388789463b400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
Subject: ucm2: MediaTek: Add SOF UCM for mt8186 mt6366 rt1019 rt5682s
Date: Sun, 19 Jul 2026 02:12:11 +0200 (CEST)
Message-ID-Hash: W4IEP2YZHIU5MRVYKE3HU7PWE6XB55VO
X-Message-ID-Hash: W4IEP2YZHIU5MRVYKE3HU7PWE6XB55VO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W4IEP2YZHIU5MRVYKE3HU7PWE6XB55VO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #814 was opened from dangowrt:

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
  

Note: this card is not yet in the `alsa-tests` validator set, so the CI may
not fully emulate it until the alsa-info above is added there.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/814
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/814.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
