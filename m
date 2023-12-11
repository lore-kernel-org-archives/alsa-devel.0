Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2AAC4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:27:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24551A4D;
	Mon, 11 Dec 2023 14:26:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24551A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702301220;
	bh=VKs1EvBmGIBwqV2FwfnKtoshqlh3tYuJXm/ZPmZw9mc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hurZkr7bpGlgLMHao7O4CuVzA0xUoYQ/iiI89Y1B4CHzYSYQl6AOWsujNY9y1dVeg
	 drJZwSeMSwP3aoPv6z/oX9wJRcjwjyT4az4cHaq+Wqb7fcqZ0x3l+us0tNldFHf6rb
	 i7Kb845lGE4xIC1ARftRys9ayc/ES7gKShIEQ30A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2591CF805EC; Mon, 11 Dec 2023 14:26:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E916AF805EF;
	Mon, 11 Dec 2023 14:26:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 448EDF80114; Mon, 11 Dec 2023 14:25:55 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0D808F800D2
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:25:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D808F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HtdhY6jF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2402BCE0F6B;
	Mon, 11 Dec 2023 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE84C433C8;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301145;
	bh=VKs1EvBmGIBwqV2FwfnKtoshqlh3tYuJXm/ZPmZw9mc=;
	h=From:To:Cc:Subject:Date:From;
	b=HtdhY6jFU/kTASHqTfLYT4x6ST54NyjoG3iXRxd3TyyTGiQxtkiy7dCdmMcfHtWzn
	 pkIJhCpB/1B6TiLofbbMGpTQq42JpzfNOu5b1m8plSRfFFI1vA7yS0e+eQrtO9A4t2
	 P1nv//3JLBryXto4tV/p3iu/0goPC7CorOhYa03i5fTEsdMNGQFTBKNJRKiR9Dow6W
	 /6OnJaGPtKzVzNaXQAfb/YjqP7QSDMpfd1JeIda2s1QYKQZLDXtDs+jSOx4Xoz5ZJb
	 nnw1YTxeJu7q3P7eWVEuCD9HrvzRM+xxgAaCrxeKaRUY9ekUurk4sunduxJnGUYPXd
	 PV0ZkwXGujsYw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rCgIq-0007Ff-0Q;
	Mon, 11 Dec 2023 14:26:32 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker digital
 volumes
Date: Mon, 11 Dec 2023 14:26:06 +0100
Message-ID: <20231211132608.27861-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: K22G25S5QTRHQRCKHABQJYAFLGGG6QSQ
X-Message-ID-Hash: K22G25S5QTRHQRCKHABQJYAFLGGG6QSQ
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K22G25S5QTRHQRCKHABQJYAFLGGG6QSQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a backport of the following series:

	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/

which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
interface.

Johan


Srinivas Kandagatla (2):
  ASoC: ops: add correct range check for limiting volume
  ASoC: qcom: sc8280xp: Limit speaker digital volumes

 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 sound/soc/soc-ops.c       |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.41.0

