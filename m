Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFDEEB57A
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jan 2026 06:09:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AD5860183;
	Fri,  2 Jan 2026 07:09:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AD5860183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767334193;
	bh=8bnVVoLInBQSNs7evCXtRuoy2GJ3l2I8POBwnETKuQU=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fULF8IYdy4azirpcuRA3QZDlLlEfxjvPINPLuJHHHALO+G972gfccSh82vqXbCwa5
	 3UkPB8CVDwR9v1+WLPssuKF46Bs2GCcmSGxmKzL4UQ98G6EWASQeDet7gr9mrgbSO9
	 ZJKBMXVN1vcyF4d9NOJauvN6YDIcDTS3nXhAFlNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22176F805D2; Fri,  2 Jan 2026 07:09:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1E00F805E4;
	Fri,  2 Jan 2026 07:09:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C79DF8032D; Fri,  2 Jan 2026 07:09:06 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E795F80086
	for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2026 07:09:06 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [alsa-devel] MOTU Midi Express XT
From: cruel.yak.duil@protectsmail.net
To: alsa-devel@alsa-project.org
Date: Fri, 02 Jan 2026 06:09:06 -0000
Message-ID: 
 <176733414601.20.12467795621587134001@mailman-web.alsa-project.org>
In-Reply-To: <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
References: <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: RG4PTRRTESYCCTECKUSMHUNNQ7BOUHWH
X-Message-ID-Hash: RG4PTRRTESYCCTECKUSMHUNNQ7BOUHWH
X-MailFrom: cruel.yak.duil@protectsmail.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/44ZCAFHYYGXAQGW2BB76I3R2ZWYN35DK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I like how the article focuses on adapting the ALSA mtpav driver instead of ditching solid hardware. Sharing this reminded me of a Connections Game moment when my PCIe serial card loaded fine but ALSA apps ignored it until I fixed IRQ routing and rebuilt the module.
https://connectionsgamefree.com
