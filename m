Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6BD1D88A
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:56:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4484860208;
	Thu,  4 Dec 2025 08:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4484860208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764835006;
	bh=mg08xd9lJYMsUX+XoFOYQ2R/x0a76A4Jr847X9GV5dA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DXdjP7GZOwP9OO/XIJsxdemrgQuDtqnCwuyZNWGwl433AFilx0U+q+9Tf0a7/ByNl
	 ywWLCOOR+qDX9Sl04C6/bV+948ot+H/xDWs21a+cej56cvHLZc9H9me9lTFbSD0nU0
	 kohp7j9Pf8gNt5ib/VqBJEwLrp/sRx+BjFyMrjsg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32282F805CA; Thu,  4 Dec 2025 08:56:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AEE93F805C6;
	Thu,  4 Dec 2025 08:56:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE658F80542; Thu,  4 Dec 2025 08:55:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6629AF8025E
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2025 08:55:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6629AF8025E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187df4091567b900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/653@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/653@alsa-project.org>
Subject: ucm2: sof-soundwire: fix a case MultiCodec1 string is in
 HeadsetCodec1 string
Date: Thu,  4 Dec 2025 08:55:58 +0100 (CET)
Message-ID-Hash: T5JWJ4FRACMFKFGJELLZFTPKHPKU4MAJ
X-Message-ID-Hash: T5JWJ4FRACMFKFGJELLZFTPKHPKU4MAJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T5JWJ4FRACMFKFGJELLZFTPKHPKU4MAJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #653 was opened from shumingfan:

ucm2: sof-soundwire: fix a case MultiCodec1 string is in HeadsetCodec1 string

The component string is
Components    : 'HDA:80862822,80860101,00100000  cfg-amp:1 iec61937-pcm:7,6,5 hs:rt713-sdca mic:rt713 spk:rt1320'
Therefore, HeadsetCodec1 string is 'rt713-sdca' and MultiCodec1 string is 'rt713'.
The Regex and String should be swapped and check again.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/653
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/653.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
