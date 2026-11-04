Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC98606A31B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=SbxkIVKr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAr/cmtK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE3D2601C6;
	Wed,  4 Nov 2026 13:25:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE3D2601C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793795152;
	bh=6WUKBM6dDnnt7MH9CFPzXIa9c+niFkyXXKg+byRVGpg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SbxkIVKrxgBPUHGrrK4qSFWjiWU1AtrZaFRvtnKAYgczv+bgGC40QUgRClULuBcS1
	 V/jtiF+4F/N3UVw5ecWfMcYJ01smVRD6I2Y6XBKVcjxmrrjLZOrxrObtyxKaL9CPG0
	 083BLopD5OqVLrMqjGyPsBYSJcioT7aGoBLTnG+s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01999F805FC; Wed,  4 Nov 2026 13:25:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3D85F805FC;
	Wed,  4 Nov 2026 13:25:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14D7AF805AA; Wed,  4 Nov 2026 13:25:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793795112;
	b=LA2yA0CL1QqbEcecKRGVzMxFbl/fmtQBbQdJQG8GN8JQTkauwszMC2RM5AuAf1he0XiI
	 3qoeHksYVeYcZgK6VDMhkwcy0B8Xw1kXhY/nIzklu/yFstKlsiNA4uQMiofef7Z7TVTx7
	 L7qsFiNA9/8UFqRFdX7aISpC792Ik1F4y1RXs0l4IGYM1B3AaTqHBv6o6h8y0zdkdG3P6
	 58dSnUNE4kru4ipRleFzNYOY/tXEhC04XIujv8CRN0Df759NGtI6c8JEmC7oi2boT3MeT
	 orP2Ui9Rj//5QJtfE0mJxXLAeLimYMxbDVrLrU/Nid4/28Ifjjq970wZ/PZ+GmUZeuA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793795112;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=6WUKBM6dDnnt7MH9CFPzXIa9c+niFkyXXKg+byRVGpg=;
	b=JXinED+24LEX47yKaSZmfPeG2YI+vQw3/KWs6b6n34UmXBtyImAVeTMJ6rGWDOftPNC8
	 ZoFI8FGXAxCWE3QPNkcWKadvD1uwETH97NwnW3dHmVUrO6Eb8nZUkSktDm9Fc0Lm37Nbr
	 pf72AdJ5+rR5nBDIyKAcVTSRqkxva4lXyAm9jXBagLDLGR9xpGJW+sguGXLJ8HA2mJsdX
	 g08Dezu216hKBMSmLrRaw3/ebYCBna73cGwutRk2NCwlgdQ8qFlJglTeGDDdDCRRy8VOp
	 TCFcgb10vke5cvEOKA1fGj/H5yVzHqkIXFWsOk0aZR5EJCC2wbVvYSu1oWehCfKBfHA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="bAr/cmtK";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4E42F8055B
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 13:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4E42F8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bAr/cmtK
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 210256143E;
	Wed,  4 Nov 2026 12:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18AA1F0093A;
	Wed,  4 Nov 2026 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795107;
	bh=GI5lz7M74P33CcajK48AfqCeXID0+1wyAaA4TQotWZM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bAr/cmtK1bh6VFdJha9aSIOcP5qePZfQ8g+LBWeLSoZMexfFdEbj+VVaOvwNP48i4
	 60sSwsmO3lvEqQd73fV3xQcOW62oi7D+5XQpZwePmzfL/58LxdHVwo7rFstfjrbjqj
	 +EGzddjDCkQPx3hJkv2K/6s33NX88G/FisDvUXgoKsAHdv1/pOGGPmI22Xe0az/o6D
	 rNQ/FrYmLz2jT2g1fgF5U2mHIYdLZEfx9lmwquGHnt/Mzwl+jJ40/4BN+Wu/Eitx41
	 EhVIF1BQmisaSFkp+i9ca07qRkfx3EVjhouRfZLDYjebursS3MXRM5ZTTIpjARRXPz
	 0+a6JSEhAo7Ow==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id A4E1425F40FD;
	Wed, 04 Nov 2026 12:25:05 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, flove@realtek.com, oder_chiou@realtek.com,
 shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20261104025321.822219-1-jack.yu@realtek.com>
References: <20261104025321.822219-1-jack.yu@realtek.com>
Date: Wed, 04 Nov 2026 12:20:32 +0000
Message-Id: <179379483277.2456854.13813848595708930532.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2353; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6WUKBM6dDnnt7MH9CFPzXIa9c+niFkyXXKg+byRVGpg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeqyjedFn9XXp/OXt7d3PC8vNK2jstXc6sDNt9dftsn
 5dMDc97O0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRWbMY/nv7FG+cdnLW/eK8
 5qoLV1q3vOif5X2j4oNr8eT806aVovMY/nB0v1xqI95SG1+7dcoKh6u3vyb8XsHcOqeY4QH7DVf
 jKh4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: Z6S6W66LE4ZYGIB6J25MNNHG7VVOYGME
X-Message-ID-Hash: Z6S6W66LE4ZYGIB6J25MNNHG7VVOYGME
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z6S6W66LE4ZYGIB6J25MNNHG7VVOYGME/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> RT1321 VA2 needs a different flow from VA0/VA1:
> 
> - Load the VA2 MCU patch code.
> - Update the VA2 init settings and add the companion mode settings.
> - Before R0 calibration and R0 load, switch to TV mode and disable
>   phase sync/silence detection so the DSP FW serves GET/SET_PARAM.
> - Take the VA2 advance gain from the AFX1 header of the DSP FW.
> - Extend the readable/volatile range of the DSP status registers.
> - Increase the BRA sections to 16 for the 14-section DSP FW package.
> - Hold a runtime PM reference in the kcontrol put handlers to avoid
>   runtime suspend in the middle of a long DSP access.
> 
> The VA2 MCU patch code is submitted to linux-firmware separately.

> @@ -1291,6 +1305,12 @@ static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
>  		regmap_read(rt1320->regmap, cmd_addr, &tmp);
>  		if (tmp == 0)
>  			break;
> +		else if (tmp != 0x1 && tmp != 0x2 && tmp != 0x3) {
> +			dev_warn(dev, "%s abnormal val, tmp:%x", __func__, tmp);
> +			for (i = 0; i < 8; i++)
> +				regmap_write(rt1320->regmap, RT1321_FW_PARAM_ADDR + i, 0x00);

This affects all the parts, are you sure it's right for RT1320?

> +	if (is_va2) {
> +		regmap_read(rt1320->regmap, 0xc5fb, &reg_c5fb);
> +		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
> +		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
> +		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
> +		for (i = 0; i < 200; i++) {
> +			regmap_read(rt1320->regmap, RT1320_POWER_STATE, &reg_c560);
> +			if (reg_c560 == RT1320_K_R0_STATE)
> +				break;
> +			usleep_range(10000, 15000);
> +		}
> +		dev_dbg(dev, "%s, RT1320_POWER_STATE=0x%x, i=%d\n", __func__,

Perhaps rt1320_check_power_state_ready() could take some parameters?

> @@ -1660,6 +1709,30 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
>  		goto _finish_;
>  	}
>  
> +	if (is_va2) {
> +		/* Switch to TV mode */
> +		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
> +		regmap_write(rt1320->regmap, 0xcd00, 0xc5);
> +		/* disable phase sync */
> +		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
> +		/* through SRC */
> +		regmap_write(rt1320->regmap, 0xc5c4, 0x12);
> +		regmap_write(rt1320->regmap, 0xc570, 0x0b);

Do we need to clean up in the error handling path here?

-- 
Mark Brown <broonie@kernel.org>
