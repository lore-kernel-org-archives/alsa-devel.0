Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453DED62067
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:53:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A36D410BE;
	Tue, 19 Nov 2024 10:52:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A36D410BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732009981;
	bh=spd5lTwRjtuXMRGJzZLIvFK+Z7xQyWm0N8yUNeytWfg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DFX/kaMmr87rNhxdZgRtk96R3iJO10QedW2NULzxMa6E7GXzTa0fbdQvacy85ZMjX
	 4MCUMnAy5zF7EyiiziAWkRMTb4+lyABk3VUgWB1lVzoNW9AVwpyGsc/lEDfeflY2b/
	 hVvjpabLT4pCrxXMqeQqj+Op6bOTKZ4aDU5TMSw0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0B23F80568; Tue, 19 Nov 2024 10:52:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE0CEF805BB;
	Tue, 19 Nov 2024 10:52:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B455EF8026D; Tue, 19 Nov 2024 10:52:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D3A9F80134
	for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2024 10:52:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D3A9F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732009933970105410-webhooks-bot@alsa-project.org>
References: <1732009933970105410-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: cs42l43-spk: Correct PlaybackPCM and routing
Message-Id: <20241119095217.B455EF8026D@alsa1.perex.cz>
Date: Tue, 19 Nov 2024 10:52:17 +0100 (CET)
Message-ID-Hash: 2BWGW4B2O4ZCN5L46QX7EH5F225AQ3AG
X-Message-ID-Hash: 2BWGW4B2O4ZCN5L46QX7EH5F225AQ3AG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2BWGW4B2O4ZCN5L46QX7EH5F225AQ3AG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #465 was opened from ujfalusi:

For speaker the correct PCM device to use is "hw:${CardId},2", the "hw:${CardId},0" is for headset playback.

Adjust the routing as well since with :0,2 the DP6RX1/2 needs to be selected for the speaker.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/465
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/465.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
