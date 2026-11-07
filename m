Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D23606A32C
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=bVYnFf2z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb0MMwbB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8198D601E2;
	Sat,  7 Nov 2026 17:56:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8198D601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794070624;
	bh=qFJHcBhe/oBOuqqtkClY8sHWPbblGuoNwcwOtBOZXf0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bVYnFf2zODR6WlvOGAViG1AKhkZ5/GJqpSkosHQca/aazEmS/21CVeY1Wwrg2z0PX
	 vcVMvoy90bONTO3Cjq7/g193x8Wy4D2oV+dlwx+Ve3A18cjfj9mD1723gfa2Trd7UQ
	 rxmJn94MmvMuVk5uVJQFysdMKGFC2R1WjBQxe7kQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 901C6F805FE; Sat,  7 Nov 2026 17:56:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DDC5F80600;
	Sat,  7 Nov 2026 17:56:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32E00F805A8; Sat,  7 Nov 2026 17:56:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794070585;
	b=frRdmSHA/Gc09nKRWMgB4i3J76snsP2YQD3QBMqjIL6kLbCQ0AbgUEfmczzjdm68y9/c
	 yamwXA+Rae3/bT0FbPO3Wp6p/L28Vf1pCUedJmU2SOpejPkPpx5c22u2EVWdWBA6v+nzW
	 49u8DQS68v6peQ0KYQyCu3meexShOkDe0FazU8Jqvd5yIJzjKvoGsXRK2xWOmYoS6vVLx
	 OW8Wo2GQgnSb5rVzLCoWZ8LvfDhkwRRddEJnik/mtDrUCVqHZdedJi6Cq1DIaRorhbuEC
	 Bx8iEA5gp4vHC0rjR8BiK0EN1zGE+zyAuTczFS9wR+Felc7B0oHZNvRg2SBJVjnOkXg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794070585;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=qFJHcBhe/oBOuqqtkClY8sHWPbblGuoNwcwOtBOZXf0=;
	b=qaEeeS2o9oV/kvRguaDhNKQzc2GSyOHDyn5iGOg4QlnfqapeaAYNutamEnrq2phe3qem
	 1CDEWMsLJsLtw4LGeNJ76rxU79gGZ+cJ9w2JKPqOur4D24aS1qW50MoI7ZG5e550oerhH
	 jY3kV7t9gIihDYaSU4D03gxmOT96k7Ko3blzi0SR9lGmqETjZGTZru+s/3Tb4hSVTwTPN
	 vyIeh1+YTEH+0GWpOwwnAL6EiTHhmKS5D5ayC+kiaB2jhcOr0tHYzJWt4g7RddVn3PH4B
	 dG+3jW06wMf1NOWoY5Hi2j6vyJ8o920ABx4zw1f+uBz77bFB1xx5ELIAuEpji1y324g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Yb0MMwbB;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 38727F80538
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 17:56:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38727F80538
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Yb0MMwbB
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE0A140BF7;
	Sat,  7 Nov 2026 16:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8D11F0089F;
	Sat,  7 Nov 2026 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070580;
	bh=1kwV93pWO7WtdwTVA4+67bejngAfJiojIgP3xwWWbak=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Yb0MMwbBCZlNAAwTdThCMzovEWGpu9S6bxc54Iupfnv9cl5u38sCx5ifTQzhPlXnt
	 Qn1zRLs7478iOychzQbHQtuxndtZIpimQ/mvKm31x4Z2YBLwwUW/BJjsZROJOj/dt1
	 cfbQFjnyb/Gy/vYxhngqawu09CIDpc9L/DnC1MlM5PoIOrd2Wp0p2P1TT0ewu5/ngq
	 cIwUMaEoFXJMadhLhCrc5b/9rn5wmxcPgEAKOwY0HsJQlvWENcK6Tc0wNRdJ5L0UID
	 7wmx/tI6asjY/AUeg3d2UdhkXDoCGWeVC0yKk6NkVxgd3AulpFBBSA1KPEKh/3yj00
	 lpD4dXmNHj4NQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7E9AD2BC4BC1;
	Sat, 07 Nov 2026 16:56:18 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, flove@realtek.com, oder_chiou@realtek.com,
 shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20261105071831.1039515-1-jack.yu@realtek.com>
