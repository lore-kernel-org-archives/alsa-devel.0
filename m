Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9518BC35FFC
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Mar 2025 12:17:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E94860283;
	Sat, 22 Mar 2025 13:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E94860283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742645831;
	bh=n0OJClXIKOU7nlJyWKrMXEt8xY2mpcTVOmZTHV5Vqdg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WOxt2didDzihL94cbI5hz+e2E5aTGpEnPhrVcVKO8oLYdTJRhnFDcvWzkgb/Y2r/9
	 /TpfNSes8N1D4NpOlnY2riRUO8IX05VjcGomACYsFdW9hK2MhsnDszg9nzGo8fLL3j
	 XQvMkeHhe9VZ7n/MEh3t+zW410b4WxJNnsaBjdps=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C472F805C2; Sat, 22 Mar 2025 13:16:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74337F805C1;
	Sat, 22 Mar 2025 13:16:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4434AF8025A; Sat, 22 Mar 2025 13:16:32 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 882AAF800B5
	for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2025 13:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 882AAF800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182f1f1cfff24100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/525@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/525@alsa-project.org>
Subject: sof-soundwire: rt1318: add playback control switch
Date: Sat, 22 Mar 2025 13:16:32 +0100 (CET)
Message-ID-Hash: OOOT3DK3MEP2T3UQQKXV4JKENT2OQ2S7
X-Message-ID-Hash: OOOT3DK3MEP2T3UQQKXV4JKENT2OQ2S7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OOOT3DK3MEP2T3UQQKXV4JKENT2OQ2S7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #525 was edited from shumingfan:

rt1318: add playback control switch

[v2] This patch defines a remapped one 'rt1318 DAC Playback Switch' whether the cases are in one amp or two amps.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/525
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/525.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
