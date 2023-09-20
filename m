Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88897CE79AE
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Sep 2023 07:24:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75CFA950;
	Wed, 20 Sep 2023 09:23:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75CFA950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695194659;
	bh=PtxtSOuLocH/R6OOw7Mt+JsQORK0M7/eLndO6eSYUQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ea7+zyrR5tYfFvfKuGLBXw1NDyWn/64S25ApnMqn9ca0pAaqguPOBKknyggWdu5/5
	 5bRU37cKTfuZj4XRio8eV/P3tGv1FL7EzftkGvdh3p9VNvb0so4mtZKrLkUnyfS6XH
	 CQHPkba+108J077CwRo+i55w4Bxo2Ha4D1i3S3us=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 184C0F8025A; Wed, 20 Sep 2023 09:23:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B53BCF800F4;
	Wed, 20 Sep 2023 09:23:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34FCEF8025A; Wed, 20 Sep 2023 09:22:57 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42DF8F800F4
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 09:22:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42DF8F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EHgJvla6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 4F853CE134C;
	Wed, 20 Sep 2023 07:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7313C433C9;
	Wed, 20 Sep 2023 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695194567;
	bh=PtxtSOuLocH/R6OOw7Mt+JsQORK0M7/eLndO6eSYUQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHgJvla6Htp1tLIxB6zTpnzPafu6LQFd8TTE8dk8nRvjHieqjZkkB5OpWVtZI9oxT
	 7AbJUk+geiijXbfheQwzdOqDl9389UuMZ22mCmqkiJedN+50kt5ccZd/EzWGxYexQS
	 crzcHaDUdZXXuw4o/iMDZ5sfyT7zg0woZeIaXjNaMav/jyQmH35+jHzGucewRW6pmX
	 Q0TJt0lGVeAA3GRdu7JNLDht+RggZKYRTa669vvJUTqGbDQd1pq3450pwP4G4jA2s/
	 doS86lPW39TGc9QoL/2/nQmRHeea5FXruHu6uxzxtYF7W5OH1/xqO1hCNN0wyk4JCT
	 sSRZeTv9QmUrQ==
Date: Wed, 20 Sep 2023 09:22:44 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 34/54] ASoC: soundwire: convert not to use asoc_xxx()
Message-ID: <ZQqdxFfRwIU9iaAD@matsya>
References: <87h6o0s275.wl-kuninori.morimoto.gx@renesas.com>
 <874jk0qnga.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jk0qnga.wl-kuninori.morimoto.gx@renesas.com>
Message-ID-Hash: J3VO3IJXWU6UXRIXY7A2ZVSPOZMK3XPL
X-Message-ID-Hash: J3VO3IJXWU6UXRIXY7A2ZVSPOZMK3XPL
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J3VO3IJXWU6UXRIXY7A2ZVSPOZMK3XPL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 11-09-23, 23:50, Kuninori Morimoto wrote:
> ASoC is now unified asoc_xxx() into snd_soc_xxx().
> This patch convert asoc_xxx() to snd_soc_xxx().

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
