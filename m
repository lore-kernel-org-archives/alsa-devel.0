Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EEEE7718D
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2024 09:13:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDBDC601D5;
	Mon, 23 Dec 2024 10:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDBDC601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1734945194;
	bh=h9YGRNmTt8k/JhSMq7DzlnJWXJOQxvg7m1qXhlH+PKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SHWJ8HG/NoQV28Nh0C3OvVKLxlF5ciByrJzjietXoaAmqhA4INpReMt1HnWc91vO0
	 RBbJCCpBCGZeODrGaO0Dq2cMXWeRowVKFpwtlKG/mB1YHsrkxeSapFStBDceQ7t2Rq
	 D0/dWWplJnUrog4bOpXZcuO8f6BEwuuqSZWCv6+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50D1EF805EF; Mon, 23 Dec 2024 10:12:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 389DBF805EE;
	Mon, 23 Dec 2024 10:12:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB0E6F805CA; Mon, 23 Dec 2024 10:12:27 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9A07F805BD
	for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2024 10:12:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9A07F805BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GhFZfv6m
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A7C94A40CAF;
	Mon, 23 Dec 2024 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B7BC4CED4;
	Mon, 23 Dec 2024 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734945143;
	bh=h9YGRNmTt8k/JhSMq7DzlnJWXJOQxvg7m1qXhlH+PKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GhFZfv6m5JwspC6e/Wp0S13HBTWlgYHpfBTKo+bbTfKCjZ/1W5LwqtrtdEhnYqfB/
	 nvRZh8WqgkJ1dtqOgLtAXYWUBRdkNW+gbIWSOMY+iDjBKTDG1CaI8Kr/+GRsNBS+v7
	 Y+uOX6v/Vx4MjR6TzyfAlT+SjcUc8VzWk6Gv8k9o4I/L+Y/npAPWUKL0yHXlW9LebS
	 UhKXxBCD+/cQ/b1acaVF3NzNmd2Y0iy5OdIoTFM5u6gT2i6iiU88J4c2wYGOUD1wC9
	 mMCy93D/kua5d2B3ITwhL3KdZdW7bfmrMCq9Fqns0Ce9x85WAnhKIw5ouk2RSiuN0h
	 nwyBu6q8jaW7A==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 sanyog.r.kale@intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Mario.Limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20241203092144.4096986-1-Vijendar.Mukunda@amd.com>
References: <20241203092144.4096986-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH RESEND] soundwire: amd: clear wake enable register for
 power off mode
Message-Id: <173494514030.830310.1951135316198778911.b4-ty@kernel.org>
Date: Mon, 23 Dec 2024 14:42:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
Message-ID-Hash: KHK63MYHJBKA2TAICBWIYRVV37KKWAQ4
X-Message-ID-Hash: KHK63MYHJBKA2TAICBWIYRVV37KKWAQ4
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KHK63MYHJBKA2TAICBWIYRVV37KKWAQ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 03 Dec 2024 14:51:44 +0530, Vijendar Mukunda wrote:
> As per design for power off mode, clear the wake enable register during
> resume sequence.
> 
> 

Applied, thanks!

[1/1] soundwire: amd: clear wake enable register for power off mode
      commit: 74148bb59e2064b87eb1715d9eb109adccb75316

Best regards,
-- 
~Vinod


