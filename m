Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8876CC54E41
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Mar 2024 20:47:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D4B5846;
	Sun,  3 Mar 2024 21:47:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D4B5846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709498843;
	bh=yblKaV7X6JAgSlLjZzlXSTKQEzZ6TADFXhXSAJkaLIE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EurTrEMHZavQAcFz+ujbdjpKLqaVM/+KN2EA5bsHsFiPejQfNRMH1oNW7/PQAEG1e
	 7q6FQ39IumhfhF/3sdd5+Ja3qfalyv35G2xYdZlfgvkPLxuth8XjHXmESl9+XlOTKJ
	 6cHN/WJ0dPg8T71e4oC9rjxCu0ReUyK6ctFKQVo8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B895F80588; Sun,  3 Mar 2024 21:46:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB15AF805A9;
	Sun,  3 Mar 2024 21:46:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3C67F8024E; Sun,  3 Mar 2024 21:46:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DBEC6F8014B
	for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2024 21:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBEC6F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1709498798332520485-webhooks-bot@alsa-project.org>
References: <1709498798332520485-webhooks-bot@alsa-project.org>
Subject: Scarlett Solo USB profiles missing or broken in 1.2.11
Message-Id: <20240303204644.D3C67F8024E@alsa1.perex.cz>
Date: Sun,  3 Mar 2024 21:46:44 +0100 (CET)
Message-ID-Hash: CPUKO5XSFIEYQD3CMGB2T7GSM2BDNZ52
X-Message-ID-Hash: CPUKO5XSFIEYQD3CMGB2T7GSM2BDNZ52
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPUKO5XSFIEYQD3CMGB2T7GSM2BDNZ52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #398 was opened from Slabity:

Prior to version 1.2.10, my Scarlett Solo USB profiles looked like the following, where I could select profiles that explicitly enabled or disabled either the Inputs or Outputs:

![goodaudiooutput](https://github.com/alsa-project/alsa-ucm-conf/assets/3788421/b1bbc857-82b6-4fa5-b478-0c00c26b281c)

As of 1.2.11, these profiles have disappeared and have left only a couple of profiles that do not provide the same functionality:

![badaudiooutputs](https://github.com/alsa-project/alsa-ucm-conf/assets/3788421/6c321638-3eb1-45ef-94a5-734c16477886)

Other devices like my GPU's HDMI/DP Audio and motherboard's "Starship/Matisse HD Audio Controller" continue to expose the wider variety of profiles. It is only this device that seems to have the issue.

I originally reported this on #346 as I thought it was related, but was told it might be a different issue. What makes me worried is the mention that this is "expected" now despite it breaking my audio setup. I can no longer select the "Digital Stereo (IEC958) Input" to exclusively enable the Input Device *without* enabling the Output Device.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/398
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
