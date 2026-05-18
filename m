Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C841BCD4F52
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 12:08:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13B2360217;
	Mon, 18 May 2026 14:08:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13B2360217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779106119;
	bh=3gFB2jUGtKWcc6tm1fUvus/xHAb0Jg6hLaGLppxpfKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jV/5y+i6n1Pd4bzOJG3DcOwoS4Os5oE1JTrNBtMPFSxxg0IRwam8aWJ8BLJeNlAu1
	 JOpVKio8RQqTD/6jg0ce7aEl/PzMGpC8JOxlkT6O6a31w64eDxaXtU4gdIpI3b6/r4
	 zDYNWGJHEDtfm7pxkbcM15A6qfElWrxbqCm5wwpQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FA1FF805F3; Mon, 18 May 2026 14:08:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00079F805E9;
	Mon, 18 May 2026 14:08:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FDCDF804F3; Mon, 18 May 2026 14:07:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8F7EEF8014E
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 14:07:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F7EEF8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sFRwT77T
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A26943EA9;
	Mon, 18 May 2026 12:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC37C2BCB7;
	Mon, 18 May 2026 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106071;
	bh=3gFB2jUGtKWcc6tm1fUvus/xHAb0Jg6hLaGLppxpfKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFRwT77TnOB/hZj5Y3EG4pgRCJqD5+POiR+lDN9HMJgpEIcWF5yzvN3zBm8e1K/aj
	 uJACY2ifTG/w1vZ3KWtq+yx4OdhNpmIIqu8cdhmdiHQ2hyKdWGMC1535HQ0hfdp7fi
	 k4EY23nxreSwXj7FrY33sr9424uTmKBPzpgEwxvTEBF9RlSbe8zzuWyfvETD02x8Ac
	 KKlcvF6GQ75cXN8N3R3jGogP94b9wnobqLpjk+8VDUfu6auK6gKMJCHzIzO3GlCwKL
	 WWhfRDkKtFu+vjTAeP2xvvZJs/tiDloKH9iz3jYx95k/p0+FQjNC0VwEFpnDvIgZKW
	 7Cc+m0t1ZzbuA==
Date: Mon, 18 May 2026 13:07:47 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ASoC: rt722-sdca: Add a control to support CAE
 firmware update
Message-ID: <0a778e5f-a5ec-44be-8ae1-e2bf91434349@sirena.org.uk>
References: <20260518025524.3323421-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrBJz9Tai0Vt6o5O"
Content-Disposition: inline
In-Reply-To: <20260518025524.3323421-1-jack.yu@realtek.com>
X-Cookie: She sells cshs by the cshore.
Message-ID-Hash: 4XDQ2PZW5PPRMZC2POUHB5NWQURFJMEW
X-Message-ID-Hash: 4XDQ2PZW5PPRMZC2POUHB5NWQURFJMEW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4XDQ2PZW5PPRMZC2POUHB5NWQURFJMEW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--xrBJz9Tai0Vt6o5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 10:55:24AM +0800, jack.yu@realtek.com wrote:

> Realtek CAE requires specific tuning parameters based on
> the system vendor and SKU.
> This patch adds a kcontrol to trigger the firmware loading process.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605160321.U3aaymLP-lkp@intel.com/

> - Fix the build error caught by kernel test robot. Replace the non-existent
>   snd_soc_component_get_bias_level() with snd_soc_dapm_get_bias_level().

The tags for the report only make sense to include if sending an
incremental patch, they don't make sense when sending a whole new
version since it looks like the bot asked for the new control which it
obviously didn't.

> +static int rt722_cae_load(struct rt722_sdca_priv *rt722)
> +{

> +	rt722_sdca_index_update_bits(rt722, RT722_VENDOR_REG,
> +			RT722_MISC_CTRL1, 0x8000, 0x8000);

Should the error paths disable this?  We disable it when we finish
loading but not in the error paths.

> +	regcache_cache_bypass(rt722->regmap, true);
> +	for (fw_offset = 0; fw_offset < cae_fw->size;) {
> +
> +		fw_data = (unsigned char *)&cae_fw->data[fw_offset];
> +		memcpy(tag, fw_data, 4);
> +		tag[4] = '\0';

We only validate that our current pointer is inside the firmware, we
don't validate that the record we're trying to parse fits inside the
firmware.

> +		if (strcmp(tag, xu_tag) == 0) {
> +			dev_dbg(dev, "%s: This is a XU tag", __func__);
> +			memcpy(&addr, (fw_data + 4), 4);
> +			memcpy(&size, (fw_data + 8), 4);

We don't validate the size AFAICT?

> +static int rt722_cae_update_put(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{

> +
> +	if (ucontrol->value.integer.value[0]) {
> +		if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF) {
> +			ret = rt722_cae_load(rt722);
> +			if (ret)
> +				dev_err(component->dev, "CAE load failed: %d\n", ret);

I think it'd make sense to return the error to userspace rather than
silently just reporting it as no change.

--xrBJz9Tai0Vt6o5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoLARIACgkQJNaLcl1U
h9AHDQf/c4ta1HJvM0Ne7uZQjeJLxt7SqzjRAwRA10wN7HGP+P8b03naajvVfWah
LZ96SsTZQPkUpNhzOJeqC8xLuhVtXCwMAcDGCIwtU4d3wHK4hAHAkjYUD15bqShK
OB36RMfnKE5Y/Qc+eBlKYQFOb5ITbDy9CWozGl8OGRrti6TM621or0om5N66FhCH
LSXXYGf40s6rGNIrbrvkTtTJzkCHebEiFsvMytks+uKmJXgsqOV4M7iDFOMDEqxs
esPLoEtZEf31muSPzAaBKjGqHmiXzMv8eMO7ncf6HOGGgS1edY1uxhvp6+5YR2he
dGfpa9ebKH7Okl4XmVqV9hxy/SnHlw==
=jewl
-----END PGP SIGNATURE-----

--xrBJz9Tai0Vt6o5O--
