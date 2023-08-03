Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC7C00528
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Aug 2023 08:46:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A89E82B;
	Thu,  3 Aug 2023 10:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A89E82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691052394;
	bh=vxO92imHE2Z6sjCwWRr0/ol9TddebHGfHxEdF6lX4Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cUlBoPIy9FbtQPvAXOg17zd6kTgVHNgrlS3ZlARX4I3dzQGHOjwpvnp67dsSSgNin
	 SaZnlF05X1XX5UjYqeeUV7BKmlFqZAcwjJAfIrmpTdtfT3UWCMa8gti3TRzJkh1LDp
	 IXOxwSlbiMPFROIx/Kx3J0JHw79nnrqI27Y2h4y4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C529F80149; Thu,  3 Aug 2023 10:45:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68D09F80149;
	Thu,  3 Aug 2023 10:45:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7366AF8025A; Thu,  3 Aug 2023 10:45:12 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76A63F80149
	for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2023 10:45:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76A63F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=MZiaBWeR
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id AFCFE6607194;
	Thu,  3 Aug 2023 09:45:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1691052308;
	bh=vxO92imHE2Z6sjCwWRr0/ol9TddebHGfHxEdF6lX4Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZiaBWeRUkj5aVVhzsRRnycAHQC7M9XDtCl9LBSlklYRbsRx3RkjVcHXEeimdh87b
	 Dt4zDkg6tBESami9zmzfy1Q/UdD3uACQOfVv5QXJBMie2UGDPHuV0b7psTJ6HVr/46
	 CcOpwZhb4z0Ng69N4sE0QX/Gq05f/IEMvMcfe5HmAgMte1AVoKzZzODx4L/2Cco5+e
	 abolvidM70Q3yO67p9Gm4gaTE0afk/p836YgCyIRTeE8l8BXjdIUYVdmIZ5em6+kV4
	 RveIKgcbHQO8IfwqY3DcPX7tNdMaOIFzkqo/WfIjTT/VMAPGE/OwYWaHFTren7bk6G
	 5+dAdWJVBWAVw==
Message-ID: <4a340bcb-0459-f616-9a7e-c80f4b2ac21b@collabora.com>
Date: Thu, 3 Aug 2023 10:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Remove unused mutex.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20230803083908.9DxbPvOK@linutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803083908.9DxbPvOK@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: CTS5RL3NAHY2BWV7SUN5RLCMZKJ5B3VB
X-Message-ID-Hash: CTS5RL3NAHY2BWV7SUN5RLCMZKJ5B3VB
X-MailFrom: angelogioacchino.delregno@collabora.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CTS5RL3NAHY2BWV7SUN5RLCMZKJ5B3VB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Il 03/08/23 10:39, Sebastian Andrzej Siewior ha scritto:
> The mutex mutex_request_dram has no user.
> 
> Remove mutex_request_dram.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


