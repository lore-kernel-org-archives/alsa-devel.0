Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF7EB64D9
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Jul 2023 07:36:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B28DC7F1;
	Fri,  7 Jul 2023 09:35:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B28DC7F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688715403;
	bh=ngiEgkYK7ySolai9wW68canKG3JxLVmENycSOl9PzLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o01FwVd4mvFS8FvvQ4/Cgg6+npv/WcAevhuSU+L4mUHgTUVF6m/yJV9Q6WlEshsdZ
	 mPtlJmr2ANLory0q4GO+aIb/tNRBupRRdo/BmwDQHlG8f4TqL+rtn9Jiqnz5pZVgrO
	 DIVAYj3id3i+XTkvOBXqBuziIi0H/ZQZ5Klm+aNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83673F80272; Fri,  7 Jul 2023 09:35:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E9B38F80125;
	Fri,  7 Jul 2023 09:35:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9666F80125; Fri,  7 Jul 2023 09:35:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62D12F80093
	for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2023 09:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62D12F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oxeXnpDh
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D4DBA617AF;
	Fri,  7 Jul 2023 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3787EC433CA;
	Fri,  7 Jul 2023 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688715319;
	bh=ngiEgkYK7ySolai9wW68canKG3JxLVmENycSOl9PzLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxeXnpDhClySaU6OWlU7dZSI5c6p79N+YHy2XZfHg/VpD5U+Pobs5W0IuRX0k8T5+
	 pyptW7rPvsuoFeW37J0fSXj6SI4Hc6f4Z0cPAsmyVaiwPgOHZguLFjvt7dbEaBNVKx
	 h0nGy+NdQ1HYAZCcCUg7vT3PNbOqNb2dqbN7Qj4mGyoNe/uj9Mx5K2WqWeHgaNRfSk
	 IepdqSYaVm0+1BVdpNt79mJkoMDmbjZyfhU4/8meJ2bzCTNy9axKdKgtzkq+5Y/7Wn
	 Unhi+g4vqzVlhbaKS33h/CBfkh7vyxtnrvNQmxhuRL+Hx11jkl8xdNh/MXvsdtD6uc
	 ix61AaZSTc05A==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan@kernel.org>)
	id 1qHg0G-0004Mn-1k;
	Fri, 07 Jul 2023 09:35:44 +0200
Date: Fri, 7 Jul 2023 09:35:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
	linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
Message-ID-Hash: OOLWO7HUII2J7SFI6PMHXLYJH5QG6HOG
X-Message-ID-Hash: OOLWO7HUII2J7SFI6PMHXLYJH5QG6HOG
X-MailFrom: johan@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OOLWO7HUII2J7SFI6PMHXLYJH5QG6HOG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 05, 2023 at 01:57:23PM +0100, Srinivas Kandagatla wrote:
> dB range for HPHL and HPHR gains are from +6dB to -30dB in steps of
> 1.5dB with register values range from 0 to 24.
> 
> Current code maps these dB ranges incorrectly, fix them to allow proper
> volume setting.
> 
> Fixes: e8ba1e05bdc0("ASoC: codecs: wcd938x: add basic controls")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/wcd938x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index faa15a5ed2c8..3a3360711f8f 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -210,7 +210,7 @@ struct wcd938x_priv {
>  };
>  
>  static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
> -static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
> +static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);

This looks wrong, and indeed that forth argument appears to be a mute
flag. I guess that one should have been 0 (false) here?

Headphone output also appears to be way too loud by default with this
patch (alone) applied. Perhaps it's just the default mixer settings need
to be updated to match?

It looks like you're inverting the scale above. Perhaps that's intended,
but some more details in the commit message as to what was wrong and
what you intended to do would have been good.

Johan