References: <20261105071831.1039515-1-jack.yu@realtek.com>
Date: Sat, 07 Nov 2026 16:56:13 +0000
Message-Id: <179407057372.3424803.728673534467493662.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qFJHcBhe/oBOuqqtkClY8sHWPbblGuoNwcwOtBOZXf0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeR+jxV/NHC7KaxndtfxMgWtL0X1Hd8bVE2DYe1Vl9b
 hU9kyU6SlkYxLgYZMUUWeKyuF/Wl7xew3dwYRvMHFYmkCEMXJwCMJE2Z0aGIwdfvdwqaXWvrLTy
 w/n5tu8/vud26s7ZpPW8f6bc1i7NqQz/NNODvm4pnO0kbXYmZdfnonMhnMrR/87N3HTeY5OE0Yu
 n7AA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 7HDP5SXLHZCMMZQ4CZDSWPR45D6V7XJK
X-Message-ID-Hash: 7HDP5SXLHZCMMZQ4CZDSWPR45D6V7XJK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7HDP5SXLHZCMMZQ4CZDSWPR45D6V7XJK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> RT1321 VA2 needs a different flow from VA0/VA1:

> @@ -1291,6 +1307,12 @@ static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
>  		regmap_read(rt1320->regmap, cmd_addr, &tmp);
>  		if (tmp == 0)
>  			break;
> +		else if (tmp != 0x1 && tmp != 0x2 && tmp != 0x3 && is_va2) {
> +			dev_warn(dev, "%s abnormal val, tmp:%x", __func__, tmp);
> +			for (i = 0; i < 8; i++)
> +				regmap_write(rt1320->regmap, RT1321_FW_PARAM_ADDR + i, 0x00);
> +			break;

This will break out of the retry loop on error which looks like a
success.

> +_restore_:
> +	if (is_va2) {
> +		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0xe0);
> +		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
> +		regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
> +		regmap_write(rt1320->regmap, 0xc570, 0x08);
> +		regmap_write(rt1320->regmap, 0xc5fb, reg_c5fb);
> +		regmap_write(rt1320->regmap, 0xc5c4, 0x10);

rt1320_calibrate() saves and restores 0xc570.

> @@ -2088,6 +2181,7 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
>  		regmap_update_bits(rt1320->regmap, 0x2000301c, 0x01, 0x01);
>  		/* Phase sync enable */
>  		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
> +		regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);

This is also updating the handling for VA0 and VA1.

>  
> +static void rt1320_companion_mode_patch(struct rt1320_sdw_priv *rt1320,
> +	bool patch_ver)
> +{
> +	struct device *dev = &rt1320->sdw_slave->dev;
> +	bool comp_mode_en = false;
> +	unsigned int val;
> +
> +	if (patch_ver) {

This could just be a return if !patch_ver.

> +			if (hdr_size && ptr_img->addr == 0x3fc2a300) {
> +				dev_dbg(dev, "%s, AFX1 hdr[0x20]=0x%08x (%*ph)\n", __func__,
> +					get_unaligned_le32(fw_data + 0x20), 4, fw_data + 0x20);
> +
> +				rt1320->l_adv_gain = fw_data[0x20] | (fw_data[0x21] << 8);
> +				rt1320->r_adv_gain = fw_data[0x22] | (fw_data[0x23] << 8);

There are various RT1320_AFX_HDR_ macros added but not used...

> @@ -2590,6 +2733,12 @@ static int rt1320_pde23_event(struct snd_soc_dapm_widget *w,
>  	unsigned char ps0 = 0x0, ps3 = 0x3;
>  
>  	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (rt1320->dev_id == RT1321_DEV_ID && rt1320->version_id == RT1321_VA2) {
> +			regmap_write(rt1320->regmap, 0xc04c, 0xe2);

rt1320_companion_mode_patch() writes 0x54 when companion mode is
enabled.

> @@ -2962,7 +3111,7 @@ static int rt1320_r0_load_mode_put(struct snd_kcontrol *kcontrol,
>  		ucontrol->value.integer.value[1] == 0)
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume(component->dev);
> +	ret = pm_runtime_resume_and_get(component->dev);
>  	if (ret < 0 && ret != -EACCES)
>  		return ret;

With pm_runtime_resume_and_get() we can't accept -EACCES since the
runtime PM reference is dropped.  Same in a couple of other cases.

-- 
Mark Brown <broonie@kernel.org>
