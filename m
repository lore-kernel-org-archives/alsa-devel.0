Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87251D6406B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Dec 2025 02:15:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C77F60223;
	Wed, 17 Dec 2025 03:15:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C77F60223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765937737;
	bh=LnIt4UhjHG3V2GulF4MC7A3xzopNBI/ZjbpO+2LcKPE=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=V+ML0sY+Om+YAECu7HQZ2t0E/e9xEwKsekWh9JMMadXyLBPYB6BhwJxfgz32HwvQi
	 F/6tBXVGxDE3yRzvs/IBDzyYyIiw9er8pXehWRJ701x/aamu8TXbH0apUwXzIXq6tp
	 cUhsHJnY20Wl76IzrMXF0zMJhV7eFzJU1+JL+UIU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC590F805D4; Wed, 17 Dec 2025 03:15:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 503F6F805C8;
	Wed, 17 Dec 2025 03:15:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6692F805A8; Wed, 17 Dec 2025 03:14:46 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 80182F8013D
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2025 03:14:46 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] ASoC: amd: acp: Audio is not resuming after s0ix
From: otiscavin3@gmail.com
To: alsa-devel@alsa-project.org
Date: Wed, 17 Dec 2025 02:14:46 -0000
Message-ID: <176593768640.22.9330224813705684643@mailman-web.alsa-project.org>
In-Reply-To: <20251202175616.2213054-1-raghavendraprasad.mallela@amd.com>
References: <20251202175616.2213054-1-raghavendraprasad.mallela@amd.com>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: NYER2KD3HHT3JU4OJ6UPUHHCHGG43EME
X-Message-ID-Hash: NYER2KD3HHT3JU4OJ6UPUHHCHGG43EME
X-MailFrom: otiscavin3@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NYER2KD3HHT3JU4OJ6UPUHHCHGG43EME/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

That subject line refers to a Linux kernel bug-fix patch for AMD audio on modern power-saving systems. https://sprunkiretakemod.net/
