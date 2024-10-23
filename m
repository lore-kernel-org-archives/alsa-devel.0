Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A897D2E015
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2024 05:33:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B28E852;
	Wed, 23 Oct 2024 07:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B28E852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1729661598;
	bh=IUl8/VA1UaXKPGhrMFImpLpr1YuAPaXtMJH2JgermgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N3Tb4tZK2VVzJ9xSSgLs7ia+IjplduoWINvVEeFvBC03iqEfoLp20ULV+uhKv5zLQ
	 db7l3rl7f6GVDNWsuZsAnppP48NSkW6JBDVu9Frv2J/jmdeBzplVJga/kT+ozolsG4
	 Hj4OfBsCwdc9EXh5MVBQ4bFns7Qk2FeO13vvFcNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1AF2F805A1; Wed, 23 Oct 2024 07:32:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A4CBF805B6;
	Wed, 23 Oct 2024 07:32:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BF60F8016C; Wed, 23 Oct 2024 07:32:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4976BF8014C
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2024 07:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4976BF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Gme5o/UU
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1FE065C5CEF;
	Wed, 23 Oct 2024 05:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9954C4CEC6;
	Wed, 23 Oct 2024 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729661562;
	bh=IUl8/VA1UaXKPGhrMFImpLpr1YuAPaXtMJH2JgermgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gme5o/UUp9F2KR6bU1055VofbBLMez72a/thNWlYHF5TlhAgWjpd8gjJ2M9yvLNuQ
	 S+YuEMGpEwxGjw7t3PQj08Dj2hPIXancpPfx98+UKJGAak4eMHZ/M56Nyv0StrsS8F
	 SY3TvAwl8z/NUE0CgqcbPcRuT9vY/x2SCpevI9nSvHCsvnzz4y5etTqLpQs5amSGmE
	 sADTRJqTgUDe47Ld16AEe37IPFJvrKzhFyzAYtpogsnJjDxRe8B/JFL+JTQJGNDTq5
	 BGHj5nX53K+QQYV5c02vdoc/9vMJNXGomZjhs3PyQQBp8K2pksgMS/mAbtMowLSkXZ
	 PV9Iz+67gNcrg==
Date: Wed, 23 Oct 2024 11:02:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/7] ASoC: fsl: add memory to memory function for ASRC
Message-ID: <ZxiKdpeuIhe/DiV4@vaman>
References: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com>
Message-ID-Hash: WTLORZNP2Y2WEK4GEK5PU4RNRCDYGKQS
X-Message-ID-Hash: WTLORZNP2Y2WEK4GEK5PU4RNRCDYGKQS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WTLORZNP2Y2WEK4GEK5PU4RNRCDYGKQS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 25-09-24, 14:55, Shengjiu Wang wrote:
> This function is base on the accelerator implementation
> for compress API:
> https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59911-1-perex@perex.cz/
> Add it to this patch set.
> 
> Audio signal processing also has the requirement for memory to
> memory similar as Video.
> 
> This asrc memory to memory (memory ->asrc->memory) case is a non
> real time use case.
> 
> User fills the input buffer to the asrc module, after conversion, then asrc
> sends back the output buffer to user. So it is not a traditional ALSA playback
> and capture case.
> 
> Because we had implemented the "memory -> asrc ->i2s device-> codec"
> use case in ALSA.  Now the "memory->asrc->memory" needs
> to reuse the code in asrc driver, so the patch 1 and patch 2 is for refining
> the code to make it can be shared by the "memory->asrc->memory"
> driver.
> 
> Other change is to add memory to memory support for two kinds of i.MX ASRC
> modules.

Are there any patches for tinycompress to use the new IOCTLs here, I
would like to see those changes as well

-- 
~Vinod
